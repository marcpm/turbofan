
% input
% valores apartado 1
alpha_0 = 12.25; % rango 7 - 13
pi_f_0 = 1.28;  % rango 0.8 - 1.59
pi_LPC_0 =  4.1; % rango 3 - 10
pi_HPC_0 = 6.3; % rango 3 - 10
convergent_only = false;
%%%%%%%

% PARAM2   PI_F
n = 50;  % numero de puntos
figure
ax1 = subplot(1,2,1) ;hold(ax1,'on') % abrir figuras
ax2 = subplot(1,2,2) ; hold(ax2,'on')
% %f2 = figure(2) 
% ax1 = axes; hold(ax1, 'on')
for pi_f=linspace(1.1,2,n) % cambiar parametro a variar
   [F_sp, I_sp,F_ratio, eta_p, U_9, U_19, eta_p_0] = turbofan_analysis(alpha_0, pi_f, pi_LPC_0, pi_HPC_0, convergent_only); 
   scatter(ax2,pi_f, eta_p, 'filled', 'b')% cambiar alpha por parametro
   scatter(ax1,pi_f, U_9, 'filled', 'r')% cambiar alpha por parametro
   scatter(ax1,pi_f, U_19, 'filled', 'g')% cambiar alpha por parametro
%    hold on
%    scatter(ax2,pi_f, I_sp, 'filled', 'g')% cambiar alpha por parametro
%    hold on
end

% scatter(ax1,pi_f_0,tsp_0,'filled', 'r') % cambiar alpha_0 por parametro con "_0"
% scatter(ax2,pi_f_0,isp_0,'filled','r')  % cambiar alpha_0 por parametro con "_0"

title(ax1, 'Sensibilitat $U_9, U_{19}$ amb $\pi_f$', 'Interpreter', 'latex', 'FontSize', 20) % cambiar \alpha por parametro a variar
title(ax2, 'Sensibilitat $\eta_p$ amb $\pi_f$', 'Interpreter', 'latex', 'FontSize', 20) % cambiar \alpha por parametro a variar
ylabel(ax1, '$U_9, U_{19}$','Interpreter', 'latex','FontSize', 20)
ylabel(ax2, '$\eta_p$', 'Interpreter', 'latex','FontSize', 20)
xlabel(ax1, '$\pi_f$', 'Interpreter','latex','FontSize', 20) % cambiar \alpha por parametro a variar
xlabel(ax2, '$\pi_f$', 'Interpreter','latex','FontSize', 20) % cambiar \alpha por parametro a variar
hold(ax1,'off')
hold(ax2,'off')
