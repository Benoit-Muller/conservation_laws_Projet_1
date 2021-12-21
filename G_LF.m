function meth = G_LF(prob, meth)
    g=1;
    CFL=0.5;
    Qext = prob.bound(meth.Q);
    int=2:(meth.N+2);
    uu= meth.Q(2,:)./meth.Q(1,:);
    gradnorm = max( abs(uu) + sqrt(g*meth.Q(1,:)));
    k = CFL*meth.dx / gradnorm;
    if meth.t+k<=prob.T   % it is not exceeding T or we reached it already
        lambda = CFL / gradnorm; %=k/dx;
    else % it is not exceeding T
        k= prob.T-meth.t;
        lambda= k/meth.dx;
    end
    flux= f(Qext(1,:),Qext(2,:));
    SS= prob.S(meth.x,meth.t+k/2);
    meth.Q= 0.5*(Qext(:,int+1) + Qext(:,int-1))...
        -0.5*lambda*(flux(:,int+1) - flux(:,int-1)) + k*SS;
    meth.t= meth.t + k;
end