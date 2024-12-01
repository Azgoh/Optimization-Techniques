function [min_f, min_x, min_y, f_values] = SteepestDescentWithPRx(f, x_val, y_val, e, gamma, sk)
    if x_val <= -10
        x_val = -10;
    elseif x_val >= 5
        x_val = 5;
    end
    if y_val <= -8
        y_val = -8;
    elseif y_val >= 12
        y_val = 12;
    end
    
    syms x y;
    parser = inputParser;

    %Υποχρεωτικά ορίσματα
    addRequired(parser, 'f',@(g) isa(g,'function_handle') && nargin(g) == 2); %Έλεγχος f για 2 μεταβλητές
    addRequired(parser, 'x_val', @isnumeric);
    addRequired(parser, 'y_val', @isnumeric);
    addRequired(parser, 'e', @(val) isnumeric(val) && val>0); %Έλεγχος ε για θετικό αριθμό
    addRequired(parser, 'gamma', @(val) isnumeric(val) && val>0);
    addRequired(parser, 'sk', @(val) isnumeric(val) && val>0)

    parse(parser, f, x_val, y_val, e, gamma, sk);
   
    f_sym = f(x,y);
    grad_f_sym = gradient(f_sym);

    grad_f = matlabFunction(grad_f_sym);
    grad = grad_f(x_val,y_val);
    
    f_values = [f(x_val,y_val)];

    while norm(grad) > e
        x_bar = x_val - sk*grad(1);
        y_bar = y_val - sk*grad(2);
        if x_bar <= -10
            x_bar = -10;
        elseif x_bar >= 5
            x_bar = 5;
        end
        if y_bar <= -8
            y_bar = -8;
        elseif y_bar >= 12
            y_bar = 12;
        end
        x_val = x_val + gamma * (x_bar - x_val);
        y_val = y_val + gamma * (y_bar - y_val);
        grad = grad_f(x_val,y_val);
        f_values = [f_values, f(x_val,y_val)];
    end
    min_f = f(x_val,y_val);
    min_x = x_val;
    min_y = y_val;
end
