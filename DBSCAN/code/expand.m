function [class,i,core]=expand(num,core,corechart,corenumber,number,points,i,j,class)
%j:��¼��j�����;
%i:���������е��������
%number:��Ҫ��չ�Ľڵ���;

class(i,j)=num;             %���ڵ�num����class j��
core(find(core==num))=[];   %ɾ���ڵ�num
i=i+1;
tem=points(num,1:number(num))';%��¼����num���ܶȿɴ�ڵ�
% class(i:i+number(num)-1,j)=tem;
% i=i+number(num);
if isempty(core)==1   %��ֹ�������
    return
end
m=0;
n=0;
for k=1:number(num)       
    if sum(tem(k)==core(:,1))==1  %��ĳ���ڵ�ʱ�ܶȿɴ�ڵ�Ϊ���Ľڵ㣬�����directcore��
        m=m+1;
        directcore(m,1)=tem(k);
    else                                %�����Ǻ��Ľڵ����n_core
        n=n+1;
        n_core(n,1)=tem(k);
    end
end
if m~=0                     %��չÿ�����Ľڵ�
    for k=1:m
        if sum(directcore(k)==core(:,1))==1
        [class,i,core]=expand(directcore(k),core,corechart,corenumber,number,points,i,j,class);
        %�ݹ����expand���������ϵ�Ѱ�Һ��Ľڵ��ֱ���ܶȿɴ�㣬����������С
            if isempty(core)==1     %��ֹ�������
                return
            end
        end
    end
end
if n~=0
    for k=1:n
        if sum(sum(n_core(k)==class(1:i-1,1:j)))==0         %��δ��ӽ�class��ķǺ��Ľڵ������class
            class(i,j)=n_core(k);
            i=i+1;
        end
    end
%    class(i:i+n-1,j)=n_core;
%    i=i+n;
    return
end
end
       
        

