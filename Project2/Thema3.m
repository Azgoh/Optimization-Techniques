clc, clearvars, clear

f = @(x,y)x.^5 .* exp(-x.^2 - y.^2);

gamma = 0.1; %Σταθερό γ για το α υποερώτημα. Μικρό γ για να φαίνεται φανερά η διαφορά με τις άλλες μεθόδους
epsilon = 0.01;

%Για τον κανόνα του Armijo έχουν επιλεχτεί 
% a = 1e-4, b = 0.2, s=100

%O hessian ΔΕΝ είναι θετικά ορισμένος.

%Σημείο i --> (0,0) Ο αλγόριθμος δεν αρχίζει καν αφού το grad στο 0 είναι
%0<ε. Για αυτό δεν υπάρχει κάποιο γράφημα.
[min_f_A, min_x_A, min_y_A, f_values_A] = Newton(f, 0, 0, epsilon, gamma);
[min_f_B, min_x_B, min_y_B, f_values_B] = Newton(f, 0, 0, epsilon);
[min_f_C, min_x_C, min_y_C, f_values_C] = Newton(f, 0, 0, epsilon, 'armijo', true);

%Σημείο ii --> (-1,1). Καταλήγουμε στο 0 το οποίο είναι σημείο σάγματος και
%πληρεί την συνθήκη τερματισμού. Με το σταθερό γ έχουμε τις λιγότερες
%επαναλήψεις(40reps). Με την μέθοδο της ελαχιστοποίησης έχουμε 11752
%επαναλήψεις. Κάτι τέτοιο συμβαίνει διότι ο hessian είναι αρνητικά
%ορισμένος και έτσι η διαδικασία βέλτιστης εύρεσης γ γίνεται πολύ
%συντηρητική με γ = 3.3083e-04. Η μέθοδος με τον κανόνα Armijo δεν συγκλίνει,
%δεν μπορεί να βρει τιμή του γ που να μειώνει την τιμή της f. Για αυτό το 
%σχετικό κομμάτι υπάρχει μόνο σε σχόλιο.
[min_f_A, min_x_A, min_y_A, f_values_A] = Newton(f, -1, 1, epsilon, gamma);
[min_f_B, min_x_B, min_y_B, f_values_B] = Newton(f, -1, 1, epsilon);
% [min_f_C, min_x_C, min_y_C, f_values_C] = Newton(f, -1, 1, epsilon, 'armijo', true);
figure(1);
plot(1:length(f_values_A), f_values_A, "red");
grid on;
hold on;
plot(1:length(f_values_B), f_values_B, "blue");
% plot(1:length(f_values_C), f_values_C, "green");
legend('gamma = 0.1', 'gamma that minimizes $$f(x_k - \gamma_k \nabla f(x_k)$$', 'Armijo', 'interpreter', 'latex');
title('f(x,y) values with respect to the number of repetitions. Starting point is (-1,1)'); 
xlabel('Repetitions');
ylabel('f(x,y) values');


%Σημείο iii --> (1,-1). Για armijo(2reps), ελαχιστοποίηση(2reps), σταθερό 
%γ(40reps) καταλήγει στο 0, το οποίο είναι σημείο σάγματος. Δεν βρίσκει το 
%ολικό ελάχιστο(ούτε το μέγιστο όπως περιμένουμε να κάνει ο newton με 
%αρνητικά ορισμένο hessian) γιατί το grad της f κοντά στο 0, προσεγγίζει το
%0, οπότε πληρείται η συνθήκη τερματισμού του αλγορίθμου. Επίσης, παρά τον 
%αρνητικό hessian, επειδή αυτός έχει πολύ μικρές αρνητικές
%ιδιοτιμές(κατ'απόλυτο), καθώς και επειδή το αρχικό σημείο βρίσκεται σε
%κοντινή περιοχή με το τοπικό ελάχιστο η τιμή της συνάρτησης μειώνεται.
[min_f_A, min_x_A, min_y_A, f_values_A] = Newton(f, 1, -1, epsilon, gamma);
[min_f_B, min_x_B, min_y_B, f_values_B] = Newton(f, 1, -1, epsilon);
[min_f_C, min_x_C, min_y_C, f_values_C] = Newton(f, 1, -1, epsilon, 'armijo', true);
figure(2);
plot(1:length(f_values_A), f_values_A, "red");
grid on;
hold on;
plot(1:length(f_values_B), f_values_B, "blue");
plot(1:length(f_values_C), f_values_C, "green");
legend('gamma = 0.1', 'gamma that minimizes $$f(x_k - \gamma_k \nabla f(x_k)$$', 'Armijo', 'interpreter', 'latex');
title('f(x,y) values with respect to the number of repetitions. Starting point is (1,-1)'); 
xlabel('Repetitions');
ylabel('f(x,y) values');