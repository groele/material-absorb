% % 1.将Origin打开*.prn文件，打开matlab，在workspace中新建tot变量
% % 2.将*.prn文件中的数据(只要数据)粘贴到matlab中的tot变量中
% % 3.计算吸波性能框图，在command window中粘贴下面程序内容，运行，执行命令contourf(f1,d,R)，可以计算出dmax、fmax和maxR，并画出吸波性能框图
% % 4.计算吸波性能曲线，先将matlab中除tot以外的所有变量删除，再修改程序中的d行(用%控制)至计算吸波性能曲线的状态，最后运行程序，执行命令plot(f1,R,'r')，可以画出吸波性能曲线
% % 5.如欲在已有吸波性能曲线图上再画出吸波性能曲线，必须首先删除matlab中除tot以外的所有变量，修改程序的d行后，再执行命令plot(f1,-R,'r')，画出新的吸波性能曲线，保留原曲线可用命令hold on
% % 
% % 程序：
% 
f=tot(:,1)./1e9; er1=tot(:,2); er2=tot(:,3); ur1=tot(:,4); ur2=tot(:,5);
f1=2:0.1:18;
%f1=2:0.01:18;
d=1:0.001:5;
%d=1.5;
pe1=polyfit(f,er1,3);   pe2=polyfit(f,er2,3);
e1=polyval(pe1,f1);   e2=polyval(pe2,f1);
pu1=polyfit(f,ur1,3);   pu2=polyfit(f,ur2,3);
u1=polyval(pu1,f1);   u2=polyval(pu2,f1);

% plot(f, er1);
% hold on;
% plot(f1, e1);
% hold on;

e=e1+e2*i;            u=u1+u2*i;   
[ff dd]=meshgrid(f1,d);  [uu dd]=meshgrid(u,d);  [ee dd]=meshgrid(e,d);
z=sqrt(uu./ee).*tanh(i*2*pi*sqrt(uu.*ee).*dd.*ff/300);
R=20*log10(abs((z-1)./(z+1)));
R=R';
maxR=max(max(R));
dm=repmat(d',size(f1));
f1m=kron(f1',ones(size(d)));
f1m=f1m';

[Amax, indmax] = max(R(:));
[i, j, w] = ind2sub(size(R), indmax);


dmax=dd(j)
fmax=f1(i)
maxR=max(max(R))
mesh(ff,dd,-R');
caxis([-max(max(R)),-min(min(R))]);%控制颜色的亮暗
set(gca,'FontSize',16);
set(gca,'XLim',[2 18]);%X轴的数据显示范围
set(gca,'xtick',2:2:18);
set(gca,'ytick',0:1:5);
set(gca,'tickdir','out')

xlabel('Frequency (GHz)','FontSize',16,'FontWeight','normal','Fontangle','normal'); 
ylabel('Thickness (mm)','FontSize',16,'FontWeight','normal','Fontangle','normal'); 
zlabel('Reflection Loss (dB)','FontSize',16,'FontWeight','normal'); 



% f=tot(:,1)/(1e9); er1=tot(:,2); er2=tot(:,3); ur1=tot(:,4); ur2=tot(:,5);
% f1=2:0.1:18;
% %f1=2:0.01:18;
% %d=0.5:0.01:5;
% d=2.0;
% pe1=polyfit(f,er1,3);   pe2=polyfit(f,er2,3);
% e1=polyval(pe1,f1);   e2=polyval(pe2,f1);
% pu1=polyfit(f,ur1,3);   pu2=polyfit(f,ur2,3);
% u1=polyval(pu1,f1);   u2=polyval(pu2,f1);
% e=e1+e2*i;            u=u1+u2*i;   
% [dd ff]=meshgrid(d,f1);  [dd uu]=meshgrid(d,u);  [dd ee]=meshgrid(d,e);
% z=sqrt(uu./ee).*tanh(i*2*pi*sqrt(uu.*ee).*dd.*ff/300);
% R=20*log10(abs((z-1)./(z+1)));
% R=R';
% maxR=max(max(R));
% dm=repmat(d',size(f1));
% f1m=kron(f1',ones(size(d)));
% f1m=f1m';
% dmax=dm(R==max(max(R)))
% fmax=f1m(R==max(max(R)))
% maxR=max(max(R))


%% 
% clear
% c=3e8;
% d=2e-3;
% fre=xlsread('RGO_carbonsphere.xlsx','A3:A203')';
% sigma_real=xlsread('RGO_carbonsphere.xlsx','B3:B203')';
% sigma_imag=xlsread('RGO_carbonsphere.xlsx','C3:C203')';
% mue_real=xlsread('RGO_carbonsphere.xlsx','D3:D203')';
% mue_imag=xlsread('RGO_carbonsphere.xlsx','E3:E203')';
% sigma=sigma_real+sigma_imag*i;
% mue=mue_real+mue_imag*i;
% a=sigma./mue;
% z=sqrt(mue./sigma).*tanh(i*2*pi.*fre*d.*sqrt(mue.*sigma)/c);
% plot(fre,z,'linewidth',1.5);




