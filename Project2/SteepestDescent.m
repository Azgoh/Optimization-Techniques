function [min_f, min_x, min_y, f_values] = SteepestDescent(f, x_val, y_val, e, varargin)
    %Εάν υπάρχει το γ, τότε κάνουμε το α υποερώτημα, δηλαδή μέγιστη κάθοδος
    %με σταθερό γ.
    %Εάν δεν υπάρχει και useArmijo=false (default) τότε β υποερώτημα
    %Εάν δεν υπάρχει και useArmijo=true τότε γ υποερώτημα

    syms x y;
    parser = inputParser;

    %Υποχρεωτικά ορίσματα
    addRequired(parser, 'f',@(g) isa(g,'function_handle') && nargin(g) == 2); %Έλεγχος f για 2 μεταβλητές
    addRequired(parser, 'x_val', @isnumeric);
    addRequired(parser, 'y_val', @isnumeric);
    addRequired(parser, 'e', @(val) isnumeric(val) && val>0); %Έλεγχος ε για θετικό αριθμό
    
    %Προεραιτικά ορίσματα
    addOptional(parser, 'gamma', [], @(val) isempty(val) || isnumeric(val));
    addOptional(parser, 'armijo', false, @(val) islogical(val));

    parse(parser, f, x_val, y_val, e, varargin{:});
    params = parser.Results;

    gamma = params.gamma;
    useArmijo = params.armijo; 

    a = 1e-4; %Armijo a
    b = 0.2; %Armijo b
    s = 1; %Αρχικό βήμα
    
    f_sym = f(x,y);
    grad_f_sym = gradient(f_sym);

    grad_f = matlabFunction(grad_f_sym);
    grad = grad_f(x_val,y_val);
    
    f_values = [f(x_val,y_val)];

    while norm(grad) > e

        if useArmijo && isempty(gamma) %Μέθοδος armijo αφού γ δεν παρέχεται και useArmijo=true
            dk = -grad;
            m_k = 0; %Ξεκινάμε με τον μικρότερο μη αρνητικό ακέραιο
            gamma_arm = s * b^(m_k); %Armijo rule to find gamma
            fxk = f(x_val, y_val);
            grad_dot_dk = dk' * grad;
            %Επαναληπτικός κανόνας μέχρι να βρεθεί σωστό m_k
            while fxk - f(x_val + gamma_arm*dk(1), y_val + gamma_arm*dk(2) ) <= - a*gamma_arm*grad_dot_dk
                m_k = m_k + 1;
                gamma_arm = s * b^m_k;
            end
            x_val = x_val - gamma_arm * grad(1);
            y_val = y_val - gamma_arm * grad(2);
            grad = grad_f(x_val,y_val);
            f_values = [f_values, f(x_val,y_val)];

        elseif ~useArmijo && isempty(gamma) %Μέθοδος ελαχιστοποίησης αφού γ δεν παρέχεται και useArmijo=false
            line_search_f = @(gamma) f(x_val-gamma*grad(1), y_val-gamma*grad(2));
            gamma_min = fminbnd(line_search_f, 0,1);
            x_val = x_val - gamma_min * grad(1);
            y_val = y_val - gamma_min * grad(2);
            grad = grad_f(x_val,y_val);
            f_values = [f_values, f(x_val,y_val)];

        else %Μέθοδος σταθερού γ
            x_val = x_val - gamma * grad(1);
            y_val = y_val - gamma * grad(2);
            grad = grad_f(x_val,y_val);
            f_values = [f_values, f(x_val,y_val)];
        end 
    end
    min_f = f(x_val,y_val);
    min_x = x_val;
    min_y = y_val;
end

