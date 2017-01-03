function [Ref_Seq,binary_code]=encrypt_message(Ref_seq)
% x=Ref_seq;
fileID = fopen(Ref_seq,'r'); %Open file to read
DNAstr= fscanf(fileID, '%s'); %Read nucleotides from DNA file 
%DNAstr=getgenbank(Ref_seq,'SequenceOnly',true); 
%% Binary Codes for DNA
%A=00; C=01; G=10; T=11
disp(DNAstr);
Ref_Seq=DNAstr;
err='';
b='';
binary_code='';
k=1;
AA_code=['D' 'E' 'F' 'H' 'I' 'K' 'L' 'M' 'N' 'P' 'Q' 'R' 'S' 'V' 'W' 'Y'];
for i=1:length(Ref_Seq)
    if (Ref_Seq(i)=='A')
        b='00';
    elseif (Ref_Seq(i)=='C')
        b='01';
    elseif (Ref_Seq(i)=='G')
        b='10';
    elseif (Ref_Seq(i)=='T')
        b='11';
%% Reference Sequence may contain character "N' or 'R', we must tag it and recover after 
% the decryption message 
    else
        for j=1:size(AA_code,2)
            if (Ref_Seq(i)==AA_code(j))
                err=[err dec2bin((i),32) dec2bin(j-1,4)]; b='00';
            end
        end
    end
    binary_code=[binary_code b];
end
% x=x(4:9);
% y=str2num(x);
binary_code=[dec2bin(length(Ref_Seq),32) binary_code];
%Missing nucleotides are encoded and then joins to end of binary code
binary_code=[binary_code err];
fclose(fileID);