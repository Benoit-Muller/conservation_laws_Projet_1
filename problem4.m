%% Problem 4.b)
clear
prob4a = make_prob("4a");
meth.N=1000;
meth.G= @(prob,meth) G_LF(prob,meth);
show.yes=1;
show.freq=100;

meth=shallow_water(prob4a, meth, show);
Qref=meth.Q;
%% suite of Problem 4.b)
clear
prob4a = make_prob("4a");
meth.G= @(prob,meth) G_LF(prob,meth);
show.yes=0;
show.freq=100;
NN=logspace(2,3.5,5); % (2,3.5,5)
figure()
ax1=subplot(2,1,1);
ax2=subplot(2,1,2);
legends=string([]);
for N=NN
    meth.N=N;
    meth=shallow_water(prob4a, meth, show);
    subplot(2,1,1)
    plot(meth.x,meth.Q(1,:))
    legends= [legends, "$\Delta x = "+ num2str(meth.dx)+"$" ];
    hold on
    subplot(2,1,2)
    plot(meth.x,meth.Q(2,:))
    hold on
end
legend(ax1,legends,"interpreter","latex")
legend(ax2,legends,"interpreter","latex")
title(ax1,"Problem 4 b): h-solutions with the Lax-Friedrichs scheme" +...
    " at time T = 0.5 with varying mesh size")
title(ax2,"Problem 4 b): m-solutions with the Lax-Friedrichs scheme" +...
    " at time T = 0.5 with varying mesh size")
hold off

%% Problem 4.c)
clear
prob4a = make_prob("4a");
meth.N=1000;
meth.G= @(prob,meth) G_Roe(prob,meth);
show.yes=1;
show.freq=100;

meth=shallow_water(prob4a, meth, show);
Qref=meth.Q;
%% suite of Problem 4.c)
clear
prob4a = make_prob("4a");
meth.G= @(prob,meth) G_Roe(prob,meth);
show.yes=0;
show.freq=100;
NN=logspace(2,3,5); % 
figure()
ax1=subplot(2,1,1);
ax2=subplot(2,1,2);
legends=string([]);
for N=NN
    meth.N=N;
    meth=shallow_water(prob4a, meth, show);
    subplot(2,1,1)
    plot(meth.x,meth.Q(1,:))
    legends= [legends, "$\Delta x = "+ num2str(meth.dx)+"$" ];
    hold on
    subplot(2,1,2)
    plot(meth.x,meth.Q(2,:))
    hold on
end
legend(ax1,legends,"interpreter","latex")
legend(ax2,legends,"interpreter","latex")
title(ax1,"Problem 4 b): h-solutions with the Lax-Friedrichs scheme" +...
    " at time T = 0.5 with varying mesh size")
title(ax2,"Problem 4 b): m-solutions with the Lax-Friedrichs scheme" +...
    " at time T = 0.5 with varying mesh size")
hold off