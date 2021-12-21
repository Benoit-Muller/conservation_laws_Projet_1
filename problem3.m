%% problem 3 d) : prob 1.a)
clear
prob1a = make_prob("1a");
meth.N=500;
meth.G= @(prob,meth) G_Roe(prob,meth);
show.yes=1;
show.freq=10;

meth=shallow_water(prob1a, meth, show);

%% suite de problem 3 d) : prob 1.a)
clear
prob1a = make_prob("1a");
meth.G= @(prob,meth) G_Roe(prob,meth);
show.yes=0;
NN=floor(logspace(2,3,5));  % mets (2,3,5)
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
title("\bf problem 3 d) : prob 1.a): Error of the scheme at $T=2$" + ...
    " as a function of $\Delta x$" , 'interpreter','latex')
xlabel("$\bf \Delta x$",'interpreter','latex')
ylabel("$\bf Error$",'interpreter','latex')

%% problem 3 d) : Prob 2.a),b)

clear
prob2a=make_prob("2a5");
meth.G= @(prob,meth) G_Roe(prob,meth);
show.yes=0;
figure()
ax1=subplot(2,1,1);
ax2=subplot(2,1,2);
NN=2.^([5:8,10]); % donne un bon truc avec
Q=zeros(2,NN(1)+1,length(NN));
j=1;
legends=string([]);
for N=NN
    meth.N=N;
    meth=  shallow_water(prob2a, meth, show);
    subplot(2,1,1)
    plot(meth.x,meth.Q(1,:))
    hold on
    subplot(2,1,2)
    text="\bf $\Delta x =" + num2str(meth.dx) + "$";
    plot(meth.x,meth.Q(2,:))
    legends= [legends,"\bf $\Delta x =" + num2str(meth.dx) + "$" ];
    hold on
    index= 1:N/NN(1):N+1;
    Q(:,:,j) = meth.Q(:,index);
    j=j+1;
end
hold off
legend(ax1,legends,"interpreter","latex")
legend(ax2,legends,"interpreter","latex")
title(ax1,"\bf problem 3 d) : Prob 2.a),b): $h$","interpreter","latex")
title(ax2,"\bf problem 3 d) : Prob 2.a),b): $h$","interpreter","latex")
error=sqrt(sum((Q(:,:,1:end-1)-Q(:,:,end)).^2,1)); % ||.||_2 norm for each point
error=sum(error,2)* (2/NN(1)); % ||.||_h,1 norm for each case of N 
error=squeeze(error);
figure()
loglog(2./NN(1:end-1),error,'.-',2./NN(1:end-1),2./NN(1:end-1))
legend("error","h")
title("\bf problem 3 d) : Prob 2.a),b): Error of the scheme at $T=2$" + ...
    " as a function of $\Delta x$" , 'interpreter','latex')
xlabel("$\bf \Delta x$",'interpreter','latex')
ylabel("$\bf Error$",'interpreter','latex')