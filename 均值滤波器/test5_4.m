f = imread('ԭͼ.jpg');
f = mat2gray(f);
[M,N] = size(f);

length=3;%��ͬ�˲�����Сֻ���޸������������
half_length=(length-1)/2;

%��ԭͼ�ӿ򣬱߿���Ϊ���˲�����С-1��/2���߿�ֵ����ͼƬ��Եֵ
g_Ex = zeros(M+length-1,N+length-1);
if(length==3)
    for x = 1:M
        g_Ex(x+half_length,:) = [f(x,1) f(x,:) f(x,N)];
    end
elseif(length==5)
       for x = 1:M
        g_Ex(x+half_length,:) = [f(x,1) f(x,1) f(x,:) f(x,N) f(x,N)];
       end 
elseif(length==9)
       for x = 1:M
        g_Ex(x+half_length,:) = [f(x,1) f(x,1) f(x,1) f(x,1) f(x,:) f(x,N) f(x,N) f(x,N) f(x,N)];
       end 
end

for i=half_length:1
    g_Ex(i,:)=g_Ex(i+1,:);
end
for i=half_length+1:length-1
    g_Ex(M+i,:)=g_Ex(M+i-1,:);
end

% ��г���˲���
Q = -1.5;
g_cmf = zeros(M,N);
g_cmf_M=zeros(M,N);
g_cmf_D=zeros(M,N);
for x = half_length+1:M+half_length
    for y =  half_length+1:N+ half_length
        for i=- half_length: half_length
            for j=- half_length: half_length
                g_cmf_M(x- half_length,y- half_length) = g_cmf_M(x- half_length,y- half_length) +g_Ex(x+i,y+j)^(Q+1);
                g_cmf_D(x- half_length,y- half_length) = g_cmf_D(x- half_length,y- half_length) +g_Ex(x+i,y+j)^(Q);
            end
        end   
        g_cmf(x-half_length,y-half_length) = g_cmf_M(x- half_length,y- half_length) /g_cmf_D(x- half_length,y- half_length) ;
    end
end

figure
imshow(g_cmf);
