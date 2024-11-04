%% Θέμα 3α

clc, clear

% Ορισμός ανώνυμων συναρτήσεων
f1 = @(x) (x-2)^2 + x*log(x+3);
f2 = @(x) exp(-2*x) + (x-2)^2;
f3 = @(x) exp(x)*((x^3) - 1) + (x-1)*sin(x);

a = -1;
b = 3;
l_array = linspace(0.001, 0.1, 50);
e = 0.001;

num_calc_f1 = zeros(size(l_array));
num_calc_f2 = zeros(size(l_array));
num_calc_f3 = zeros(size(l_array));

for i = 1:length(l_array)
    l = l_array(i);

    [num_calls_f1, a_values_f1, b_values_f1] = Fibonacci(f1, a, b, l, e);
    num_calc_f1(i) = num_calls_f1;

    [num_calls_f2, a_values_f2, b_values_f2] = Fibonacci(f2, a, b, l, e);
    num_calc_f2(i) = num_calls_f2;

    [num_calls_f3, a_values_f3, b_values_f3] = Fibonacci(f3, a, b, l, e);
    num_calc_f3(i) = num_calls_f3;

    % Ο κώδικας στην if αφορά το β ερώτημα και την σύγκριση των άκρων του
    % διαστήματος [a_k,b_k] για τις ακραίες τιμές του l(εάν τρέξουμε και τα 
    % γραφήματα του β section και τα συγκρίνουμε). Παρατηρούμε πως όσο
    % μικρότερο είναι το l, τόσο μικραίνει το διάστημα(αφού έτσι έχουμε 
    % και περισσότερες επαναλήψεις) και έτσι γίνεται καλύτερη προσέγγιση
    % του ελαχίστου.
    if i==1
        figure(2);
        k_values = 1:length(a_values_f1);
        plot(k_values, a_values_f1, '-o', k_values, b_values_f1, '-x');
        grid on;
        hold on;
        legend('a_k', 'b_k');
        title('Endpoints (a,k) and (b,k) based on number of iterations k for l=0.001 for f1');

        figure(3);
        k_values = 1:length(a_values_f2);
        plot(k_values, a_values_f2, '-o', k_values, b_values_f2, '-x');
        grid on;
        legend('a_k', 'b_k');
        title('Endpoints (a,k) and (b,k) based on number of iterations k for l=0.001 for f2');
        
        figure(4);
        k_values = 1:length(a_values_f3);
        plot(k_values, a_values_f3, '-o', k_values, b_values_f3, '-x');
        grid on;
        legend('a_k', 'b_k');
        title('Endpoints (a,k) and (b,k) based on number of iterations k for l=0.001 for f3');

    end

end

%Για μικρό l πρέπει να υπολογίσουμε την αντικειμενική συνάρτηση
%περισσότερες φορές. Λογικό αφού πρέπει Fn>(b-a)/l
figure(1);
plot(l_array, num_calc_f1);
hold on;
plot(l_array, num_calc_f2);
hold on;
plot(l_array, num_calc_f3);
grid on;
legend('f1(x)', 'f2(x)', 'f3(x)');
title('Number of fi(x) calculations based on a changing l value');

%% Θέμα 2β

% Τα γραφήματα έχουν γίνει για ένα τελικό l=0.1. Έτσι το τελικό διάστημα
% είναι μεγαλύτερο από ότι εάν γινόταν για μικρότερα l. Δηλαδή δεν γίνεται
% τόσο καλή εκτίμηση του ελαχίστου.
%
figure(5);
k_values = 1:length(a_values_f1);
plot(k_values, a_values_f1, '-o', k_values, b_values_f1, '-x');
grid on;
legend('a_k', 'b_k');
title('Endpoints (a,k) and (b,k) based on number of iterations k for l=0.1 for f1');

figure(6);
k_values = 1:length(a_values_f2);
plot(k_values, a_values_f2, '-o', k_values, b_values_f2, '-x');
grid on;
legend('a_k', 'b_k');
title('Endpoints (a,k) and (b,k) based on number of iterations k for l=0.1 for f2');

figure(7);
k_values = 1:length(a_values_f3);
plot(k_values, a_values_f3, '-o', k_values, b_values_f3, '-x');
grid on;
legend('a_k', 'b_k');
title('Endpoints (a,k) and (b,k) based on number of iterations k for l=0.1 for f3');



