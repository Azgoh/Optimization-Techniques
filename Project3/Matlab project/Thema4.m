clc, clearvars, clear

f = @(x1,x2) (1/3) .* (x1.^2) + 3.*(x2.^2);

%Το σημείο εκκίνησης (8,-10) δεν είναι εφικτό καθώς το χ2=-10 πέφτει εκτός 
%των δοσμένων ορίων. Όμως στην μέθοδο προβολής κάνουμε αυτόν τον έλεγχο και
%έτσι ξεκινάμε από ένα εφικτό σημείο παίρνοντας την προβολή.
%Καταλήγουμε στο ολικό ελάχιστο της συνάρτησης σε 434 επαναλήψεις.

[min_f, min_x1, min_x2, f_values] = SteepestDescentWithPRx(f, 8, -10, 0.01, 0.2, 0.1);
figure(1);
plot(1:length(f_values), f_values, "red");
hold on;
grid on;
xlabel('Repetitions');
ylabel('f(x1,x2) values');
title('f(x1,x2) values with respect to the number of repetitions. Starting point is (8,-10)');
legend('gamma=0.2 and sk=0.1');
