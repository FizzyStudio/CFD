clear all
close all
clc

% 修改名称为保存的文件名
xml = xmlread('test.dat','GBK');   

% 首先读取图片内容，一共四种类型图片，首先知道每种的个数，方便下一步读取
FoCounta = xml.getElementsByTagName('FoCount');
FoCount = char(FoCounta.item(0).getTextContent());

FmCounta = xml.getElementsByTagName('FmCount');
FmCount = char(FmCounta.item(0).getTextContent());

FCounta = xml.getElementsByTagName('FCount');
FCount = char(FCounta.item(0).getTextContent());

FmmCounta = xml.getElementsByTagName('FmmCount');
FmmCount = char(FmmCounta.item(0).getTextContent());

% 设置全局变量j, 共有j-1 张图片。
global j;
j=1;

if (FoCount)
    jpeg = xml.getElementsByTagName('Fo');
    aaa = char(jpeg.item(0).getTextContent());
    aaaa=base64decode(aaa);   % 读取原始数据后base 转byte数据。
    b{j} = reshape(aaaa,2,640,480);  % 重新定义矩阵，像素为640*480. 每个像素由12位组成，因此前8位是第八位，后8位是高四位。
    j=j+1;
end

if (FmCount)
    jpeg = xml.getElementsByTagName('Fm');
    aaa = char(jpeg.item(0).getTextContent());
    aaaa=base64decode(aaa);
    b{j} = reshape(aaaa,2,640,480);
    j=j+1;
end

for i=1:str2num(FCount)
    jpeg = xml.getElementsByTagName(strcat('F_',num2str(i)));
    aaa= char(jpeg.item(0).getTextContent());
    aaaa=base64decode(aaa);
    b{j} = reshape(aaaa,2,640,480);
    j=j+1;
end

for i=1:str2num(FmmCount)
    jpeg = xml.getElementsByTagName(strcat('Fmm_',num2str(i)));
    aaa= char(jpeg.item(0).getTextContent());
    aaaa=base64decode(aaa);
    b{j} = reshape(aaaa,2,640,480);
    j=j+1;
end

%上述图片数据为2*640*480，原因是每个像素点由12位数据表示，现在组合成为一个像素点
for i=1:j-1
    for m=1:640
        for n=1:480
          im{i}(m,n)=b{i}(1,m,n)+b{i}(2,m,n)*256; 
        end
    end
end

%所有图像数据保存在im矩阵中。