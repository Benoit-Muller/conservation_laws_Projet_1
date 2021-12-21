%% problem 1.a),b)
clear
prob1a = make_prob("1a");
meth.N=500;
meth.G= @(prob,meth) G_LF(prob,meth);
show.yes=1;
show.freq=10;

meth=shallow_water(prob1a, meth, show);

%% suite de problem 1.b)
clear
prob1a = make_prob("1a");
meth.G= @(prob,meth) G_LF(prob,meth);
show.yes=0;
NN=floor(logspace(2,3,10)); %mets (2,3,10)
error=[];
for N=NN
    meth.N=N;
    meth= shallow_water(prob1a, meth, show);
    Q_true= prob1a.q_true(meth.x,prob1a.T);
    norm=sqrt(sum((Q_true - meth.Q).^2,1)); % ||.||_2 norm for each point
    norm= meth.dx*sum(norm); % ||.||_1,h norm of all points
    error=[error, norm];
end
loglog(2./NN,error,'.-')
title("\bf Problem 1.1.b): Error of the scheme at $T=2$" + ...
    " as a function of $\Delta x$" , 'interpreter','latex')
xlabel("$\bf \Delta x$",'interpreter','latex')
ylabel("$\bf Error$",'interpreter','latex')
