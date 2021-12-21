function meth = G_Roe(prob, meth)
    CFL= 0.5;
    g=1;
    Qext = prob.bound(meth.Q);
    uu= meth.Q(2,:) ./ meth.Q(1,:);
    gradnorm = max( abs(uu) + sqrt(g*meth.Q(1,:)));
    k = CFL*meth.dx / gradnorm;
    if meth.t+k <= prob.T   % it is not exceeding T or we reached it already
        lambda = CFL / gradnorm; %=k/dx;
    else % it is not exceeding T
        k= prob.T - meth.t;
        lambda= k / meth.dx;
    end
    flux = zeros(size(meth.Q));
    for j=1:meth.N+2
        flux(:,j)=F(Qext(:,j),Qext(:,j+1));
    end
    SS= prob.S(meth.x,meth.t+k/2);
    meth.Q = meth.Q - lambda*(flux(:,2:end) - flux(:,1:end-1)) + k*SS;
    meth.t = meth.t+k;
end

function absA = abs_roe_matrix(Ql,Qr)
    g=1;
    Q = [Ql,Qr];
    Z = Q./sqrt(Q(1,:));
    t = sqrt(g*mean(Z(1,:).^2));
    r = mean(Z(2,:)) / mean(Z(1,:));
    s=t+r;
    d=t-r;
    absA = [s*abs(d)+d*abs(s)  , abs(s)-abs(d);
         s*d*(abs(s)-abs(d)), s*abs(s)+d*abs(d)] / (2*t);
end

 function flux = F(u,v)
    g=1;
    absA= abs_roe_matrix(u,v);
    flux = 0.5*(f(u(1),u(2)) + f(v(1),v(2))) - 0.5*absA*(v-u);
 end

%  function A=abs_roe_matrix_old(Ql,Qr)
%     g=1;
%     Q = [Ql,Qr];
%     Z = Q./sqrt(Q(1,:));
%     ratio = mean(Z(2,:)) / mean(Z(1,:));
%     A = [0 , 1 ; g*mean(Z(1,:).^2) - ratio^2 , 2*ratio ];
%     [V,D] = eig(A);
%     A = V*abs(D)/V;
% end