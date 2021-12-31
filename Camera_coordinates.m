%Given 3D object coordinates
co1=[-1 0 2];co2=[1 0 5];co3=[0 1 4];co4=[0 -1 3];
[ctwoD,wtwoD] = cordinate_matrix1(co1,co2,co3,co4);

===========================================================================
%Code starts from here

function [ctwoD,wtwoD] = cordinate_matrix1(co1,co2,co3,co4)
mat=[co1;co2;co3;co4]';
weight=[1 1 1 1];
cam_cor=[mat;weight];
f=1; % focal length
m=[f 0 0 0;0 f 0 0;0 0 1 0]; %Intrinsic matrix
per = zeros(4,2);
...........................................................................
%part a
% perspective camera
for x=1:4
c=cam_cor(:,x); % camera coordinates
cor=[m*c]; % 3D to 2D conversion
cor=[(cor(1,1)/cor(3,1)),(cor(2,1)/cor(3,1))]; %homogeneous to cartesian
['ctwoD ' num2str(x) ' = ' '[' num2str(cor) ']']
per(x, :) = cor; % collect the vectors in a matrix
ctwoD=per'; % 2D image coordinates
end
...........................................................................
%part b
% weak perception
z0=sum(mat(3,:))/4; % average depth of the scene,
per = zeros(4,2);
x=1;
for x=1:4
c=cam_cor(:,x);
cor=[m*c];
cor=[(cor(1,1)/z0),(cor(2,1)/z0)]; %
['wtwoD' num2str(x) ' = ' '[' num2str(cor) ']']
we_per(x, :) = cor; % collect the vectors in a matrix
wtwoD=we_per';% 2D image coordinates weak perception
end
...........................................................................
%part c
%coordinate of perspective camera projection
xc = ctwoD(1,:);
yc = ctwoD(2,:);
%cordinate of weak perspective camera projection
xw = wtwoD(1,:);
yw = wtwoD(2,:);
%plot the transformed points from 3D to 2D
figure(1)
plot(xc,yc,'-ro',xw,yw,'-*b','Markersize',10);
hleg1 = legend('perspective','weak perspective');
xlabel('x axis of 2D coordinates');
ylabel('y axis of 2D coordinates');
title('2D projection of O using weak perspective and perspective projection');
...........................................................................
% part d
SSD=0;
for i=1:4
P1=(xc(i)-xw(i)).^2;
P2=(yc(i)-yw(i)).^2;
SSD=(P1+P2)+SSD;% sum of square differences
end
disp('sum of square differences')
SSD
end
Result