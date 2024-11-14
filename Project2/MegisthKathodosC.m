function [min_f, min_x, min_y, f_values] = MegisthKathodosC(f, x_val, y_val, e)
    %Steepest descent gamma based on armijo rule

    syms x y;
    
    f_sym = f(x,y);
    grad_f_sym = gradient(f_sym);

    grad_f = matlabFunction(grad_f_sym);
    grad = grad_f(x_val,y_val); 

    f_values = [f(x_val,y_val)];

    a = 1e-4; %Armijo a
    b = 0.2; %Armijo b
    s = 1; %Αρχικό βήμα

    while norm(grad) > e
        dk = -grad;
        m_k = 0; %Ξεκινάμε με τον μικρότερο μη αρνητικό ακέραιο
        gamma = s * b^(m_k); %Armijo rule to find gamma
        fxk = f(x_val, y_val);
        grad_dot_dk = dk' * grad;

        %Επαναληπτικός κανόνας μέχρι να βρεθεί σωστό m_k
        while fxk - f(x_val + gamma*dk(1), y_val + gamma*dk(2) ) <= - a*gamma*grad_dot_dk
            m_k = m_k + 1;
            gamma = s * b^m_k;
        end
        
        x_val = x_val + gamma * dk(1);
        y_val = y_val + gamma * dk(2);
        grad = grad_f(x_val,y_val);
        f_values = [f_values, f(x_val,y_val)];
    end
    min_f = f(x_val,y_val);
    min_x = x_val;
    min_y = y_val;
end