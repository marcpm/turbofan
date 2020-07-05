alpha = 12.25;
pi_f = 1.48;
pi_LPC = 4.1;
pi_HPC = 6.3;


% [F_sp, I_sp, F_ratio] = turbofan_analysis(alpha, pi_f, pi_LPC, pi_HPC, true) ;
% [F_spf, I_spf, F_ratiof] = turbofan_analysis(alpha, pi_f, pi_LPC, pi_HPC, false) ;
[F_spf, I_spf, F_ratiof] = turbofan_analysis(12.7, 1.52, 3.9, 6, true) ;
[F_sp, I_sp, F_ratio] = turbofan_analysis(12.7, 1.509, 3.5, 3.8, true);
disp(F_sp/F_spf)
disp(I_sp/I_spf )
% disp(F_ratio/F_ratiof)
