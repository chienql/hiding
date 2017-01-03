clear all 
close all
disp('This is the encrypted DNA string');
[Ref_Seq,binary_code]=encrypt_message('NC_001811');
disp('This is the decrypted DNA string');
DNA_seq=decrypt_message(binary_code);
nucleotide_num=zeros(1,4);
for i=1:length(DNA_seq)
    switch DNA_seq(i)
        case 'A'
            nucleotide_num(1)=nucleotide_num(1)+1;
        case 'C'
            nucleotide_num(2)=nucleotide_num(2)+1;
        case 'G'
            nucleotide_num(3)=nucleotide_num(3)+1;
        case 'T'
            nucleotide_num(4)=nucleotide_num(4)+1;
    end
end
nucleotide_num(1)=nucleotide_num(1)/length(DNA_seq);
nucleotide_num(2)=nucleotide_num(2)/length(DNA_seq);
nucleotide_num(3)=nucleotide_num(3)/length(DNA_seq);
nucleotide_num(4)=nucleotide_num(4)/length(DNA_seq);
labels={'A','C','G','T'};
pie(nucleotide_num)
if strcmp(DNA_seq,Ref_Seq)==1
    disp('Two sequences is similar together.');
else
    disp('Two sequences is difference.');
end
one=0;
zero=0;
for i=1:length(binary_code)
    if binary_code(i)=='1'
        one=one+1;
    else
        zero=zero+1;
    end
end
percent=(one/(zero+one));
disp(percent);