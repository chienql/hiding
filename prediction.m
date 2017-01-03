%% Clean all and Close all previuse compution
clc
clear all;
close all;
system_dependent('DirChangeHandleWarn', 'Never');
addpath(genpath('.'));
%% Encoding Video Paramiters
global QP h w         % Quantization Parameter, Height and Width
fileName = 'videos/*.mat';
files = dir(fullfile(pwd,fileName));
filenum=size(files,1);

cat_stat=zeros(10,6,filenum);          % Categories statistic array
avg_cat_stat=zeros(filenum,6);
total_cat_stat=zeros(filenum,6);
qualities=[18 23 28 33 38 43];
for q=1:6
for id = 1:filenum

total_cat_stat(id,:)=0;
f_name=files(id,1).name;
disp(['Category prediction ',f_name,' with quality parameter:',num2str(qualities(q)),'....']);
[VideoSeq_Input,Frame_start,Frame_end]=ReadRawFile_2015(f_name);
[h,w,N] = size(VideoSeq_Input);
VideoSeq = zeros(h,w,N);

% NumberOfFrames(id)=Frame_start+Frame_end;
%% Encoding Inputs/paramiters
QP = qualities(q);                    % 2. Quality Praramter, QP values

%% Encoding Setup
% block_size = 16;        % Macroblock size for P frames
%% Encoding Outputs intialization
N=300;
VideoSeq_Rec = zeros(h,w,N);    % Initialize Reconstructed video sequance
%% 2. Encode I-Frame
    [bits] = header(h,w,QP,Frame_start,Frame_end);
    bitstream = bits;
for i=1:30:N
%% Encoding Processes
%% 1. Saving the header: Encoding Inputs/paramiters (1x byte each)
    bitstream = [bitstream '1111'];     % Appending I-Frame header ('1111')
    Seq(:,:,i) = double(VideoSeq_Input(:,:,i)); % Extracting I-Frame
    Iorig = Seq(:,:,i);
%     [Seq_r(:,:,i),bits] = encode_i_frame(Seq(:,:,i),QP);    % Encoding
 %% New
     category_prediction(Seq(:,:,i),QP);    % Encoding
end     
end
end
