% c is the category (1-5)
% Conditional: (1/16)*sum(sum(Y'mn,0,3),0,3)>=T
% Category 1: (Y00,Y02);(Y10,Y12);(Y20,Y22);(Y30,Y32)
% Category 2: (Y00,Y20);(Y01,Y21);(Y02,Y22);(Y03,Y23)
% Category 3: (Y00,Y02);(Y10,Y12);(Y20,Y22);(Y30,Y32)
function [hidden_data,Y]=extract_data_ma(Y,category)
hidden_data='';
k=1; 
if (Y(1,1)>0)
switch category
    case 1
        for i=1:4
                if ((mod(Y(i,1),2)==1))                
                        hidden_data(k)='1';                                        
                        k=k+1;
                elseif ((mod(Y(i,1),2)==0)) 
                        hidden_data(k)='0';                
                        k=k+1;
                end
        end
    case 2
        for i=1:4
                if ((mod(Y(1,i),2)==1))                
                        hidden_data(k)='1';                                        
                        k=k+1;
                elseif ((mod(Y(1,i),2)==0)) 
                        hidden_data(k)='0';                
                        k=k+1;
                end
        end
    case 4
        for i=1:4
                if ((mod(Y(1,i),2)==1))                
                        hidden_data(k)='1';                                        
                        k=k+1;
                elseif ((mod(Y(1,i),2)==0)) 
                        hidden_data(k)='0';                
                        k=k+1;
                end
        end
end
end

