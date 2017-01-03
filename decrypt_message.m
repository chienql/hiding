function [DNA_Seq_name,DNA_Sequence]=decrypt_message(binary_string)
%% Binary Codes for DNA
%A=00; C=01; G=10; T=11
binary_code=binary_string;
c='';
DNA_Seq='';
length_of_DNA_Seq='';
DNA_Seq_number='';
DNA_Seq_name='';
AA_code=['D' 'E' 'F' 'H' 'I' 'K' 'L' 'M' 'N' 'P' 'Q' 'R' 'S' 'V' 'W' 'Y'];
x=zeros(1,16);
if length(binary_code)==0
    disp('The input binary string is empty');
else
    length_of_DNA_Seq=binary_code(1:32);
    length_of_DNA_Seq=bin2dec(length_of_DNA_Seq);
%    DNA_Seq_number=binary_code(33:64);
%    temp=bin2dec(DNA_Seq_number);
%    DNA_Seq_number=num2str(temp);
%    if DNA_Seq_number<=999
%        DNA_Seq_name=['NC_000' num2str(DNA_Seq_number)];
%    elseif (DNA_Seq_number>=1000)&&(DNA_Seq_number<=9999)
%        DNA_Seq_name=['NC_00' num2str(DNA_Seq_number)];
%    else
%        DNA_Seq_name=['NC_0' num2str(DNA_Seq_number)];
%    end
    i=33;
    l=length_of_DNA_Seq*2+64;
    while (i<l);
        if (binary_code(i)=='0')&&(binary_code(i+1)=='0')
            c='A';
        elseif (binary_code(i)=='0')&&(binary_code(i+1)=='1')
            c='C';
        elseif (binary_code(i)=='1')&&(binary_code(i+1)=='0')
            c='G';
        elseif (binary_code(i)=='1')&&(binary_code(i+1)=='1')
            c='T';
        end
        i=i+2;
        DNA_Seq=[DNA_Seq c];
    end
DNA_Sequence=DNA_Seq;    
end    
    k=length_of_DNA_Seq*2+65;
    disp([num2str(k),'    ',num2str(length(binary_code))]);
    while k<length(binary_code)-3
        disp([num2str(k),'    ', num2str(length(binary_code))]);
        loc=binary_code(k:k+31);
        loc=bin2dec(loc);
        disp([binary_code(k+32:k+35),'   ',num2str(loc)]);
        for j=1:size(AA_code,2)
            m=dec2bin(j-1,4);
            if eq(binary_code(k+32:k+35),m)
                DNA_Sequence(loc)=AA_code(j);
                x(j)=x(j)+1;
            end
        end
        k=k+36;
    end
        for j=1:size(AA_code,2)
            if x(j)~=0
                disp(['There are ',num2str(x(j)),' item ',AA_code(j),' in the Reference Sequence']);
            end
        end        

