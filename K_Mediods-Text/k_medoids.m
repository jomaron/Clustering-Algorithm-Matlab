clc;  
clear;  
%��ȡ�����ļ�,���ɵ����  
fileID = fopen('E:\MySoftware\matlabWorks\textK_Mediods\sample.txt');  
 C=textscan(fileID,'%f %f'); %textscan������ȡ����
 fclose(fileID); %�ر�һ���򿪵�fileID���ļ�
 %��ʾ������  
 %celldisp(C);  
 %��cell����ת��Ϊ��������,����ֻ����ԭ����Ϊ��ά���ԣ����Ƕ�ά�������  
 CC_init=cat(2,C{1},C{2});%���������ʼ���ص�ֵ  
 CC=CC_init;  %cat�������������������������
  %��ö��������  
 num=length(C{1});  
 %��ʾ��ʼ�ֲ�ͼ  
 grid on;%��ʾ���
 scatter(C{1},C{2},'filled');  %filledΪʵ��Բ���ú������԰�C����������ĵ㶼��������
 %%��������k����  
k=4;  
%��ʱ���k�����ĵ������  
C_temp=zeros(k,2);  
%�ж������õ�kֵ�Ƿ�С�ڶ��������  
if k<num  
    %���������k������  
   randC=randperm(num);  
   randC=randC(1:k);  
   %��ԭ�����������������     
   for i=1:k  
       C_temp(i,:)=CC(randC(1,i),:);  
   end  
   %��ԭ�����е������������  
    for j=1:k  
       CC(randC(1,j),:)=zeros(1,2);  
    end    
    idZero=find(CC(:,1)==0);  
    %ɾ��Ϊ�����  
    [i1,j1]=find(CC==0);  
    row=unique(i1);  
    CC(row,:)=[];  
   %����k����ά���飬������ž����  
   %������Ϊk�Ĵ洢��Ԫ  
   cluster=cell(k,1,1);   
    %���޳�����������뵽��Ӧ�������洢��Ԫ,ÿ����Ԫ�ĵ�һ����Ϊ0��Ϊ�˴洢���Ӧ�Ĵ�����  
   for m=1:k  
       cluster{m}=C_temp(m,:);  
   end    
   %���������㵽��k����ľ��룬Ȼ�������Щ�㣬��һ�α���  
   for i=1:num-k  
       %�ֱ���㵽������ľ���         
       minValue=1000000;%��Сֵ��Ҫ����ʵ������趨��ֵ  
       minNum=-1;%��Сֵ���  
       for j=1:k  
           if minValue>sqrt((CC(i,1)-C_temp(j,1))*(CC(i,1)-C_temp(j,1))+(CC(i,2)-C_temp(j,2))*(CC(i,2)-C_temp(j,2)))  
               minValue=sqrt((CC(i,1)-C_temp(j,1))*(CC(i,1)-C_temp(j,1))+(CC(i,2)-C_temp(j,2))*(CC(i,2)-C_temp(j,2)));  
               minNum=j;  
           end  
       end  
       cluster{minNum}=cat(1,cluster{minNum},CC(i,:));         
   end  
   %���ѡ��p��  
   flag=1;  
   count=0;  
   while flag==1  
       randC=randperm(num-k);  
       randC=randC(1:1);    
       o_random=CC(randC,:);  
       %�ҳ�����������ڵĴ�  
       recordN=0;  
       for i=1:k        
           for j=1:size(cluster{i},1)        
               cc=cluster{i}(j,:);  
               cc=cc-o_random;  
               if cc==0  
                   recordN=i;  
                   break;  
               end  
           end  
       end  
       %��ѡ��������ӵ㼯��ɾ��  
       CC(randC,:)=[];  
       %�����滻����  
       o=cluster{recordN}(1,:);  
       o_rand_sum=0;  
       o_sum=0;  
       for i=1:length(CC)  
           o_rand_sum=o_rand_sum+sqrt((CC(i,1)-o_random(1,1))*(CC(i,1)-o_random(1,1))+(CC(i,2)-o_random(1,2))*(CC(i,2)-o_random(1,2)));  
           o_sum=o_sum+sqrt((CC(i,1)-o(1,1))*(CC(i,1)-o(1,1))+(CC(i,2)-o(1,2))*(CC(i,2)-o(1,2)));  
       end  
       %������ѡ��ĵ�Ĵ���С��ԭʼ�����Ĵ��ۣ����滻�ô���㣬Ȼ�����¾���  
       if o_rand_sum<o_sum  
           cluster{recordN}(1,:)=o_random;  
           %�������������  
           CC=cat(1,CC,o);  
           %�����ж������½��о���  
           %��cluster����һ��֮�������ȫ�����  
           for i=1:k  
               c=cluster{i}(1,:);  
               cluster{i}=[];  
               cluster{i}=c;  
           end   
           %���¾���  
           for i=1:num-k  
               %�ֱ���㵽������ľ���         
               minValue=1000000;%��Сֵ��Ҫ����ʵ������趨��ֵ  
               minNum=-1;%��Сֵ���  
               for j=1:k  
                   if minValue>sqrt((CC(i,1)-C_temp(j,1))*(CC(i,1)-C_temp(j,1))+(CC(i,2)-C_temp(j,2))*(CC(i,2)-C_temp(j,2)))  
                       minValue=sqrt((CC(i,1)-C_temp(j,1))*(CC(i,1)-C_temp(j,1))+(CC(i,2)-C_temp(j,2))*(CC(i,2)-C_temp(j,2)));  
                       minNum=j;  
                   end  
               end  
               cluster{minNum}=cat(1,cluster{minNum},CC(i,:));         
           end             
       else  
           %����������·������  
           CC=cat(1,CC,o_random);  
           %��ֹѭ��  
           flag=0;  
       end  
       count=count+1;  
   end     
   %���ƾ�����  
   for i=1:k  
       scatter(cluster{i}(:,1),cluster{i}(:,2),'filled');  
       hold on  
       grid on;%��ʾ���
   end     
end  