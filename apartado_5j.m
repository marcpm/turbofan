clear; clc;
alpha = 12.25;
pi_f = linspace(0.5,2,1000);
pi_LPC =  4.1;
pi_HPC = 6.3;
pi_d = 0.98;
eta_f = 0.89;
eta_LPC = 0.88;
eta_HPC = 0.86;
pi_b = 0.96;
eta_b = 0.99;
eta_HPT = 0.91;
eta_LPT = 0.92;
eta_mH = 0.993;
eta_mL = 0.997;
pi_np = 0.99;
pi_ns = 0.99;

g =  9.80665;
alt = 11000;
M_0 = 0.85;
h = 43e6;
T_t4 = 1450;
R_g = 287;
R = R_g;
gamma_c = 1.4;
gamma_t = 1.3;
Cp_c = gamma_c /(gamma_c-1) * R_g;
Cp_t = gamma_t /(gamma_t-1) * R_g;

T_0 = 288.15 - 0.0065*alt;
p_0 = 101325*(T_0/288.15)^5.256;
a_0 = sqrt(gamma_c*R_g*T_0);
    
delta_0 = (1 + (gamma_c-1)/2 * M_0^2)^(gamma_c/(gamma_c-1));
theta_0 = 1 + (gamma_c-1)/2 * M_0^2;
    
T_t0 = theta_0 * T_0;
T_t2 = T_t0;

tau_LPC = 1 + (pi_LPC ^ ((gamma_c - 1)/gamma_c) - 1 )/eta_LPC;
tau_HPC = 1 + (pi_HPC ^ ((gamma_c - 1)/gamma_c) - 1 )/eta_HPC;
    
T_t3 = T_t2 * tau_LPC * tau_HPC;

f = (Cp_t *T_t4 - Cp_c*T_t3)/(eta_b * h - Cp_t *T_t4);

 
tau_HPT = 1 - (Cp_c*T_t2*tau_LPC*(tau_HPC-1))/(eta_mH*Cp_t*T_t4*(1+f));
pi_HPT = (1 - (1-tau_HPT)/(eta_HPT))^(gamma_t/(gamma_t-1));

%% u19

for i = 1:length(pi_f)
    tau_f(i) = ((pi_f(i))^((gamma_c-1)/(gamma_c))-1)/(eta_f)+1;
    tau_LPT(i) = 1 - ((Cp_c*T_t2*((tau_LPC-1)+ alpha*(tau_f(i)-1))) / (eta_mL*tau_HPT*Cp_t*T_t4*(1+f)));
    pi_LPT(i) = (1 - (1-tau_LPT(i))/(eta_LPT))^(gamma_t/(gamma_t-1));
    M_19(i) = sqrt((2/(gamma_c-1))*((delta_0*pi_f(i)*pi_d*pi_ns)^((gamma_c-1)/(gamma_c))-1));
    T_19(i) = (T_t0*tau_f(i))/(1+((gamma_c-1)/(2))*(M_19(i))^2);
    u_19(i) = (M_19(i))*sqrt(gamma_c*R*(T_19(i)));
end

%% u9

for j = 1:length(pi_f)
    p_t9(j) = p_0*delta_0*pi_d*pi_f(j)*pi_LPC*pi_HPC*pi_b*pi_HPT*pi_LPT(j)*pi_np;
    M_9(j) = sqrt((2/(gamma_t-1))*(((p_t9(j))/(p_0))^((gamma_t-1)/(gamma_t))-1));
    T_t9(j) = T_t4 * tau_HPT * tau_LPT(j);
    T_9(j) = T_t9(j) / (1+((gamma_t-1)/2) * (M_9(j))^2);
    u_9(j) = M_9(j) * sqrt(gamma_t * R_g * T_9(j));
end

%% eta P

u_0 = M_0*a_0;
for k = 1:length(pi_f)
    eta_p(k) = (2*u_0*((1+f)*u_9(k)+alpha*u_19(k)-(1+alpha)*u_0))/((1+f)*u_9(k)^2+alpha*u_19(k)^2-(1+alpha)*u_0^2);
end

subplot(3,1,1)
plot(pi_f,u_19,'LineWidth',1)
title('u_{19} vs \pi_f')
xlabel('\pi_f')
ylabel('u_{19} (m/s)')

subplot(3,1,2)
plot(pi_f,u_9,'LineWidth',1)
title('u_9 vs \pi_f')
xlabel('\pi_f')
ylabel('u_{9} (m/s)')

subplot(3,1,3)
plot(pi_f,eta_p,'LineWidth',1)
title('\eta_p vs \pi_f')
xlabel('\pi_f')
ylabel('\eta_p')