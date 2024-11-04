function [calls, a_values, b_values] = Fibonacci(f, a, b, l, e)
    %Υπολογισμός της ακολουθίας fibonacci ανάλογα το l
    fib_nums = [1, 1];
    while fib_nums(end) < (b-a)/l
        fib_nums(end + 1) = fib_nums(end) + fib_nums(end - 1);
    end 

    n = length(fib_nums);
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
            a = x1; %a_k+1 = x1_k
            x1 = x2; %x1_k+1 = x2_k
            x2 = a + (fib_nums(n-k-1)/fib_nums(n-k))*(b-a); %x2_k+1
            if k == n-2
                x2 = x1 + e;
                calls = calls + 2;
                if f(x1) > f(x2)
                    a = x1;
                    break;
                else 
                    b = x2;
                    break;
                end
            else 
                fx1_value = fx2_value; %fx1_k+1 = fx2_k
                fx2_value = f(x2); %fx2_k+1 = f(x2_k+1)
                calls = calls + 1;
            end

        else 
            b = x2;
            x2 = x1;

            if k ~= n-2
                x1 = a + (fib_nums(n-k-2)/fib_nums(n-k))*(b-a);
            end

            if k == n-2
                x2 = x1 + e;
                calls = calls + 2;
                if f(x1) > f(x2)
                    a = x1;
                    break;
                else 
                    b = x2;
                    break;
                end
            else
                fx2_value = fx1_value;
                fx1_value = f(x1);
                calls = calls + 1;
            end
        end
    end
    a_values = [a_values, a];
    b_values = [b_values, b];
end

