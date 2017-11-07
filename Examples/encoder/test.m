clear all
close all
clc

% �޸�����Ϊ������ļ���
xml = xmlread('test.dat','GBK');   

% ���ȶ�ȡͼƬ���ݣ�һ����������ͼƬ������֪��ÿ�ֵĸ�����������һ����ȡ
FoCounta = xml.getElementsByTagName('FoCount');
FoCount = char(FoCounta.item(0).getTextContent());

FmCounta = xml.getElementsByTagName('FmCount');
FmCount = char(FmCounta.item(0).getTextContent());

FCounta = xml.getElementsByTagName('FCount');
FCount = char(FCounta.item(0).getTextContent());

FmmCounta = xml.getElementsByTagName('FmmCount');
FmmCount = char(FmmCounta.item(0).getTextContent());

% ����ȫ�ֱ���j, ����j-1 ��ͼƬ��
global j;
j=1;

if (FoCount)
    jpeg = xml.getElementsByTagName('Fo');
    aaa = char(jpeg.item(0).getTextContent());
    aaaa=base64decode(aaa);   % ��ȡԭʼ���ݺ�base תbyte���ݡ�
    b{j} = reshape(aaaa,2,640,480);  % ���¶����������Ϊ640*480. ÿ��������12λ��ɣ����ǰ8λ�ǵڰ�λ����8λ�Ǹ���λ��
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

%����ͼƬ����Ϊ2*640*480��ԭ����ÿ�����ص���12λ���ݱ�ʾ��������ϳ�Ϊһ�����ص�
for i=1:j-1
    for m=1:640
        for n=1:480
          im{i}(m,n)=b{i}(1,m,n)+b{i}(2,m,n)*256; 
        end
    end
end

%����ͼ�����ݱ�����im�����С�