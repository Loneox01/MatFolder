% M6 assignment ECE 202
% Daniel Zhang
% Nov 6, 2024
% Calculation of momentum in an elastic collision between two carts
% With user input

clc, clear

% -------- Givens ----------

global m; 

m1 = input('Enter mass m1 in grams: ');
if(m1 <= 0)
    m1 = input('Please enter a non-zero positive number: ');
end
m2 = input('Enter mass m2 in grams: ');
m3 = input('Enter mass m3 in grams: ');

m = [m1, m2, m3];

% grams, carts 1, 2, and 3 respectively

v1 = input('Enter velocity v1 in cm/s: ');
v2 = input('Enter velocity v2 in cm/s: ');
v3 = input('Enter velocity v3 in cm/s: ');

threshold = 0.01 * input('Enter the error threshold as a % of total KE or p: ');

V0 = [v1, v2, v3];
% cm/s, initial V of carts 1, 2, and 3 respectively

index1 = input('Please enter the car in the first collision (1 or 3): ');
while ~(index1 == 1 || index1 == 3)
    index1 = input('Try again, car index needs to be between 1 and 3');
end

% -------- Calculations ----------
total_p = sum(m .* V0); % g*cm/s
total_KE = 0.5*sum(m .* V0.^2); % g*cm^2/s^2

if ~(V0(1) > V0(2) || V0(3) < V0(2))
    disp("There are no more collisions")
else
    VA = [V0(1), V0(2), V0(3)]; % velocity array, cm/s
    
    [VA(index1), VA(2)] = findVelocities(index1, V0); % outputs

    % -------- Checks ----------

    Check_momentum_conservation = total_p - sum(m .* VA);
    % grams*cm/s, should equal zero
    
    Check_energy_cons = total_KE - 0.5*sum(m .* VA.^2);
    % g*cm^2/s^2, should equal zero
    
    if(abs(Check_momentum_conservation) > abs(total_p * threshold))
        disp('Check ERROR, momentum threshold breached')
        fprintf('Momentum check is: %d \n', Check_momentum_conservation)
    end
    
    if(abs(Check_energy_cons) > abs(total_KE * threshold))
        disp('Check ERROR, energy threshold breached')
        fprintf('Energy check is: %d \n', Check_energy_cons) 

        
    end


    if ~(VA(1) > VA(2) || VA(3) < VA(2))
        disp("There are no more collisions")
    
    else
    
        collision_count = 1; % no units
        
    
        while (VA(1) > VA(2) || VA(3) < VA(2))
            
            disp("There are more collisions")
            collision_count = collision_count + 1;
            fprintf('After collision #%d: \n', collision_count)
    
            if(VA(1) > VA(2))
                
                [VA(1), VA(2)] = findVelocities(1, VA); % outputs
    
                
                % -------- Checks ----------
                
                Check_momentum_conservation = total_p - sum(m .* VA);
                % grams*cm/s, should equal zero
                
                Check_energy_cons = total_KE - 0.5*sum(m .* VA.^2);
                % g*cm^2/s^2, should equal zero
    
            else
                
                [VA(3), VA(2)] = findVelocities(3, VA); % outputs
                
                % -------- Checks ----------
                
                Check_momentum_conservation = total_p - sum(m .* VA);
                % grams*cm/s, should equal zero
                
                Check_energy_cons = total_KE - 0.5*sum(m .* VA.^2);
                % g*cm^2/s^2, should equal zero
    
            end
    
            if(abs(Check_momentum_conservation) > abs(total_p * threshold))
                disp('Check ERROR, momentum threshold breached')
                fprintf('Momentum check is: %d \n', Check_momentum_conservation)
            end
        
            if(abs(Check_energy_cons) > abs(total_KE * threshold))
                disp('Check ERROR, energy threshold breached')
                fprintf('Energy check is: %d \n', Check_energy_cons)   
            end
    
        end
        
        disp("There are no more collisions")
    
        disp('The final Velocities are: ')
        disp(VA)

    end

end
    

% -------- Functions ----------

function [VA, V2] = findVelocities(index, V0)
    global m

    m_sum = m(index) + m(2); % g
    VA = ((m(index)-m(2))*V0(index) + 2*m(2)*V0(2))/m_sum; %cm/s
    V2 = (2*m(index)*V0(index) + (m(2)-m(index))*V0(2))/m_sum; %cm/s
    % Equations from : 
    % https://www.real-world-physics-problems.com/elastic-collision.html

end