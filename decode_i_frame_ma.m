function [hidden_data,S,idx] = decode_i_frame_ma(idx,bitstream)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function was created by 
% Abdullah Al Muhit
% contact - almuhit@gmail.com
% website - https://sites.google.com/site/almuhit/
% Please use it at your own risk. Also, Please cite the following paper:
% A A Muhit, M R Pickering, M R Frater and J F Arnold, “Video Coding using Elastic Motion Model and Larger Blocks,?IEEE Trans. Circ. And Syst. for Video Technology, vol. 20, no. 5, pp. 661-672, 2010. [Impact factor ?3.18] [PDF]
% A A Muhit, M R Pickering, M R Frater and J F Arnold, “Video Coding using Geometry Partitioning and an Elastic Motion Model,?accepted for publication in Journal of Visual Communication and Image Representation. [Impact factor ?1.33] [PDF]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-------------------------------------------------
% global variables
global QP h w c Threshold zero_point histo_B
global Table_coeff0 Table_coeff1 Table_coeff2 Table_coeff3
global Table_run Table_zeros
% load table.mat

load('cat.mat','block_category');
%% initialize

bs = 16;
mode_prev = 0;
S = zeros(h,w);
hidden_data='';
mb_type = 1;
row=0;   %row index of Macroblock
col=0;   %column index of Macroblock
h_data=''; %The string that contains extracted data
for i = 1:bs:h
    for j = 1:bs:w
        if bitstream(idx)=='0'
           mb_type = 0;
%            disp('Prediciton block size 16x16')
           idx = idx + 1;
           % find the mode difference
            [mode_diff,idx]= dec_golomb(idx,bitstream,1);
            
            mode = mode_prev + mode_diff;
            [S(i:i+15,j:j+15),idx] = dec_mb_16(idx,bitstream,mode,S,i,j);
            mode_prev = mode;
        elseif  bitstream(idx)=='1'
           mb_type = 1;
           idx = idx + 1;
           for m = i:4:i+15
               row=floor(m/4)+1;
               for n = j:4:j+15
                   col=floor(n/4)+1;
                   [mode_diff,idx]= dec_golomb(idx,bitstream,1);
                    mode = mode_prev + mode_diff;
                    mode_prev = mode;
                   [h_data,S(m:m+3,n:n+3),idx] = dec_mb(idx,bitstream,mode,S,m,n,block_category(row,col));
                   hidden_data=[hidden_data h_data];                    
               end
            end
        end
    end
end

%% -----------------------------------------------------------------
function [h_data,Xi,k] = dec_mb(k,bits,mode,S,i,j,category)

pred = find_pred_4(mode,S,i,j);
[h_data,icp,k] = recover(k,bits,category);

Xi = pred + icp;

%% ----------------------------------------------------------------
function [h_data,icp,k] = recover(k,bits,category)

global QP

[Z,m] = dec_cavlc(bits(k:length(bits)),0,0);
[h_data,Z]=extract_data_ma(Z,category);
Wi = inv_quantization(Z,QP);
Y = inv_integer_transform(Wi);
X = round(Y./64);
icp = X;
k = k + m - 1;



%----------------------------------------------------------------
function [pred] = find_pred_4(mode,S,i,j)

if (mode==9)
    pred = zeros(4,4);
elseif (mode==0)
    [pred] = pred_vert_4(S,i,j);
elseif (mode==1)
    [pred] = pred_horz_4(S,i,j);
elseif (mode==2)
    [pred] = pred_dc_4(S,i,j);
elseif (mode==3)
    [pred] = pred_ddl_4(S,i,j);
elseif (mode==4)
    [pred] = pred_ddr_4(S,i,j);
elseif (mode==5)
    [pred] = pred_vr_4(S,i,j);
elseif (mode==6)
    [pred] = pred_hd_4(S,i,j);
elseif (mode==7)
    [pred] = pred_vl_4(S,i,j);
elseif (mode==8)
    [pred] = pred_hu_4(S,i,j);
end

%% 4x4 Horizontal prediciton

function [pred] = pred_horz_4(Seq_r,i,j)

pred = Seq_r(i:i+3,j-1)*ones(1,4);

%-------------------------------------------------------
%% 4x4 Vertical Prediciton

function [pred] = pred_vert_4(Seq_r,i,j)

pred = ones(4,1)*Seq_r(i-1,j:j+3);

%-------------------------------------------------------
%% 4x4 DC prediction

function [pred] = pred_dc_4(Seq_r,i,j)
pred = floor((sum(Seq_r(i-1,j:j+3))+ sum(Seq_r(i:i+3,j-1))+4)/8);

%--------------------------------------------------------
function [pred] = pred_ddl_4(Seq_r,i,j)

Seq_r(i+4:i+7,j-1)=Seq_r(i+3,j-1);

for x = 0:3
    for y = 0:3
        if (x==3)&&(y==3)
            pred(x+1,y+1) = floor((Seq_r(i+6,j-1) + 3*Seq_r(i+7,j-1) + 2)/4);
        else
            pred(x+1,y+1) = floor((Seq_r(i+x+y,j-1) + 2*Seq_r(i+x+y+1,j-1) + Seq_r(i+x+y+2,j-1) + 2)/4);
        end
    end
end

%--------------------------------------------------------
function [pred] = pred_ddr_4(Seq_r,i,j)

for x = 0:3
    for y = 0:3
        if (x>y)
            pred(x+1,y+1) = floor((Seq_r(i+x-y-2,j-1) + 2*Seq_r(i+x-y-2,j-1) + Seq_r(i+x-y,j-1) + 2)/4);
        elseif (x<y)
            pred(x+1,y+1) = floor((Seq_r(i-1,j+y-x-2) + 2*Seq_r(i-1,j+y-x-1) + Seq_r(i-1,j+y-x) + 2)/4);
        else
            pred(x+1,y+1) = floor((Seq_r(i,j-1) + 2*Seq_r(i-1,j-1) + Seq_r(i-1,j) + 2)/4);
        end
    end
end

%--------------------------------------------------------
function [pred] = pred_vr_4(Seq_r,i,j)

for x = 0:3
    for y = 0:3
        z = 2*x-y;
        w = bitshift(y,-1);
        if rem(z,2)==0
            pred(x+1,y+1)= floor((Seq_r(i+x-w-1,j-1) + Seq_r(i+x-w,j-1) + 1)/2);
        elseif rem(z,2)==1
            pred(x+1,y+1)= floor((Seq_r(i+x-w-2,j-1) + 2*Seq_r(i+x-w-1,j-1) + Seq_r(i+x-w,j-1) + 2)/4);
        elseif z==-1
            pred(x+1,y+1)= floor((Seq_r(i-1,j)+ 2*Seq_r(i-1,j-1) + Seq_r(i,j-1) + 2)/4);
        else
            pred(x+1,y+1) = floor((Seq_r(i-1,j+y-1)+ 2*Seq_r(i-1,j+y-2) + Seq_r(i-1,j+y-3) + 2)/4);
        end
    end
end

%--------------------------------------------------------
function [pred] = pred_hd_4(Seq_r,i,j)

for x = 0:3
    for y = 0:3
        z = 2*y-x;
        w = bitshift(x,-1);
        if rem(z,2)==0
            pred(x+1,y+1)= floor((Seq_r(i-1,j+y-w-1) + Seq_r(i-1,j+y-w) + 1)/2);
        elseif rem(z,2)==1
            pred(x+1,y+1)= floor((Seq_r(i-1,j+y-w-2) + 2*Seq_r(i-1,j+y-w-1) + Seq_r(i-1,j+y-w) + 2)/4);
        elseif z==-1
            pred(x+1,y+1)= floor((Seq_r(i-1,j)+ 2*Seq_r(i-1,j-1) + Seq_r(i,j-1) + 2)/4);
        else
            pred(x+1,y+1) = floor((Seq_r(i+x-1,j-1)+ 2*Seq_r(i+x-2,j-1) + Seq_r(i+x-3,j-1) + 2)/4);
        end
    end
end


%--------------------------------------------------------
function [pred] = pred_vl_4(Seq_r,i,j)

Seq_r(i+4:i+7,j-1)=Seq_r(i+3,j-1);

for x = 0:3
    for y = 0:3
        w = bitshift(y,-1);
        if rem(y,2)==0
            pred(x+1,y+1) = floor((Seq_r(i+x+w,j-1) + Seq_r(i+x+w+1,j-1) + 1)/2);
        else
            pred(x+1,y+1) = floor((Seq_r(i+x+w,j-1) + 2*Seq_r(i+x+w+1,j-1) + Seq_r(i+x+w+2,j-1) + 2)/4);
        end
    end
end

%--------------------------------------------------------
function [pred] = pred_hu_4(Seq_r,i,j)

for x = 0:3
    for y = 0:3
        z = 2*y+x;
        w = bitshift(x,-1);
        if (z==0)||(z==2)||(z==4)
            pred(x+1,y+1)= floor((Seq_r(i-1,j+y+w) + Seq_r(i-1,j+y+w+1) + 1)/2);
        elseif (z==1)||(z==3)
            pred(x+1,y+1)= floor((Seq_r(i-1,j+y+w) + 2*Seq_r(i-1,j+y+w+1) + Seq_r(i-1,j+y+w+2) + 2)/4);
        elseif z==5
            pred(x+1,y+1)= floor((Seq_r(i-1,j+2)+ 3*Seq_r(i-1,j+3) + 2)/4);
        else
            pred(x+1,y+1) = Seq_r(i-1,j+3);
        end
    end
end