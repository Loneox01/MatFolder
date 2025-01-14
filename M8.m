% ECE 202: M8
% Daniel Zhang, 11/19,24
% Partial Fractions


% ---------- Givens ----------
n = input('Input the number of points in array x: ');

x = linspace(-4, 4, n);

global D1 D2 D3 constants R

R = (2*x.^2+3*x+4) ./ ((x-1).*(x-2).*(x-3));

D1 = x-1;
D2 = x-2;
D3 = x-3;

coef = [2; 3; 4]; % coefficients of numerator ax^2 + bx + c

sys = [1  1  1; % System of equations, where col 1 is c1, col2 is c2, etc
      -5 -4 -3; % multiplying by [c1, c2, c3]T will give coef matrix
       6  3  2];

constants = sys\coef; % Matrix operation, result is [c1, c2, c3]

check_error = false; % error boolean, set to True if a check is found invalid

for i = 1:n % iterates through every point in x
    check_constants = checkRx(i); % confirms if R(x) = R1 + R2 + R3, should be zero
    if(isnan(check_constants) || check_constants > 1e10)
        check_error = true;
    end
end

if(check_error == true)
    fprintf('There was an error for n = %d\n', n);
else
    fprintf('No errors for n = %d\n', n)
end


function check_Difference = checkRx(index)
    global R;
    check_Difference = R(index) - getR1(index) - getR2(index) - getR3(index);
end

function R1 = getR1(index)
    global D1 constants;
    R1 = constants(1)/D1(index);
end

function R2 = getR2(index)
    global D2 constants;
    R2 = constants(2)/D2(index);
end

function R3 = getR3(index)
    global D3 constants;
    R3 = constants(3)/D3(index);
end


