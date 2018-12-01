function [  ] = LPR( image )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
clc; close all;
p=0;
messag='0000000000';
  img=image;
ref0=imread('0');
ref2=imread('2');
ref3=imread('3');
ref4=imread('4');
ref6=imread('6');
ref8=imread('8');
imref={ref0,ref2,ref3,ref4,ref6,ref8};
ST={'0','2','3','4','6','8'};
taille_ref=size(imref);
tai=size(image);

figure (1)
imshow(img);
imgray=rgb2gray(image);
figure (2) 
imshow(imgray);
Contour=edge(imgray,'canny');
figure(9)
imshow(Contour);
Contour=imfill(Contour,'holes');
labeled=bwlabel(Contour);
m=max(max(labeled))
figure(10)
imshow(Contour);
imarea=regionprops(labeled,'Area');
surface=[imarea.Area];
size(surface);

for i=1:m
    if surface(i)>max(surface)*0.5
    [row,col]=find(labeled==i);
    len=max(row)-min(row)+2;
    breadth=max(col)-min(col)+2;
    target=uint8(zeros([len breadth]));
    sy=min(col)-1;
    sx=min(row)-1;
for j=1:size(row,1)
    x=row(j,1)-sx;
    y=col(j,1)-sy;
    target(x,y)=image(row(j,1),col(j,1));
    
end
target=imresize(target,[80 80]);
figure (i+1)
 imshow(target);

for r=1:taille_ref(2)
    refer=cell2mat(imref(r));
    %diff=xcorr2(target,refer)/10^5;
    diff=imabsdiff(target,refer);
    moy=mean(mean(diff))
    if moy<30
        p=p+1;
        messag(p)=cell2mat(ST(r))
        c=1;
    end
%     
end
fileID=fopen('matricules.txt','w');
fprintf(fileID,'%s',messag);
fclose(fileID);
    end
    
end



end


