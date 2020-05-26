f = imread('原图.jpg');
f = mat2gray(f);
[M,N] = size(f);

length=9;%不同滤波器大小只需修改这个参数即可
half_length=(length-1)/2;

%把原图加框，边框宽度为（滤波器大小-1）/2，边框值复制图片边缘值
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

% 几何均值滤波器
g_gmf = ones(M,N);
for x = half_length+1:M+half_length
    for y =  half_length+1:N+ half_length
        for i=- half_length: half_length
            for j=- half_length: half_length
                g_gmf(x- half_length,y- half_length) = g_gmf(x- half_length,y- half_length) * g_Ex(x+i  ,y+j);
            end
        end      
    end
end

g_gmf = (g_gmf).^(1/(length*length));
figure
imshow(g_gmf);
