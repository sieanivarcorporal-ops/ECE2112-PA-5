%SIEAN IVAR B.CORPORAL
%2ECE-A
%TRANSPOSE OPERATIONS
R = [5 -2 0 7; 1 3 -4 2; 6 0 8 -1];
Z = [2+3i -1+4i 5-2i; -3+i 6 2+5i];

disp('R: '); disp(R);
disp('transpose(R): '); disp(transpose(R));
disp('R'': '); disp(R');
disp('R.'': '); disp(R.');

disp('Z: '); disp(Z);
disp('transpose(Z): '); disp(transpose(Z));
disp('Z'': '); disp(Z');
disp('Z.'': '); disp(Z.');

%a. The operations transpose(R), R',and R.' all have the same outputs and are all different from the original matrix R
%b. The operations transpose(Z), and Z.' yielded identical outputs and is different from the original matrix Z
%c. The operation Z' does not only transpose the matrix, but also reverses the sign of numbers that is multiplied by an imaginary number


%TWO METHODS FOR A LINEAR SYSTEM
%INVERSE METHOD
A = [2 -1 3 2; 1 4 -2 1; 3 2 1 -1; -2 3 4 2];
b = [16; -7; 6; 7];

x_inv = inv(A)*b;

%CRAMER'S RULE

detA = det(A);
x_cramer = zeros(4,1);
for k = 1:4
    Ak = A;
    Ak(:,k) = b;
    x_cramer(k) = det(Ak)/detA;
end

disp('x_inv: '); disp(x_inv);
disp('x_cramer: '); disp(x_cramer);
disp('det(A): '); disp(det(A));
disp('norm(x_inv - x_cramer): '); disp(norm(x_inv - x_cramer));
disp('norm(A*x_inv - b): '); disp(norm(A*x_inv - b));
