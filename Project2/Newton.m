function [min_f, min_x, min_y, f_values] = Newton(f, x_val, y_val, e, varargin)
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
    s = 1000; %Αρχικό βήμα
    
    f_sym = f(x,y);
    grad_f_sym = gradient(f_sym);
    hessian_f_sym = hessian(f_sym);

    grad_f = matlabFunction(grad_f_sym);
    hessian_f = matlabFunction(hessian_f_sym);

    grad = grad_f(x_val,y_val);
    hess = hessian_f(x_val, y_val);
    hess = hess + 1.2*eye(2); %Αρνητικα ορισμενος hessian οποτε προσθετουμε damping κI
    f_values = [f(x_val,y_val)];
 
    while norm(grad) > e
        dk = -(inv(hess))*grad;

        if useArmijo && isempty(gamma) %Μέθοδος armijo αφού γ δεν παρέχεται και useArmijo=true
            m_k = 0; %Ξεκινάμε με τον μικρότερο μη αρνητικό ακέραιο
            gamma_arm = s * b^(m_k); %Armijo rule to find gamma
            fxk = f(x_val, y_val);
            grad_dot_dk = dk' * grad;
            %Επαναληπτικός κανόνας μέχρι να βρεθεί σωστό m_k
            while fxk - f(x_val + gamma_arm*dk(1), y_val + gamma_arm*dk(2) ) <= - a*gamma_arm*grad_dot_dk
                m_k = m_k + 1;
                gamma_arm = s * b^m_k;
            end
            x_val = x_val + gamma_arm * dk(1);
            y_val = y_val + gamma_arm * dk(2);

        elseif ~useArmijo && isempty(gamma) %Μέθοδος ελαχιστοποίησης αφού γ δεν παρέχεται και useArmijo=false
            line_search_f = @(gamma) f(x_val+gamma*dk(1), y_val+gamma*dk(2));
            gamma_min = XrysosTomeas(line_search_f, 0, 10, 0.001, 0.618);
            x_val = x_val + gamma_min * dk(1);
            y_val = y_val + gamma_min * dk(2);

        else %Μέθοδος σταθερού γ
            x_val = x_val + gamma * dk(1);
            y_val = y_val + gamma * dk(2);
        end 
        grad = grad_f(x_val,y_val);
        hess = hessian_f(x_val, y_val) + 1.2*eye(2);
        f_values = [f_values, f(x_val,y_val)];
    end
    min_f = f(x_val,y_val);
    min_x = x_val;
    min_y = y_val;

end

