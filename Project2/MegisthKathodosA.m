function [min_f, min_x, min_y, f_values] = MegisthKathodosA(f, x_val, y_val, gamma, e)
    %Steepest descent constant gamma

    syms x y;
    
    f_sym = f(x,y);
    grad_f_sym = gradient(f_sym);

    grad_f = matlabFunction(grad_f_sym);

    grad = grad_f(x_val,y_val);

    f_values = [f(x_val,y_val)];

    while norm(grad) > e
        x_val = x_val - gamma * grad(1);
        y_val = y_val - gamma * grad(2);
        grad = grad_f(x_val,y_val);
        f_values = [f_values, f(x_val,y_val)];
    end
    min_f = f(x_val,y_val);
    min_x = x_val;
    min_y = y_val;
end

