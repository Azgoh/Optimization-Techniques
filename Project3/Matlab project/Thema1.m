clc, clearvars, clear

f = @(x1,x2) (1/3) .* (x1.^2) + 3.*(x2.^2);
[X1, X2] = meshgrid(-3:0.1:3);


%% Plotting f

%Από τα παρακάτω plots και την μορφή της συνάρτησης παρατηρούμε πως έχει
%ολικό ελάχιστο f(0,0)=0
figure(1);
surf(X1,X2,f(X1,X2)); %3D plot
xlabel('x1');
ylabel('x2');
zlabel('f(x1,x2)');
title('f(x1,x2) = 1/3*x1^2 + 3*x2^2 plot');

figure(2);
contourf(X1,X2,f(X1,X2)); %Contour Plot
xlabel('x1');
ylabel('x2');
title('f(x1,x2) = 1/3*x1^2 + 3*x2^2 plot');


%% Thema 1

e = 0.001;

[min_f_01, min_x1_01, min_x2_01, f_values_01] = SteepestDescent(f, -3, 3, e, 0.1); %γκ=0.1
[min_f_03, min_x1_03, min_x2_03, f_values_03] = SteepestDescent(f, -3, 3, e, 0.3); %γκ=0.3
[min_f_3, min_x1_3, min_x2_3, f_values_3] = SteepestDescent(f, -3, 3, e, 3); %γκ=3
[min_f_5, min_x1_5, min_x2_5, f_values_5] = SteepestDescent(f, -3, 3, e, 5); %γκ=5

%Για γκ=0.1 και γκ=0.3 βρίσκει το ολικό ελάχιστο της συνάρτησης f(0,0)=0. 
%Το βήμα γκ=0.1 συγκλίνει σε 112 επαναλήψεις ενώ το γκ=0.3 είναι πιο 
%γρήγορο και συγκλίνει σε 45 επαναλήψεις.
figure(3);
plot(1:length(f_values_01), f_values_01, "red");
hold on;
grid on;
plot(1:length(f_values_03), f_values_03, "blue");
legend('gamma=0.1', 'gamma=0.3');
xlabel('Repetitions');
ylabel('f(x1,x2) values');
title('f(x1,x2) values with respect to the number of repetitions. Starting point is (-3,3)');

%Ο αλγόριθμος δεν συγκλίνει, διότι τα γκ που διαλέγουμε είναι πολύ μεγάλα.
%Για τον υπολογισμό των ορίων του γ πρέπει να υπολογίσουμε την κλίση της f.
%gradf(x1,x2) = [2/3x1, 6x2]
%[x1_k+1, x2_k+1] = [x1_k, x2_k] - γκ*[2/3x1_k, 6x2_k]
%Άρα x1_k+1 = x1_k(1-2/3γκ) και x2_k+1 = x2_k(1-6γκ)
%Πρέπει -1<x1_k+1/x1_k<1 => 0<γκ<3
%και -1<x2_k+1/x2_k<1 => 0<γκ<1/3
%Άρα για να συγκλίνει ο αλγόριθμος πρέπει να ισχύει 0<γκ<1/3. Όταν γκ>1/3
%τότε τα x1_k+1 και x2_k+1 αυξάνονται εκθετικά σε μέγεθος και έτσι ο
%αλγόριθμος οδηγείται στο άπειρο αντί για το ολικό ελάχιστο.
figure(4);
plot(1:length(f_values_3), f_values_3, "green");
hold on;
grid on;
plot(1:length(f_values_5), f_values_5, "black");
legend('gamma=3', 'gamma=5');
xlabel('Repetitions');
ylabel('f(x1,x2) values');
title('f(x1,x2) values with respect to the number of repetitions. Starting point is (-3,3)');