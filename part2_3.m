% input
% valores apartado 1
alpha_0 = 12.25; % rango 7 - 13
pi_f_0 = 1.28;  % rango 0.8 - 1.59
pi_LPC_0 =  4.1; % rango 3 - 10
pi_HPC_0 = 6.3; % rango 3 - 10
convergent_only = true;
%%%%%%%
% Tsp, Isp para valores apartado1
[tsp_0, isp_0] = turbofan_analysis(alpha_0, pi_f_0, pi_LPC_0, pi_HPC_0, convergent_only);
disp(tsp_0)
disp(isp_0)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARAM 1  ALPHA (hecho)

n = 50;  
figure
ax1 = subplot(1,2,1) ;hold(ax1,'on')
ax2 = subplot(1,2,2) ; hold(ax2,'on')
%f2 = figure(2) 
for alpha=linspace(5,13,n)
   [tsp,isp] = turbofan_analysis(alpha, pi_f_0, pi_LPC_0, pi_HPC_0, convergent_only);
   scatter(ax1,alpha, tsp, 'filled', 'b')
   hold on
   scatter(ax2,alpha, isp, 'filled', 'g')
   hold on
end

scatter(ax1,alpha_0,tsp_0,'filled', 'r') 
scatter(ax2,alpha_0,isp_0,'filled','r')  

title(ax1, 'Sensibilitat $\frac{F}{\dot{m}}$ amb $\alpha$', 'Interpreter', 'latex', 'FontSize', 20) 
title(ax2, 'Sensibilitat $I_{sp}$ amb $\alpha$', 'Interpreter', 'latex', 'FontSize', 20) 
ylabel(ax1, '$\frac{F}{\dot{m}}$','Interpreter', 'latex','FontSize', 20)
ylabel(ax2, '$I_{sp}$', 'Interpreter', 'latex','FontSize', 20)
xlabel(ax1, '$\alpha$', 'Interpreter','latex','FontSize', 20)
xlabel(ax2, '$\alpha$', 'Interpreter','latex','FontSize', 20)
hold(ax1,'off')
hold(ax2,'off')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PARAM2   PI_F
n = 50;  
figure
ax1 = subplot(1,2,1) ;hold(ax1,'on') 
ax2 = subplot(1,2,2) ; hold(ax2,'on')
%f2 = figure(2) 

for pi_f=linspace(1.1,1.59,n) 
   [tsp,isp] = turbofan_analysis(alpha_0, pi_f, pi_LPC_0, pi_HPC_0, convergent_only); 
   scatter(ax1,pi_f, tsp, 'filled', 'b')
   hold on
   scatter(ax2,pi_f, isp, 'filled', 'g')
   hold on
end

scatter(ax1,pi_f_0,tsp_0,'filled', 'r')
scatter(ax2,pi_f_0,isp_0,'filled','r')  

title(ax1, 'Sensibilitat $\frac{F}{\dot{m}}$ amb $\pi_f$', 'Interpreter', 'latex', 'FontSize', 20) 
title(ax2, 'Sensibilitat $I_{sp}$ amb $\pi_f$', 'Interpreter', 'latex', 'FontSize', 20) 
ylabel(ax1, '$\frac{F}{\dot{m}}\; [\frac{m}{s}]$','Interpreter', 'latex','FontSize', 20)
ylabel(ax2, '$I_{sp}\; [s]$', 'Interpreter', 'latex','FontSize', 20)
xlabel(ax1, '$\pi_f$ ','Interpreter','latex','FontSize', 20) 
xlabel(ax2, '$\pi_f$', 'Interpreter','latex','FontSize', 20) 
hold(ax1,'off')
hold(ax2,'off')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% PARAM3   PI_LPC

n = 50;  
figure
ax1 = subplot(1,2,1) ;hold(ax1,'on') 
ax2 = subplot(1,2,2) ; hold(ax2,'on')
%f2 = figure(2) 

for pi_LPC=linspace(2,8.9,n) 
   [tsp,isp] = turbofan_analysis(alpha_0, pi_f_0, pi_LPC, pi_HPC_0, convergent_only); 
   scatter(ax1,pi_LPC, tsp, 'filled', 'b')
   hold on
   scatter(ax2,pi_LPC, isp, 'filled', 'g')
   hold on
end

scatter(ax1,pi_LPC_0,tsp_0,'filled', 'r') 
scatter(ax2,pi_LPC_0,isp_0,'filled','r')  

title(ax1, 'Sensibilitat $\frac{F}{\dot{m}}$ amb $piLPC$', 'Interpreter', 'latex', 'FontSize', 20) 
title(ax2, 'Sensibilitat $I_{sp}$ amb $piLPC$', 'Interpreter', 'latex', 'FontSize', 20) 
ylabel(ax1, '$\frac{F}{\dot{m}}$','Interpreter', 'latex','FontSize', 20)
ylabel(ax2, '$I_{sp}$', 'Interpreter', 'latex','FontSize', 20)
xlabel(ax1, '$piLPC$', 'Interpreter','latex','FontSize', 20) 
xlabel(ax2, '$piLPC$', 'Interpreter','latex','FontSize', 20) 
hold(ax1,'off')
hold(ax2,'off')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% PARAM4   PI_HPC

n = 50;  
figure
ax1 = subplot(1,2,1) ;hold(ax1,'on') 
ax2 = subplot(1,2,2) ; hold(ax2,'on')
%f2 = figure(2) 

for pi_HPC=linspace(2,8.9,n) 
   [tsp,isp] = turbofan_analysis(alpha_0, pi_f_0, pi_LPC_0, pi_HPC, convergent_only); 
   scatter(ax1,pi_HPC, tsp, 'filled', 'b')
   hold on
   scatter(ax2,pi_HPC, isp, 'filled', 'g')
   hold on
end

scatter(ax1,pi_HPC_0,tsp_0,'filled', 'r') 
scatter(ax2,pi_HPC_0,isp_0,'filled','r')  

title(ax1, 'Sensibilitat $\frac{F}{\dot{m}}$ amb $piHPC$', 'Interpreter', 'latex', 'FontSize', 20) 
title(ax2, 'Sensibilitat $I_{sp}$ amb $piHPC$', 'Interpreter', 'latex', 'FontSize', 20) 
ylabel(ax1, '$\frac{F}{\dot{m}}$','Interpreter', 'latex','FontSize', 20)
ylabel(ax2, '$I_{sp}$', 'Interpreter', 'latex','FontSize', 20)
xlabel(ax1, '$piHPC$', 'Interpreter','latex','FontSize', 20) 
xlabel(ax2, '$piHPC$', 'Interpreter','latex','FontSize', 20) 
hold(ax1,'off')
hold(ax2,'off')

