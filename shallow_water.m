function meth = shallow_water(prob, meth, show)
% prob: q_0, S, T, q_true
% meth: N, G
    a=0;
    b=2;
    meth.dx=(b-a)/meth.N;
    meth.x=a:meth.dx:b;
    meth.t=0;
    meth.Q=prob.q0(meth.x);
    iter = 0;
    if show.yes==1
        plot_every= meth.N / show.freq;
    end
    while meth.t<prob.T - 1e-10
            meth = meth.G(prob, meth);
        if show.yes==1 && mod(iter,plot_every)==0
            figure(1)
            title("test")
            subplot(2,1,1)
            area(meth.x,meth.Q(1,:),'LineWidth',2);
            xlim([0 2]); ylim([0 1.1]);
            if  isfield(prob,"q_true")
                Q_true= prob.q_true(meth.x,meth.t);
                hold on
                plot(meth.x,Q_true(1,:),'LineWidth',2)
                legend('Numerical h','Exact h');
                hold off
            end
            grid on;
            title(['Time = ',num2str(meth.t)]);

            subplot(2,1,2)
            plot(meth.x, meth.Q(2,:),'LineWidth',2);
            xlim([0 2]);  ylim([-2 2]);
            if isfield(prob,"q_true")
                hold on
                plot(meth.x,Q_true(2,:),'LineWidth',2);
                legend('Numerical m','Exact m');
                hold off
            end
            grid on;
            title(['Time = ',num2str(meth.t)]);
        end
        iter=iter+1;
    end
end