clc, clearvars, clear

f = @(x,y)x.^5 .* exp(-x.^2 - y.^2);

gamma = 0.1; %Σταθερό γ για το α
epsilon = 0.001;


%Σημείο i --> (0,0) Ο αλγόριθμος δεν αρχίζει καν αφού το grad στο 0 είναι
%0<ε. Για αυτό δεν υπάρχει κάποιο γράφημα.
[num_calls_A, min_f_A, min_x_A, min_y_A, f_values_A] = MegisthKathodosA(f, 0, 0, gamma, epsilon);
[num_calls_B, min_f_B, min_x_B, min_y_B, f_values_B] = MegisthKathodosB(f, 0, 0, epsilon);


%Σημείο ii --> (-1,1). Βρίσκει επιτυχώς το ολικό ελάχιστο -0.81
[num_calls_A, min_f_A, min_x_A, min_y_A, f_values_A] = MegisthKathodosA(f, -1, 1, gamma, epsilon);
[num_calls_B, min_f_B, min_x_B, min_y_B, f_values_B] = MegisthKathodosB(f, -1, 1, epsilon);
figure(1);
plot(1:length(f_values_A), f_values_A, "red");
grid on;
hold on;
plot(1:length(f_values_B), f_values_B, "blue");
legend('gamma = 0.1', 'gamma that minimizes $$f(x_k - \gamma_k \nabla f(x_k)$$', 'interpreter', 'latex');
title('f(x,y) values with respect to the number of repetitions.'); %Έχουμε number of reps + 1 γιατί προσθέτω και την f_value που προκύπτει από το αρχικό ζευγάρι (x_initial,y_initial)
xlabel('Repetitions');
ylabel('f(x,y) values');


%Σημείο iii --> (1,-1). Καταλήγει στο 0, το οποίο είναι τοπικό ελάχιστο στο
%(1,-1). Δεν βρίσκει το ολικό ελάχιστο γιατί το grad της f κοντά στο 0,
%προσεγγίζει το 0, οπότε πληρείται η συνθήκη τερματισμού του αλγορίθμου.
[num_calls_A, min_f_A, min_x_A, min_y_A, f_values_A] = MegisthKathodosA(f, 1, -1, gamma, epsilon);
[num_calls_B, min_f_B, min_x_B, min_y_B, f_values_B] = MegisthKathodosB(f, 1, -1, epsilon);
figure(2);
plot(1:length(f_values_A), f_values_A, "red");
grid on;
hold on;
plot(1:length(f_values_B), f_values_B, "blue");
legend('gamma = 0.1', 'gamma that minimizes $$f(x_k - \gamma_k \nabla f(x_k)$$', 'interpreter', 'latex');
title('f(x,y) values with respect to the number of repetitions.'); %Έχουμε number of reps + 1 γιατί προσθέτω και την f_value που προκύπτει από το αρχικό ζευγάρι (x_initial,y_initial)
xlabel('Repetitions');
ylabel('f(x,y) values');