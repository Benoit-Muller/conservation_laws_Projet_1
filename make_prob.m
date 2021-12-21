function prob = make_prob(question)
    periodic_bound = @(Q) [Q(:,end), Q, Q(:,1)];
    open_bound     = @(Q) [Q(:,1), Q, Q(:,end)];
    switch question
        case "1a"
            u=0.25;
            g=1;
            h0 = @(x) 1 + 0.5*sin(pi*x);
            m0 = @(x) u*h0(x);
            h_true = @(x,t) h0(x-t);
            m_true = @(x,t) u*h_true(x,t);

            prob.q0 = @(x) [h0(x); m0(x)];
            prob.q_true = @(x,t) [h_true(x,t); m_true(x,t)];
            prob.S= @(x,t) pi/2*cos(pi*(x-t)) .* ...
                [(u-1)*ones(1,length(x)) ; u^2-u+g*h0(x-t)];
            prob.T=2;
            prob.bound=periodic_bound;
        case "2a5"
            h0 = @(x) 1 - 0.1*sin(pi*x);
            m0 = @(x) zeros(size(x));
            prob.q0 = @(x) [h0(x); m0(x)];
            prob.S= @(x,t) zeros(size(x));
            prob.T=2;
            prob.bound=periodic_bound;
        case "2a6"
            h0 = @(x) 1 - 0.2*sin(2*pi*x);
            m0 = @(x) 0.5*ones(size(x));
            prob.q0 = @(x) [h0(x); m0(x)];
            prob.S= @(x,t) zeros(size(x));
            prob.T=2;
            prob.bound=periodic_bound;
        case "4a"
            h0 = @(x) ones(size(x));
            m0 = @(x) -1.5*(x<1);
            prob.q0 = @(x) [h0(x); m0(x)];
            prob.S= @(x,t) zeros(size(x));
            prob.T=0.5;
            prob.bound=open_bound;
    end
end