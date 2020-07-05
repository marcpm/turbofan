
% input
% valores apartado 1
alpha_0 = 12.25; % rango 7 - 13
pi_f_0 = 1.28;  % rango 0.8 - 1.59
pi_LPC_0 =  4.1; % rango 3 - 10
pi_HPC_0 = 6.3; % rango 3 - 10
convergent_only = false;
%%%%%%%

% PARAM2   PI_F
n = 50;  
figure
ax1 = subplot(1,2,1) ;hold(ax1,'on') 
ax2 = subplot(1,2,2) ; hold(ax2,'on')
% %f2 = figure(2) 
% ax1 = axes; hold(ax1, 'on')
for pi_f=linspace(1.1,2,n) 
   [F_sp, I_sp,F_ratio, eta_p, U_9, U_19, eta_p_0] = turbofan_analysis(alpha_0, pi_f, pi_LPC_0, pi_HPC_0, convergent_only); 
   scatter(ax2,pi_f, eta_p, 'filled', 'b')
   scatter(ax1,pi_f, U_9, 'filled', 'r')
   scatter(ax1,pi_f, U_19, 'filled', 'g')
%    hold on
%    scatter(ax2,pi_f, I_sp, 'filled', 'g')
%    hold on
end

% scatter(ax1,pi_f_0,tsp_0,'filled', 'r') 
% scatter(ax2,pi_f_0,isp_0,'filled','r')  

title(ax1, 'Sensibilitat $U_9, U_{19}$ amb $\pi_f$', 'Interpreter', 'latex', 'FontSize', 20) 
title(ax2, 'Sensibilitat $\eta_p$ amb $\pi_f$', 'Interpreter', 'latex', 'FontSize', 20) 
ylabel(ax1, '$U_9, U_{19}$','Interpreter', 'latex','FontSize', 20)
ylabel(ax2, '$\eta_p$', 'Interpreter', 'latex','FontSize', 20)
xlabel(ax1, '$\pi_f$', 'Interpreter','latex','FontSize', 20) 
xlabel(ax2, '$\pi_f$', 'Interpreter','latex','FontSize', 20) 
hold(ax1,'off')
hold(ax2,'off')
