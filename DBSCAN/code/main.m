clc;clear;
% load('moon.mat');
% locate=a;
% E=0.01;%�ܶȰ뾶
% Minpts=5;%������С����
% 
% load('long.mat');
% locate=long1;
% E=0.02;%�ܶȰ뾶
% Minpts=3;%������С����
% 
% load('sizes5.mat');
% locate=sizes5;
% E=0.7;%�ܶȰ뾶
% Minpts=7;%������С����
% 
% load('2d4c.mat');
% locate=a;
% E=0.5;%�ܶȰ뾶
% Minpts=7;%������С����
% 
% load('smile.mat');
% locate=smile;
% E=0.003;%�ܶȰ뾶
% Minpts=5;%������С����
% 
% load('spiral.mat');
% locate=spiral;
% E=0.1;%�ܶȰ뾶
% Minpts=5;%������С����
% 
% load('square1.mat');
% locate=square1;
% E=0.4;%�ܶȰ뾶
% Minpts=10;%������С����
% 
load('square4.mat');
locate=b;
E=0.45;%�ܶȰ뾶
Minpts=13;%������С����

l=length(locate);
for i=1:l
    distance(i,:)=((locate(i,1)-locate(:,1)).^2+(locate(i,2)-locate(:,2)).^2).^1/2;%����������룻
end

for i=1:l
number(i)=length(find(distance(i,:)<=E));       %ÿ���������ڵĵ����
points(i,1:number(i))=find(distance(i,:)<=E)';  %ÿ���������ڵĵ���
end
number=number';
core(:,1)=find(number(:,1)>Minpts); %��¼���к��ĵ�
corechart=points(core,:);           %��¼���к��ĵ�����ĵ�
corenumber=number(core);            %��¼���к��ĵ������ĸ���
j=1;
class=zeros(l,l);
while ~isempty(core)
i=1;%��ʶ�����������
[class,i,core]=expand(core(1),core,corechart,corenumber,number,points,i,j,class);
classnumber(j)=i-1;
j=j+1;
end

for i=1:length(classnumber)
    locate(class(1:classnumber(i),i),4)=i;
end


%% ��������ͼ��ͨ��
figure;
plot(locate(locate(:,3)==0,1),locate(locate(:,3)==0,2),'.r');
hold on;
plot(locate(locate(:,3)==1,1),locate(locate(:,3)==1,2),'.g');
hold on;
plot(locate(locate(:,3)==2,1),locate(locate(:,3)==2,2),'.b');
hold on;
plot(locate(locate(:,3)==3,1),locate(locate(:,3)==3,2),'.y');
title('���۷�����');

figure;
plot(locate(locate(:,4)==1,1),locate(locate(:,4)==1,2),'.r');
hold on;
plot(locate(locate(:,4)==2,1),locate(locate(:,4)==2,2),'.g');
hold on;
plot(locate(locate(:,4)==3,1),locate(locate(:,4)==3,2),'.b');
hold on;
plot(locate(locate(:,4)==4,1),locate(locate(:,4)==4,2),'.y');

title('ʵ�ʷ�����');



