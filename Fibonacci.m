function [calls, a_values, b_values] = Fibonacci(f, a, b, l, e)
    %Υπολογισμός της ακολουθίας fibonacci ανάλογα το l
    fib_nums = [1, 1];
    while fib_nums(end) < (b-a)/l
        fib_nums(end + 1) = fib_nums(end) + fib_nums(end - 1);
    end 

    n = length(fib_nums);)
    calls = 0;
    a_values = [];
    b_values = [];

    x1 = a + (fib_nums(n-2)/fib_nums(n)) * (b - a);
    x2 = a + (fib_nums(n-1)/fib_nums(n)) * (b - a);

    fx1_value = f(x1);
    calls = calls + 1;
    fx2_value = f(x2);
    calls = calls + 1;

    for k = 1:n
        a_values = [a_values, a];
        b_values = [b_values, b];
        if fx1_value > fx2_value
            a = x1;
            x1 = x2;
            x2 = a + (fib_nums(n-k-1)/fib_nums(n-k))*(b-a);
            if k == n-2
                x1 = a + (fib_nums(0)/fib_nums(2))*(b-a);
                x2 = x1 + e;
                if f(x1) > f(x2)
                    calls = calls + 2;
                    a = x1;
                    
            end
        end
    end
end

% function [calls, a_values, b_values] = Fibonacci(f, a, b, l)
%     % FibonacciMethod: Finds the minimum of function f on interval [a, b] using Fibonacci search.
%     % Inputs:
%     %   f - Function to minimize
%     %   a - Lower bound of interval
%     %   b - Upper bound of interval
%     %   l - Desired accuracy (tolerance for stopping criterion)
%     %
%     % Outputs:
%     %   min_x - Approximate minimum location
%     %   calls - Total function calls
%     %   a_values, b_values - Recorded interval endpoints for each iteration
% 
%     % Generate Fibonacci sequence up to threshold based on (b - a) / l
%     fib_nums = [1, 1];
%     while fib_nums(end) < (b-a)/l
%          fib_nums(end + 1) = fib_nums(end) + fib_nums(end - 1);
%     end 
% 
%     calls = 0;
%     a_values = [];
%     b_values = [];
% 
%     n = length(fib_nums) - 1;  % Total number of iterations based on Fibonacci numbers
% 
%     % Initialize points in the interval
%     x1 = a + (fib_nums(n-1)/fib_nums(n)) * (b - a);
%     x2 = a + (fib_nums(n)/fib_nums(n+1)) * (b - a);
% 
%     fx1_value = f(x1);
%     calls = calls + 1;
%     fx2_value = f(x2);
%     calls = calls + 1;
% 
%     for k = 1:(n - 1)
%         a_values = [a_values, a];
%         b_values = [b_values, b];
% 
%         % Adjust interval based on function evaluations
%         if fx1_value > fx2_value
%             a = x1;
%             x1 = x2;
%             % Ensure we stay within bounds of the Fibonacci array
%             if n - k > 1
%                 x2 = a + (fib_nums(n-k)/fib_nums(n-k+1)) * (b - a);
%                 fx1_value = fx2_value;
%                 fx2_value = f(x2);
%                 calls = calls + 1;
%             end
%         else
%             b = x2;
%             x2 = x1;
%             % Ensure we stay within bounds of the Fibonacci array
%             if n - k - 1 > 0
%                 x1 = a + (fib_nums(n-k-1)/fib_nums(n-k+1)) * (b - a);
%                 fx2_value = fx1_value;
%                 fx1_value = f(x1);
%                 calls = calls + 1;
%             end
%         end
%     end
% 
%     % Record final interval endpoints
%     a_values = [a_values, a];
%     b_values = [b_values, b];
%     % Compute the midpoint of the final interval as the approximate minimum
%     min_x = (a + b) / 2;
% end