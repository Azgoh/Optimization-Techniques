%% Θέμα 1α

clc, clear
%Ορισμός ανώνυμων συναρτήσεων
f1 = @(x) (x-2)^2 + x*log(x+3);
f2 = @(x) exp(-2*x) + (x-2)^2;
f3 = @(x) exp(x)*((x^3) - 1) + (x-1)*sin(x);

l = 0.01; %Τελικό εύρος αναζήτησης (τερματισμός διχοτόμου)
a = -1; %Αρχή του διαστήματος στην πρώτη επανάληψη
b = 3; %Τέλος του διαστήματος στην πρώτη επανάληψη

e_array = linspace(0.0001, 0.0049, 50); %Πρέπει ε<l/2 οπότε τελικό ε=0.0049

num_calc_f1 = zeros(size(e_array));
num_calc_f2 = zeros(size(e_array));
num_calc_f3 = zeros(size(e_array));

for i = 1:length(e_array)

    e = e_array(i);

    [num_calls_f1, ~, ~] = Dixotomos(f1, a, b, l, e);
    num_calc_f1(i) = num_calls_f1;

    [num_calls_f2, ~, ~] = Dixotomos(f2, a, b, l, e);
    num_calc_f2(i) = num_calls_f2;
    
    [num_calls_f3, ~, ~] = Dixotomos(f3, a, b, l, e);
    num_calc_f3(i) = num_calls_f3;

end

 %Τα γραφήματα βγαίνουν ίδια, για μικρές τιμές του ε έχω λιγότερες
 %επαναλήψεις αφού μειώνω το [a,b] πιο "επιθετικά", από όταν το 
 %ε παίρνει πιο μεγάλες τιμές.
 figure(1);
 plot(e_array, num_calc_f1);
 hold on;
 plot(e_array, num_calc_f2);
 hold on;
 plot(e_array, num_calc_f3);
 grid on;
 xlabel('ε'), ylabel('No of fi(x) calculations');
 legend({'f1(x)', 'f2(x)', 'f3(x)'}, 'Location','northwest');
 title('Number of fi(x) calucations based on ε values with a constant l=0.01');

%% Θέμα 1β

e = 0.001;
l_array = linspace(0.0021, 0.1, 50); %l>2e

num_calc_f1 = zeros(size(l_array));
num_calc_f2 = zeros(size(l_array));
num_calc_f3 = zeros(size(l_array));

for i = 1:length(l_array)

    l = l_array(i);

    [num_calls_f1, a_values_f1, b_values_f1] = Dixotomos(f1, a, b, l, e);
    num_calc_f1(i) = num_calls_f1;

    [num_calls_f2, a_values_f2, b_values_f2] = Dixotomos(f2, a, b, l, e);
    num_calc_f2(i) = num_calls_f2;

    [num_calls_f3, a_values_f3, b_values_f3] = Dixotomos(f3, a, b, l, e);
    num_calc_f3(i) = num_calls_f3;

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

 %Τα γραφήματα βγαίνουν ίδια, για μικρές τιμές του l έχω περισσότερες
 %επαναλήψεις εφόσον το [a,b] πρέπει να μικρύνει επαρκώς ώστε (b-a)<=l
 %ενώ για μεγαλύτερες τιμές του l δεν χρειάζομαι τόσες επαναλήψεις.

 figure(5);
 plot(l_array, num_calc_f1);
 hold on;
 plot(l_array, num_calc_f2);
 hold on;
 plot(l_array, num_calc_f3);
 grid on;
 xlabel('l'), ylabel('No of fi(x) calculations');
 legend({'f1(x)', 'f2(x)', 'f3(x)'}, 'Location','northwest');
 title('Number of fi(x) calucations based on l values');

%% Θέμα 1γ

 %Τα γραφήματα έχουν γίνει για ένα τελικό l=0.1. Εάν γίνουν και για
 %μεταβαλλόμενο l, θα έχουμε 3x50=150 (3funcs * 50l από το linspace) διαγράμματα. Αυτό που θα αλλάξει αν
 %μικρύνει το l θα είναι πως θα έχουμε περισσότερες επαναλήψεις, συνεπώς το
 %[a,b] θα γίνεται όλο και πιο μικρό (μεγαλύτερη ακρίβεια στον υπολογισμό του min).

 %Γράφημα για την f1
 figure(6);
 k_values = 1:length(a_values_f1);
 plot(k_values, a_values_f1, '-o', k_values, b_values_f1, '-x');
 xlabel('No of k iterations'), ylabel('Interval Endpoints');
 title('Endpoints (a,k) and (b,k) based on number of iterations k and for l=0.1 for f1');
 legend('a_k', 'b_k');
 grid on;

 %Γράφημα για την f2
 figure(7);
 k_values = 1:length(a_values_f2);
 plot(k_values, a_values_f2, '-o', k_values, b_values_f2, '-x');
 xlabel('No of k iterations'), ylabel('Interval Endpoints');
 title('Endpoints (a,k) and (b,k) based on number of iterations k for l=0.1 for f2');
 legend('a_k', 'b_k');
 grid on;

 %Γράφημα για την f3
 figure(8);
 k_values = 1:length(a_values_f3);
 plot(k_values, a_values_f3, '-o', k_values, b_values_f3, '-x');
 xlabel('No of k iterations'), ylabel('Interval Endpoints');
 title('Endpoints (a,k) and (b,k) based on number of iterations k for l=0.1 for f3');
 legend('a_k', 'b_k');
 grid on;

