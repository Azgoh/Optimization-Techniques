function [calls, a_values, b_values] = Dixotomos(f, a, b, l, e)
%Dixotomos Εφαρμόζει την μέθοδο της διχοτόμου για να βρει το ελάχιστο μιας
%συνάρτησης f.
% @Output calls: Πόσες φορές υπολογίζεται η αντικειμενική συνάρτηση
% @Output a_values, b_values: Οι τιμές του διαστήματος (α_κ,β_κ) για κ επαναλήψεις
% @Input f: Η συνάρτηση f
% @Input a: Η αρχή του διαστήματος στην πρώτη επανάληψη
% @Input b: Το τέλος του διαστήματος στην πρώτη επανάληψη
% @Input l: Το εύρος αναζήτησης
% @Input e: Μια σταθερά για την αυξομοίωση των x1 και x2

    calls = 0;
    a_values = []; 
    b_values = []; 

    while (b - a) > l
        a_values = [a_values, a];
        b_values = [b_values, b];
        
        x1 = (a + b) / 2 - e;
        x2 = (a + b) / 2 + e;
        
        fx1_value = f(x1);
        calls = calls + 1;
        fx2_value = f(x2);
        calls = calls + 1;

        if fx1_value > fx2_value
            a = x1;
        else
            b = x2;
        end
    end
    
    a_values = [a_values, a];
    b_values = [b_values, b];
end

