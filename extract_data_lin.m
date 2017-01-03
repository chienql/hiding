% c is the category (1-5)
% Conditional: (1/16)*sum(sum(Y'mn,0,3),0,3)>=T
% Category 1: (Y00,Y02);(Y10,Y12);(Y20,Y22);(Y30,Y32)
% Category 2: (Y00,Y20);(Y01,Y21);(Y02,Y22);(Y03,Y23)
% Category 3: (Y00,Y02);(Y10,Y12);(Y20,Y22);(Y30,Y32)
function [hidden_data,Y]=extract_data_lin(Y,category)
hidden_data='';
k=0; 
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
switch category
    case 1
        for i=1:4
            if (Y(i,1)~=0)||(Y(i,3)~=0)
                k=k+1;
                if ((mod(Y(i,1),2)~=0))                
                        hidden_data(k)='1';                                        
                else
                        hidden_data(k)='0';                
                end
                
            end          
        end
    case 2
        for i=1:4
            if (Y(1,i)~=0)||(Y(3,i)~=0)
                k=k+1;
                if ((mod(Y(1,i),2)~=0))                
                        hidden_data(k)='1';                                        
                else
                        hidden_data(k)='0';                
                end
                
            end
            
        end
      case 3
          for i=1:4
            for j=1:4  
                if Y(i,j)~=0
                    k=k+1;
                    if mod(Y(i,j),2)~=0                
                        hidden_data(k)= '1';                                        
                    else
                        hidden_data(k)='0';                
                    end
                    
                end
                
            end
          end
    case 4
        for i=1:4
            if (Y(1,i)~=0)||(Y(3,i)~=0)
                k=k+1;
                if ((mod(Y(1,i),2)~=0))                
                        hidden_data(k)='1';                                        
                else
                        hidden_data(k)='0';                
                end
                
            end
            
        end
    case 5
        if (Y(1,1)~=0)||(Y(1,3)~=0)||(Y(3,1)~=0)||(Y(3,3)~=0)
            k=k+1;
            if (mod(Y(1,1),2)~=0)                
                    hidden_data(k)='1';                                        
            else
                    hidden_data(k)='0';                
            end
            
        end
%         
end
end

