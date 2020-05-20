function manual_optim()
    % input
    alpha = 12.25;
    pi_f = 1.52;
    pi_LPC =  4.1;
    pi_HPC = 6.3;
    convergent_only = true;
    %%%%%%%
    n = 801000;
    i =1;
    tsps = zeros(1,n);
    maxTsp = 0;
    param = zeros(1,4);

    for alpha=linspace(4,14,30)
        for pi_f=linspace(0.6,1.6,30)
            for pi_LPC=linspace(4,10,30)
                for pi_HPC=linspace(4,10,30)

                   [tsp,isp] =turbofan_analysis(alpha, pi_f, pi_LPC, pi_HPC, convergent_only);
                    if maxTsp < tsp
                        maxTsp = tsp;
                        param(1,1)= alpha;
                        param(1,2)= pi_f;
                        param(1,3)= pi_LPC;
                        param(1,4)= pi_HPC;
                    end
                    i = i+1;
                    if i > n
                        disp(maxTsp);
                        disp(param);
                        return
                        break
                    end
                end
            end
        end
    end

end