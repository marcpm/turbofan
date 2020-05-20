clear;
clc;
%%%%%%%%
% input
alpha = 12.25;
pi_f = 1.52;
pi_LPC =  4.1;
pi_HPC = 6.3;
convergent_only = true;
%%%%%%%

%%% 
data.alt = 11000;
data.M_0 = 0.85;
data.h = 43e6;
data.T_t4 = 1450;

data.pi_d = 0.98;
data.eta_f = 0.89;
data.eta_LPC = 0.88;
data.eta_HPC = 0.86;
data.pi_b = 0.96;
data.eta_b = 0.99;
data.eta_HPT = 0.91;
data.eta_LPT = 0.92;
data.eta_mH = 0.993;
data.eta_mL = 0.997;
data.pi_np = 0.99;
data.pi_ns = 0.99;



[F_sp, I_sp] = turbofan_run(alpha, pi_f, pi_LPC, pi_HPC, data, convergent_only) ;


function [F_sp, I_sp, F_ratio] = turbofan_run(alpha, pi_f, pi_LPC, pi_HPC, data, convergent_only) 
% convergent_only:true impose convergent_only only nozzle, set to false to allow
% convergent_only-divergent nozzles.
% 
% Returns Specific Thrust, Specific Thrust ratio provided by core flow, and
% Specific Impulse

    printing = true;
    % consts
    g =  9.80665;
    R_g = 287;
    gamma_c = 1.4;
    gamma_t = 1.3;
    Cp_c = gamma_c /(gamma_c-1) * R_g;
    Cp_t = gamma_t /(gamma_t-1) * R_g;

    % alias data from struct
    alt = data.alt;
    M_0 = data.M_0 ;
    
    h = data.h;
    T_t4 = data.T_t4;
    pi_d = data.pi_d ;
    eta_f = data.eta_f ;
    eta_LPC = data.eta_LPC ;
    eta_HPC = data.eta_HPC ;
    pi_b = data.pi_b ;
    eta_b = data.eta_b ;
    eta_HPT = data.eta_HPT ;
    eta_LPT = data.eta_LPT ;
    eta_mH = data.eta_mH ;
    eta_mL = data.eta_mL ;
    pi_np = data.pi_np ;
    pi_ns = data.pi_ns ;

    % calcs
    T_0 = 288.15 - 0.0065*alt;
    p_0 = 101325*(T_0/288.15)^5.256;
    a_0 = sqrt(gamma_c*R_g*T_0);
    
    delta_0 = (1 + (gamma_c-1)/2 * M_0^2)^(gamma_c/(gamma_c-1));
    theta_0 = 1 + (gamma_c-1)/2 * M_0^2;
    
    T_t0 = theta_0 * T_0;
    T_t2 = T_t0;
    
    
    tau_f = (pi_f ^ ((gamma_c - 1)/gamma_c) - 1 )/eta_f + 1;
    
%     tau_PC = @(pi_PC, eta_PC) (pi_PC ^ ((1.4 - 1)/1.4) - 1 )/eta_PC + 1;
    tau_LPC = 1 + (pi_LPC ^ ((gamma_c - 1)/gamma_c) - 1 )/eta_LPC;
    tau_HPC = 1 + (pi_HPC ^ ((gamma_c - 1)/gamma_c) - 1 )/eta_HPC;
    
    T_t3 = T_t2 * tau_LPC * tau_HPC;

    f = (Cp_t *T_t4 - Cp_c*T_t3)/(eta_b * h - Cp_t *T_t4);

 
    tau_HPT = 1 - (Cp_c*T_t2*tau_LPC*(tau_HPC-1))/(eta_mH*Cp_t*T_t4*(1+f));
    tau_LPT = 1 - ((Cp_c*T_t2*((tau_LPC-1)+ alpha*(tau_f-1))) / (eta_mL*tau_HPT*Cp_t*T_t4*(1+f)));
    
% turbojet
%   tau_HPT = 1 - ((Cp_c*T_t2*tau_LPC*(tau_HPC-1))/(eta_mH*(1+f)*Cp_t*T_t4));
%   tau_LPT = 1 - (((Cp_c*T_t2*(tau_LPC-1))/(eta_mL*(1+f)*Cp_t*T_t4*tau_HPT)));
% _________

% turbofan
    pi_HPT = (1 - (1-tau_HPT)/(eta_HPT))^(gamma_t/(gamma_t-1));
    pi_LPT = (1 - (1-tau_LPT)/(eta_LPT))^(gamma_t/(gamma_t-1));
    
    % core flow
    
    T_t9 = T_t4 * tau_LPT * tau_HPT;
    p_t9_p0 = delta_0*pi_d * pi_LPC*pi_HPC*pi_b*pi_HPT*pi_LPT*pi_np;
    M_9 = sqrt(2/(gamma_t-1) * ((p_t9_p0)^((gamma_t-1)/gamma_t) -1 ));

    fprintf('p_t9_p0: %f  >  %f\n', p_t9_p0, ((1+gamma_t)/2)^(gamma_t/(gamma_t-1)));
    % convergent_only condition
    if ((M_9 > 1) && (convergent_only==true))
        M_9 = 1;
    end
    fprintf('M_9: %f\n', M_9);
    T_9 = T_t9 / (1+(gamma_t-1)/2 * M_9^2);
    U_9 = M_9 * sqrt(gamma_t * R_g * T_9);
    p_9 = (p_t9_p0*p_0)/(1+(gamma_t-1)/2 * M_9^2)^(gamma_t/(gamma_t-1));
    fprintf('p_9/p_0: %f\n', p_9/p_0);

    % bypass flow
    
    p_t19_p0 = delta_0 * pi_d * pi_f * pi_ns;
    T_t19 = T_0*theta_0 * tau_f;
    M_19 = sqrt(2/(gamma_c-1) * ((p_t19_p0)^((gamma_c-1)/gamma_c) -1 ));
    
    % convergent_only condition
    if ((M_19 > 1) && (convergent_only==true))
        M_19 = 1;
    end
    T_19 = T_t19 / (1+(gamma_c-1)/2 * M_19^2);
    U_19 = M_19 * sqrt(gamma_c * R_g * T_19);
    p_19 = (p_t19_p0*p_0)/(1+(gamma_c-1)/2 * M_19^2)^(gamma_c/(gamma_c-1));
    
     fprintf('M_19: %f\n', M_19);
    fprintf('p_19/p_0: %f\n', p_19/p_0);
    
    

    p_9A_9_m_dot = ((1+f)* R_g * T_9)/U_9;
    p_19A_19_m_dot = alpha * (R_g * T_19)/U_19;

    
    
%     F_sp = (1+f) * U_9 - M_0*a_0 + p_9A_9_m_dot*(1-p_0/p_9) ...
%     + alpha*(U_19 - M_0*a_0) + p_19A_19_m_dot*(1-p_0/p_19);
    F_sp_core = (1+f) * U_9 - M_0*a_0 + p_9A_9_m_dot*(1-p_0/p_9);
    F_sp_bypass = alpha*(U_19 - M_0*a_0) + p_19A_19_m_dot*(1-p_0/p_19);

    F_sp = F_sp_core + F_sp_bypass;
    I_sp = F_sp * 1/(f*g);
    F_ratio = F_sp_core / F_sp;
    

    if printing==true
        fprintf('F/m_dot: %f \nI_sp: %f \nCore flow %f.3%%  Bypass flow: %f.3%% \n', F_sp, I_sp,F_ratio*100, (1-F_ratio)*100); 
        
    end
end


