% M4
% Daniel Zhang
% 9/20/24

clear
clc
clf

% Question d)

t = linspace(0, 40, 4001); % time array, milliseconds
ts = t/100;

v1 = 16*exp(-800*ts) - 4*exp(-200*ts); % Volts
v2 = 12*exp(-500*ts) - 6000.*t.*exp(-500*ts); % Volts
v3 = exp(-120*ts).*(12*cos(450*ts) - 5.*sin(450*ts)); % Volts

plot(t, v1, t, v2, t, v3, 'LineWidth', 1)
title("ECE 204, M4 part (d) : 3 Dampings, Parallel RC")
xlabel('Time (t), ms')
ylabel('Voltage (V), volts')
ylim([-15,15])

grid on

legend('Overdamped', 'Critically damped', 'Underdamped')