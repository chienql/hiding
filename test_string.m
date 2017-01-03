function test_string(s1,s2)
count=0;
for i=1:length(s1)
    if s1(i)~=s2(i)
        disp(['Error at ',num2str(i),' ,in source is ', s1(i),' ,in target is ',s2(i)]);
        count=count+1;
    end
end
if count==0
    disp(['The input sequence and output sequence are similar!']);
end