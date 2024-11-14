function [min_f, min_x, min_y, f_values] = MegisthKathodosB(f, x_val, y_val, e)
    %Steepest descent gamma based on minimizing f(xk - gamma*gradf(xk))

    syms x y;
    
    f_sym = f(x,y);
    grad_f_sym = gradient(f_sym);

    grad_f = matlabFunction(grad_f_sym);

    grad = grad_f(x_val,y_val);
    f_values = [f(x_val,y_val)];

    while norm(grad) > e
        line_search_f = @(gamma) f(x_val-gamma*grad(1), y_val-gamma*grad(2));
        gamma = fminbnd(line_search_f, 0,1);
        x_val = x_val - gamma * grad(1);
        y_val = y_val - gamma * grad(2);
        grad = grad_f(x_val,y_val);
        f_values = [f_values, f(x_val,y_val)];
    end
    min_f = f(x_val,y_val);
    min_x = x_val;
    min_y = y_val;
end

