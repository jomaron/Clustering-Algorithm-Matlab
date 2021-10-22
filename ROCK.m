%�����ֵ
clear all;
close all;
%�Ŵ��㷨�����趨�ͳ�ʼ��
M=80;                                  %��Ⱥ��С80��
T=100;                                 %�Ŵ��������ֹ��������100��
CL=10;                                 %�����Ʊ��볤��10λ
F=0.6;            				       %�������F=0.6
Bi=0.001;                               %�������Bi=0.001
Max=2.048;                             %����ֵ��ȡֵ����
Min=-2.048;                             %����ֵ��ȡֵ����

G=round(rand(M,CL*2));                  %��ʼ����ʹ���Ϊ��������ֵ
NG=zeros(M,CL*2);
for k=1:1:T
T(k)=k;
for s=1:1:M
        N=G(s,:);
        y1=0;y2=0;
N1=N(1:1:CL);                  %��x1���н��룬
for i=1:1:CL                    
        y1=y1+N1(i)*2^(i-1);
end
x1=(Max-Min)*y1/(2^CL-1)+Min;  
x1_G(k)=x1;               %Ϊ�˱������ͼ�������������������ָ���ͱ���
N2=N(CL+1:1:2*CL);          %��x2���н���
for i=1:1:CL
        y2=y2+N2(i)*2^(i-1);
end
x2=(Max-Min)*y2/(2^CL-1)+Min;     
x2_G(k)=x2;                 %Ϊ�˱������ͼ�������������������ָ���ͱ���
F(s)=100*(x1^2-x2)^2+(1-x1)^2; %Ŀ�꺯�����ʽ
%F(s)=x1.^2+x2.^2;
end
Fit=F;
[Order,Index]=sort(Fit);          %����Ӧ�ȴ�С�����������
BF=Order(M);                 %ѡ����Ӧ������ֵ
BFI(k)=BF; 
BG=G(Index(M),:); 
In=M;                        %����5�����Ÿ���
for i=1:1:5              
BGG(i,:)=G(Index(In),:);       
In=In-1;
end
 %���ö���ѡ��
Fit_Sum=sum(Fit);                 %��Ⱥ����ȫ��������Ӧ���ۼ����? _sum  
%Fit_N=floor((Fit/Fit_Sum)*M);       %����һ��0��? _sum֮��������fit_n
%floor(x)����С�ڻ����x����С����ֵ��X�ľ���ֵһ��Ҫ�����������ֵ
                        %�ӱ��Ϊ1�ĸ��忪ʼ����ۼ���Ӧ��  
ada_sum=0;
for i=1:1:M                      %ֱ���ۼӺ�>=fit_n�������ۼӾ��Ǹ��Ƹ���
        ada_sum=ada_sum+F(i);
end
for i=1:(M-5)      %ѡ��39�Σ����һ�����������������Ž�
    r=rand*ada_sum;  %�������һ����
    ada_temp=0;      %��ʼ���ۼ�ֵΪ0
    j=1;
    while(ada_temp<r)&(j<81)
        ada_temp=ada_temp+F(j); 
         j=j+1;
    end
    if j==1 
       j=1;
    else
       j=j-1;
    end
    NG(i,:)=G(j,:);
 
end
%Cn=ceil(2*CL*rand);           %�������㽻����ʼλ��
%ceil(x)���ش��ڻ����x����С����ֵ��X�ľ���ֵһ��ҪС���������ֵ
for i=1:2:(M-5)
     Rn=rand;                %RnΪ0-1֮��������
     if F>Rn %����������F=0.6��Rn<0.6ʱ�ͽ��н�������
         Cn=ceil(2*CL*Rn);
        if or(Cn==0,Cn>=20)
            continue;
        end
        for j=Cn:1:2*CL       %�����������Ⱦɫ��Ļ��򣬽�����λ��Cn��ĩλֹ
          temp=NG(i,j);
          NG(i,j)=NG(i+1,j);
          NG(i+1,j)=temp;
        end
     end
end
%Rs=4;%�Ե�76λ����80λ��������λ�����б���
%for i=1:1:5
    %NG(M-Rs,:)=BGG(i,:);
    %Rs=Rs-1;
%end
%G=NG;
for i=1:1:(M-5)                    %��������
     for j=1:1:2*CL
        Mr=rand;              %��������λ����λ��ͬ��Mr��0-1֮�����
         if Bi>Mr             %����������ֻ�е�Mr<0.001ʱ�Ż���б������㣬��֤
            if NG(i,j)==0      
               NG(i,j)=1;
            else
               NG(i,j)=0;
            end
        end
    end
end
Rs=4;%�Ե�76λ����80λ��������λ�����б���
for i=1:1:5
    NG(M-Rs,:)=BGG(i,:);
    Rs=Rs-1;
end

G=NG;
end
k
Max=BF
x1
x2
subplot(2,1,2);plot(T,BFI); xlabel('����');ylabel('���ֵ');
subplot(2,2,1);plot(T,x2_G); xlabel('����');ylabel('X2');
subplot(2,2,2);plot(T,x1_G); xlabel('����');ylabel('X1');
