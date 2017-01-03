function [inf,Y] = embed_data_conf(Y,cat)
inf='';
global data k
% inf=info;
T=0;
maxY=0;
for i=1:4
    for j=1:4
        if Y(i,j)>maxY
            maxY=Y(i,j);
        end
        T=T+Y(i,j);
    end    
end
T=T/16;
if (T<=0)
switch cat
    case 1
        for i=1:4   
            if k>=length(data)
               k=0;
            end;
            if (Y(i,1)~=0)||(Y(i,3)~=0)
                k=k+1;
                inf=[inf data(k)];
                if (Y(i,1)>=0)&&(((data(k)=='1')&&(mod(Y(i,1),2)==0))||((data(k)=='0')&&(mod(Y(i,1),2)~=0)))
                    Y(i,1)=Y(i,1)+1;                
                    Y(i,3)=Y(i,3)-1;
                elseif (Y(i,1)<0)&&(((data(k)=='1')&&(mod(Y(i,1),2)==0))||((data(k)=='0')&&(mod(Y(i,1),2)~=0)))                                        
                    Y(i,1)=Y(i,1)-1;
                    Y(i,3)=Y(i,3)+1;                     
                end
                
            end
        end
    case 2
        for i=1:4   
            if k>=length(data)
                k=0;
            end;
        
            if (Y(1,i)~=0)||(Y(3,i)~=0)
                k=k+1;
                inf=[inf data(k)];
                if (Y(1,i)>=0)&&(((data(k)=='1')&&(mod(Y(1,i),2)==0))||((data(k)=='0')&&(mod(Y(1,i),2)~=0)))
                    Y(1,i)=Y(1,i)+1;
                    Y(3,i)=Y(3,i)-1;
                elseif (Y(1,i)<0)&&(((data(k)=='1')&&(mod(Y(1,i),2)==0))||((data(k)=='0')&&(mod(Y(1,i),2)~=0)))
                    Y(1,i)=Y(1,i)-1;
                    Y(3,i)=Y(3,i)+1;                        
                end
            end
        end
        

    case 3
        for i=1:4
            for j=1:4
               if k>=length(data)
                   k=0;
               end;

                if (Y(i,j)~=0)
                    k=k+1;
                    inf=[inf data(k)];
                    if (Y(i,j)>=0)&&(((data(k)=='1')&&(mod(Y(i,j),2)==0))||((data(k)=='0')&&(mod(Y(i,j),2)~=0)))
                        Y(i,j)=Y(i,j)+1;                                                    
                    elseif (Y(i,j)<0)&&(((data(k)=='1')&&(mod(Y(i,j),2)==0))||((data(k)=='0')&&(mod(Y(i,j),2)~=0)))
                        Y(i,j)=Y(i,j)-1;
                    end                    
                end
            end
        end
    case 4
        for i=1:4   
            if k>=length(data)
                k=0;
            end;        
            if (Y(1,i)~=0)||(Y(3,i)~=0)
                k=k+1;
                inf=[inf data(k)];
                if (Y(1,i)>=0)&&(((data(k)=='1')&&(mod(Y(1,i),2)==0))||((data(k)=='0')&&(mod(Y(1,i),2)~=0)))
                    Y(1,i)=Y(1,i)+1;
                    Y(3,i)=Y(3,i)-1;
                elseif (Y(1,i)<0)&&(((data(k)=='1')&&(mod(Y(1,i),2)==0))||((data(k)=='0')&&(mod(Y(1,i),2)~=0)))
                    Y(1,i)=Y(1,i)-1;
                    Y(3,i)=Y(3,i)+1;                        
                end
            end
        end
             
    case 5
        if k>=length(data)
               k=0;
        end;
        if (Y(1,1)~=0)||(Y(1,3)~=0)||(Y(3,1)~=0)||(Y(3,3)~=0)
            k=k+1;
            inf=[inf data(k)];
            if ((data(k)=='1')&&(mod(Y(1,1),2)==0))
                if ((Y(1,1)>=0)&&(Y(3,3)>=0))
                    Y(1,1)=Y(1,1)+1;                       
                    Y(1,3)=Y(1,3)-1;                       
                    Y(3,1)=Y(3,1)-1;                       
                    Y(3,3)=Y(3,3)+1;                     
                else
                    Y(1,1)=Y(1,1)-1;                       
                    Y(1,3)=Y(1,3)+1;                       
                    Y(3,1)=Y(3,1)+1;                       
                    Y(3,3)=Y(3,3)-1;                                    
                    
                end
            
            elseif ((data(k)=='0')&&(mod(Y(1,1),2)~=0))
                if ((Y(1,1)>=0)&&(Y(3,3)>=0))
                    Y(1,1)=Y(1,1)+1;                       
                    Y(1,3)=Y(1,3)-1;                       
                    Y(3,1)=Y(3,1)-1;                       
                    Y(3,3)=Y(3,3)+1;                     
                else
                    Y(1,1)=Y(1,1)-1;                       
                    Y(1,3)=Y(1,3)+1;                       
                    Y(3,1)=Y(3,1)+1;                       
                    Y(3,3)=Y(3,3)-1;                                    
                    
                end                
            end
        end
end
end