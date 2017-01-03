function [inf,Y] = embed_data_ma(Y,cat)
inf='';
global data c k Threshold
% inf=info;
if c<Threshold
if Y(1,1)>0
switch cat
    case 1
        for i=1:4   
            if k>=length(data)
               k=1;
            end;
            if data(k)=='1'
                if (mod(Y(i,1),2)~=0)&&(Y(i,1)>=0)
                    Y(i,1)=Y(i,1)-1;                
                    Y(i,3)=Y(i,3)+1;
                    inf=[inf data(k)];                    
                    k=k+1;
                    c=c+1;
                elseif (mod(Y(i,1),2)~=0)&&(Y(i,1)<0)                                        
                    Y(i,1)=Y(i,1)+1;
                    Y(i,3)=Y(i,3)-1;                     
                    inf=[inf data(k)];                    
                    k=k+1;
                    c=c+1;
                elseif (mod(Y(i,1),2)==0)
                    inf=[inf data(k)];                    
                    k=k+1;
                    c=c+1;
                end
            elseif data(k)=='0'
                if (mod(Y(i,1),2)==0)&&(Y(i,1)>=0)
                    Y(i,1)=Y(i,1)-1;                
                    Y(i,3)=Y(i,3)+1;
                    inf=[inf data(k)];                    
                    k=k+1;
                    c=c+1;
                elseif (mod(Y(i,1),2)==0)&&(Y(i,1)<0)                                        
                    Y(i,1)=Y(i,1)+1;
                    Y(i,3)=Y(i,3)-1;                     
                    inf=[inf data(k)];                    
                    k=k+1;
                    c=c+1;
                elseif (mod(Y(i,1),2)~=0)
                    inf=[inf data(k)];                    
                    k=k+1;
                    c=c+1;
                end
            end
        end
    case 2
        for i=1:4   
            if k>=length(data)
               k=1;
            end;
            if data(k)=='1'
                if (mod(Y(1,i),2)~=0)&&(Y(1,i)>=0)
                    Y(1,i)=Y(1,i)-1;                
                    Y(3,i)=Y(3,i)+1;
                    inf=[inf data(k)];                    
                    k=k+1;
                    c=c+1;
                elseif (mod(Y(1,i),2)~=0)&&(Y(1,i)<0)                                        
                    Y(1,i)=Y(1,i)+1;
                    Y(3,i)=Y(3,i)-1;                     
                    inf=[inf data(k)];                    
                    k=k+1;
                    c=c+1;
                elseif (mod(Y(1,i),2)==0)
                    inf=[inf data(k)];                    
                    k=k+1;
                    c=c+1;
                end
            elseif data(k)=='0'
                if (mod(Y(1,i),2)==0)&&(Y(1,i)>=0)
                    Y(1,i)=Y(1,i)-1;                
                    Y(3,i)=Y(3,i)+1;
                    inf=[inf data(k)];                    
                    k=k+1;
                    c=c+1;
                elseif (mod(Y(1,i),2)==0)&&(Y(1,i)<0)                                        
                    Y(1,i)=Y(1,i)+1;
                    Y(3,i)=Y(3,i)-1;                     
                    inf=[inf data(k)];                    
                    k=k+1;
                    c=c+1;
                elseif (mod(Y(1,i),2)~=0)
                    inf=[inf data(k)];                    
                    k=k+1;
                    c=c+1;
                end
            end
        end
    case 4
        for i=1:4   
            if k>=length(data)
               k=1;
            end;
            if data(k)=='1'
                if (mod(Y(1,i),2)~=0)&&(Y(1,i)>=0)
                    Y(1,i)=Y(1,i)-1;                
                    Y(3,i)=Y(3,i)+1;
                    inf=[inf data(k)];                    
                    k=k+1;
                    c=c+1;
                elseif (mod(Y(1,i),2)~=0)&&(Y(1,i)<0)                                        
                    Y(1,i)=Y(1,i)+1;
                    Y(3,i)=Y(3,i)-1;                     
                    inf=[inf data(k)];                    
                    k=k+1;
                    c=c+1;
                elseif (mod(Y(1,i),2)==0)
                    inf=[inf data(k)];                    
                    k=k+1;
                    c=c+1;
                end
            elseif data(k)=='0'
                if (mod(Y(1,i),2)==0)&&(Y(1,i)>=0)
                    Y(1,i)=Y(1,i)-1;                
                    Y(3,i)=Y(3,i)+1;
                    inf=[inf data(k)];                    
                    k=k+1;
                    c=c+1;
                elseif (mod(Y(1,i),2)==0)&&(Y(1,i)<0)                                        
                    Y(1,i)=Y(1,i)+1;
                    Y(3,i)=Y(3,i)-1;                     
                    inf=[inf data(k)];                    
                    k=k+1;
                    c=c+1;
                elseif (mod(Y(1,i),2)~=0)
                    inf=[inf data(k)];                    
                    k=k+1;
                    c=c+1;
                end
            end
        end
end
end
end