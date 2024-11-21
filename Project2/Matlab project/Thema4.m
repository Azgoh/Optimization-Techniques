clc, clearvars, clear

f = @(x,y)x.^5 .* exp(-x.^2 - y.^2);

gamma = 0.1; %Σταθερό γ για το α υποερώτημα. Μικρό γ για να φαίνεται φανερά η διαφορά με τις άλλες μεθόδους
epsilon = 0.01;

%Για τον κανόνα του Armijo έχουν επιλεχτεί 
% a = 1e-4, b = 0.2, s=100

%O hessian ΔΕΝ είναι θετικά ορισμένος. Προσθέτω 1.5I στον hessian.

%Σημείο i --> (0,0) Ο αλγόριθμος δεν αρχίζει καν αφού το grad στο 0 είναι
%0<ε. Για αυτό δεν υπάρχει κάποιο γράφημα.
[min_f_A, min_x_A, min_y_A, f_values_A] = LevenbergMarquardt(f, 0, 0, epsilon, gamma);
[min_f_B, min_x_B, min_y_B, f_values_B] = LevenbergMarquardt(f, 0, 0, epsilon);
[min_f_C, min_x_C, min_y_C, f_values_C] = LevenbergMarquardt(f, 0, 0, epsilon, 'armijo', true);

%Σημείο ii --> (-1,1). Και οι 3 καταλήγουν στο ολικό ελάχιστο -0.81. Με το
%σταθερό γ χρειάζεται 91 επαναλήψεις. Με την ελαχιστοποίηση 5. Με τον
%armijo 10.
[min_f_A, min_x_A, min_y_A, f_values_A] = LevenbergMarquardt(f, -1, 1, epsilon, gamma);
[min_f_B, min_x_B, min_y_B, f_values_B] = LevenbergMarquardt(f, -1, 1, epsilon);
[min_f_C, min_x_C, min_y_C, f_values_C] = LevenbergMarquardt(f, -1, 1, epsilon, 'armijo', true);
figure(1);
plot(1:length(f_values_A), f_values_A, "red");
grid on;
hold on;
plot(1:length(f_values_B), f_values_B, "blue");
plot(1:length(f_values_C), f_values_C, "green");
legend('gamma = 0.1', 'gamma that minimizes $$f(x_k + \gamma_k d_k)$$', 'Armijo', 'interpreter', 'latex');
title('f(x,y) values with respect to the number of repetitions. Starting point is (-1,1)'); 
xlabel('Repetitions');
ylabel('f(x,y) values');


%Σημείο iii --> (1,-1). O armijo καταλήγει στο 0 σε 2 επαναλήψεις. Με
%σταθερό γ καταλήγει στο 0 σε 207 επαναλήωεις. Με την ελαχιστοποίηση
%καταλήγουμε στο ολικό ελάχιστο -0.81 σε 6 επαναλήψεις. 
[min_f_A, min_x_A, min_y_A, f_values_A] = LevenbergMarquardt(f, 1, -1, epsilon, gamma);
[min_f_B, min_x_B, min_y_B, f_values_B] = LevenbergMarquardt(f, 1, -1, epsilon);
[min_f_C, min_x_C, min_y_C, f_values_C] = LevenbergMarquardt(f, 1, -1, epsilon, 'armijo', true);
figure(2);
plot(1:length(f_values_A), f_values_A, "red");
grid on;
hold on;
plot(1:length(f_values_B), f_values_B, "blue");
plot(1:length(f_values_C), f_values_C, "green");
legend('gamma = 0.1', 'gamma that minimizes $$f(x_k + \gamma_k d_k91)$$', 'Armijo', 'interpreter', 'latex');
title('f(x,y) values with respect to the number of repetitions. Starting point is (1,-1)'); 
xlabel('Repetitions');
ylabel('f(x,y) values');