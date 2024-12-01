function [min_f, min_x, min_y, f_values] = SteepestDescent(f, x_val, y_val, e, gamma)

    syms x y;
    parser = inputParser;

    %Υποχρεωτικά ορίσματα
    addRequired(parser, 'f',@(g) isa(g,'function_handle') && nargin(g) == 2); %Έλεγχος f για 2 μεταβλητές
    addRequired(parser, 'x_val', @isnumeric);
    addRequired(parser, 'y_val', @isnumeric);
    addRequired(parser, 'e', @(val) isnumeric(val) && val>0); %Έλεγχος ε για θετικό αριθμό
    addRequired(parser, 'gamma', @(val) isnumeric(val) && val>0);

    parse(parser, f, x_val, y_val, e, gamma);
   
    f_sym = f(x,y);
    grad_f_sym = gradient(f_sym);

    grad_f = matlabFunction(grad_f_sym);
    grad = grad_f(x_val,y_val);
    
    f_values = [f(x_val,y_val)];

    while norm(grad) > e
        dk = -grad;
        x_val = x_val + gamma * dk(1);
        y_val = y_val + gamma * dk(2);
        grad = grad_f(x_val,y_val);
        f_values = [f_values, f(x_val,y_val)];
    end
    min_f = f(x_val,y_val);
    min_x = x_val;
    min_y = y_val;
end

