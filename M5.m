% M5
% Daniel Zhang
% 9/20/25

% Turning a product of sinusoids into a sum

clc
clear
clf

% cos(a) * cos(b) = 1/2 * (cos(a+b) + cos(a-b))
% formula from: http://hyperphysics.phy-astr.gsu.edu/hbase/colsta.html#c5

t = linspace(-100, 100, 10001); %time array, milliseconds
ts = t/1000; %time array for calculations, seconds

coef = 15; % coefficient, no units
a = 80*ts + 1.2;
b = 120*ts - 1.8;

f = coef*cos(a).*cos(b); % f(t), t is in seconds

w1 = coef/2*cos(a+b); % wave 1, t in seconds
w2 = coef/2*cos(a-b); % wave 2, t in seconds


Check = f - (w1+w2); %Check array, should be all zeros 
Check_sum = sum(abs(Check)) %Check sum of Check array, should equal 0.

% Abs is necessary here so that the array doesn't coincidentally sum to 0
% If Check_sum was an array of ex. [-1, 1, -1, 1 ...], the value would
% still be zero, but the array is not ideal, so the check would be invalid.


plot(t, f, t, w1, t, w2, t, Check, 'LineWidth', 1)
legend('f = base function', 'f1 = first part of product formula', ...
    'f2 = second part of product formula', 'Check = f-(f1+f2), should equal 0.',...
    'FontSize', 14)
title("Product Formula: Showing that", "cos(a)cos(b) can be written as" + ...
    "1/2(cos(a+b) + cos(a-b))", "FontSize", 16)
xlabel('Time (t), ms', 'FontSize', 16)
ylim([-15, 22]) %yLimit to improve visibility of the legend

axis = gca;
axis.FontSize = 12; 

grid on
