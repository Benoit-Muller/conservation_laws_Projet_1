%% Problem 2.a),b)
clear
prob2a=make_prob("2a6");
meth.G= @(prob,meth) G_LF(prob,meth);
show.yes=0;
figure()
ax1=subplot(2,1,1);
title("\bf Problem 1.2.a): $h$","interpreter","latex")
ax2=subplot(2,1,2);
title("\bf Problem 1.2.a): $m$","interpreter","latex")
NN=2.^([5:11,14]); % donne un bon truc avec [5:10,14] pour 2a5 [6:10,14] pour 2a6
Q=zeros(2,NN(1)+1,length(NN));
j=1;
legends=[];
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
error=sqrt(sum((Q(:,:,1:end-1)-Q(:,:,end)).^2,1)); % ||.||_2 norm for each point
error=sum(error,2)* (2/NN(1)); % ||.||_h,1 norm for each case of N 
error=squeeze(error);
figure()
loglog(2./NN(1:end-1),error,'.-',2./NN(1:end-1),2./NN(1:end-1))
legend("error","h")
title("\bf Problem 1.2.a): Error of the scheme at $T=2$" + ...
    " as a function of $\Delta x$" , 'interpreter','latex')
xlabel("$\bf \Delta x$",'interpreter','latex')
ylabel("$\bf Error$",'interpreter','latex')