clc, clearvars, clear

f = @(x,y)x.^5 .* exp(-x.^2 - y.^2);

gamma = 0.1; %Σταθερό γ για το α υποερώτημα
epsilon = 0.01;

%Για τον κανόνα του Armijo έχουν επιλεχτεί 
% a = 1e-4, b = 0.2, s=1


%Σημείο i --> (0,0) Ο αλγόριθμος δεν αρχίζει καν αφού το grad στο 0 είναι
%0<ε. Για αυτό δεν υπάρχει κάποιο γράφημα.
[min_f_A, min_x_A, min_y_A, f_values_A] = SteepestDescent(f, 0, 0, epsilon, gamma);
[min_f_B, min_x_B, min_y_B, f_values_B] = SteepestDescent(f, 0, 0, epsilon);
[min_f_C, min_x_C, min_y_C, f_values_C] = SteepestDescent(f, 0, 0, epsilon, 'armijo', true);


%Σημείο ii --> (-1,1). Βρίσκει επιτυχώς το ολικό ελάχιστο -0.81. 
%Ο Armijo χρειάζεται περισσότερες επαναλήψεις από την μέθοδο με την
%ελαχιστοποίηση. Κάτι τέτοιο είναι αναμενόμενο, αφού ο armijo επιλέγει
%ένα βήμα γ που απλώς διασφαλίζει ότι η συνάρτηση μειώνεται συνεχώς(χωρίς
% αυτό να είναι απαραίτητα το βέλτιστο γ). Τις περισσότερες επαναλήψεις
% χρειάζεται η μέθοδος σταθερού βήματος γ.
[min_f_A, min_x_A, min_y_A, f_values_A] = SteepestDescent(f, -1, 1, epsilon, gamma);
[min_f_B, min_x_B, min_y_B, f_values_B] = SteepestDescent(f, -1, 1, epsilon);
[min_f_C, min_x_C, min_y_C, f_values_C] = SteepestDescent(f, -1, 1, epsilon, 'armijo', true);
figure(1);
plot(1:length(f_values_A), f_values_A, "red");
grid on;
hold on;
plot(1:length(f_values_B), f_values_B, "blue");
hold on;
plot(1:length(f_values_C), f_values_C, "green");
legend('gamma = 0.1', 'gamma that minimizes $$f(x_k - \gamma_k \nabla f(x_k)$$', 'Armijo', 'interpreter', 'latex');
title('f(x,y) values with respect to the number of repetitions. Starting point is (-1,1)'); 
xlabel('Repetitions');
ylabel('f(x,y) values');


%Σημείο iii --> (1,-1). Καταλήγει στο 0, το οποίο είναι τοπικό ελάχιστο στο
%(1,-1). Δεν βρίσκει το ολικό ελάχιστο γιατί το grad της f κοντά στο 0,
%προσεγγίζει το 0, οπότε πληρείται η συνθήκη τερματισμού του αλγορίθμου.
%Ελαχιστοποίση και Armijo ταυτόσημες. Τις περισσότερες επαναλήψεις
%χρειάζεται η μέθοδος σταθερού βήματος γ.
[min_f_A, min_x_A, min_y_A, f_values_A] = SteepestDescent(f, 1, -1, epsilon, gamma);
[min_f_B, min_x_B, min_y_B, f_values_B] = SteepestDescent(f, 1, -1, epsilon);
[min_f_C, min_x_C, min_y_C, f_values_C] = SteepestDescent(f, 1, -1, epsilon, 'armijo', true);
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