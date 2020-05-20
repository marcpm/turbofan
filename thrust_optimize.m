clear;
clc;
% initial alpha, pi_f, pi_LPC,  pi_HPC
x_0 = [7.2573, 1.1, 2.12, 4.12];


lb = [7, 0.77, 1.1, 1.1];
ub = [12.7, 2, 8, 8]; 

options = optimoptions('fmincon','Display','iter','Algorithm','sqp','FiniteDifferenceType', 'central', 'OptimalityTolerance',1e-9,'ConstraintTolerance', 1e-9 ,'MaxIterations', 3000, 'MaxFunctionEvaluations', 5000, 'StepTolerance', 1e-5);

A = [];
b = [];
Aeq = [];
beq = [];
nonlncn = [];
[x,fval,exitflag,output] = fmincon(@turbofan_optimize,x_0,A,b,Aeq,beq,lb,ub,nonlncn, options)

fprintf('\n\nF/m_dot: %f  Obtenido con: \n  alpha:%f \n  pi_f: %f \n  pi_LPC: %f \n  pi_HPC: %f \n',fval, x)
function [n_F_sp] = turbofan_optimize(x) 
    % returns specific Thrust in negative form. 
    alpha = x(1);
    pi_f = x(2);
    pi_LPC = x(3);
    pi_HPC = x(4);
    
    convergent = false;

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

    
    [a] = turbofan_analysis(alpha, pi_f, pi_LPC, pi_HPC, convergent); 
    n_F_sp = -1.0 * a;
end
