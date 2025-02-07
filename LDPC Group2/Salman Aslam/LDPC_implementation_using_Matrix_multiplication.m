clc; clear;

% Define the H matrix in GF(2)
H = [1 0 1 1 1 0 0;
     1 1 0 1 1 1 0;
     0 1 1 1 0 1 1];

% Define symbolic variables for unknowns in GF(2)
syms p0 p1 p2

% Define the Informationbits matrix with unknowns
Informationbits = [1; 0; 1; 0; p0; p1; p2];

% Compute H * Informationbits (mod 2)
eqns = mod(H * Informationbits, 2) == 0;

% Solve for unknowns in sequential order
p0_sol = solve(eqns(1), p0);  % Solve for p0 first
p1_sol = solve(subs(eqns(2), p0, p0_sol), p1);  % Solve for p1 using p0
p2_sol = solve(subs(eqns(3), [p0 p1], [p0_sol p1_sol]), p2);  % Solve for p2 using p0, p1

% Convert to binary (0 or 1)
p0_sol = mod(double(p0_sol), 2);
p1_sol = mod(double(p1_sol), 2);
p2_sol = mod(double(p2_sol), 2);

% Correct indexing: MATLAB starts from 1 (NOT 0)
Completed_Informationbits = [Informationbits(1), Informationbits(2), Informationbits(3), ...
                             Informationbits(4), p0_sol, p1_sol, p2_sol];

% Display the results
disp('Solutions for p0, p1, p2 in GF(2):');
disp(['p0 = ', num2str(p0_sol)]);
disp(['p1 = ', num2str(p1_sol)]);
disp(['p2 = ', num2str(p2_sol)]);

disp('Completed Informationbits matrix:');
disp(Completed_Informationbits);
