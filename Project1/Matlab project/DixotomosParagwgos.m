function [calls, a_values, b_values] = DixotomosParagwgos(f, a, b, l)
    
%Χρησιμοποιώ το Symbolic Math Toolbox για να υπολογίσω την παράγωγο της f
%Το subs στην 16 το χρησιμοποιώ ώστε να μπορέσω να κάνω σύγκριση των τιμών
%της f_derivative μέσα στις if.
    syms x;
    f_sym = f(x);
    n = - log(l/(b-a))/log(2);
    calls = 0;
    a_values = []; 
    b_values = []; 

    for k = 1:n
        a_values = [a_values, a];
        b_values = [b_values, b];
        mid = (a+b)/2;
        f_derivative = subs(diff(f_sym,x), x, mid);
        calls = calls + 1;

        if f_derivative == 0
            min_x = mid;
            break;

        elseif f_derivative > 0
            b = mid;

        else 
            a = mid;
        end
     end
        
    a_values = [a_values, a];
    b_values = [b_values, b];
end

