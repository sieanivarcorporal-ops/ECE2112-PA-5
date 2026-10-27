# ECE-2112-PA-5

**Made by:** Siean Ivar B. Corporal | 2ECE-A

The content of this repository contains the Programming Assignment 5 for our course "Advanced Computer Programming and Algorithms" this S.Y. 2026-2027. This project covers two MATLAB problems pertaining to Experiment 5 - Introduction to MATLAB Programming.

## Objectives of the Experiment

At the end of this laboratory activity, the student should be able to:

1. create real and complex matrices in MATLAB;
2. distinguish transpose from complex-conjugate transpose operations;
3. express a simultaneous linear system in matrix form; and
4. solve and check a linear system using the inverse method and Cramer's Rule.

---

## 1. Transpose Operations

Define a real matrix `R` and a complex matrix `Z`, then compute and display `transpose(A)`, `A'`, and `A.'` for each of them. Afterwards, determine which operations give identical results and what extra operation the apostrophe operator performs on complex entries.

The following functions, operators, and syntax were used in this problem:

* `[ ; ]` - square brackets create a matrix. Spaces (or commas) separate the elements of a row, and semicolons start a new row. MATLAB does not need variables to be declared beforehand.
  Example: `[5 -2 0 7; 1 3 -4 2]` --> a 2x4 matrix

* `i` - a predefined variable for the imaginary unit sqrt(-1). It is written as a suffix to make complex numbers.
  Example: `2+3i` --> a complex number with real part 2 and imaginary part 3

* `transpose(A)` - a built-in function that swaps the rows and columns of `A`. The element at row *m*, column *n* moves to row *n*, column *m*.
  Example: a 3x4 matrix becomes a 4x3 matrix

* `A.'` - the **non-conjugate transpose** operator (a dot and an apostrophe after the variable). It behaves exactly like `transpose(A)`.

* `A'` - the **complex-conjugate transpose** operator (an apostrophe after the variable). It transposes the matrix **and** takes the complex conjugate of every entry, which flips the sign of each imaginary part.
  Example: `2+3i` --> `2-3i`

* `disp()` - displays the value of a variable or text without printing the variable name.

* `;` - a semicolon at the end of a line suppresses the automatic printing of results.

* `%` and `%%` - `%` starts a comment, while `%%` creates a labeled section in the script.

The matrices and displays were written as follows;

```matlab
R = [5 -2 0 7; 1 3 -4 2; 6 0 8 -1];
Z = [2+3i -1+4i 5-2i; -3+i 6 2+5i];

disp('transpose(R):'); disp(transpose(R));
disp('R'':');          disp(R');
disp('R.'':');         disp(R.');

disp('transpose(Z):'); disp(transpose(Z));
disp('Z'':');          disp(Z');
disp('Z.'':');         disp(Z.');
```

**What happened in this problem:**

* **a.** For the real matrix `R`, `transpose(R)`, `R'`, and `R.'` all gave identical results. Conjugating a real number changes nothing, so the three operations agree.
* **b.** For the complex matrix `Z`, `transpose(Z)` and `Z.'` gave identical results, while `Z'` was the one that differed.
* **c.** The apostrophe operator `'` does not only transpose the matrix, it also takes the complex conjugate of each entry (flips the sign of the imaginary part). The entry `6` appeared unchanged because its imaginary part is 0, and flipping the sign of 0 changes nothing.

---

## 2. Two Methods for a Linear System

Solve the simultaneous system

```
 2x1 -  x2 + 3x3 + 2x4 = 16
  x1 + 4x2 - 2x3 +  x4 = -7
 3x1 + 2x2 +  x3 -  x4 = 6
-2x1 + 3x2 + 4x3 + 2x4 = 7
```

by expressing it in the matrix form **A·x = b**, then solving it using (1) the inverse method and (2) Cramer's Rule, without using MATLAB's left-division operator (`\`). The results are then verified using numerical checks.

The following functions, operators, and syntax were used in this problem:

* `A = [ ... ]` and `b = [ ; ; ; ]` - `A` is the 4x4 coefficient matrix, while `b` is the right-hand side stored as a **column vector** (elements separated by semicolons).

* `inv(A)` - a built-in function that returns the inverse of a square matrix `A`.
  Since A·x = b, the solution is x = A⁻¹·b, which in MATLAB is `inv(A)*b`.

* `det(A)` - a built-in function that returns the determinant of `A`. It must be nonzero for the system to have a unique solution.

* `zeros(m,n)` - creates an m x n matrix of zeros. It was used to prepare an empty 4x1 column for the Cramer's Rule results.

* `for k = 1:4 ... end` - a loop that repeats its body once for each value of `k`, one pass per unknown.

* `Ak(:,k) = b` - array indexing where `:` means "all rows" and `k` is the column. This replaces the entire k-th column of the copy `Ak` with `b`.

* `norm()` - returns the norm (length) of a vector. It was used to measure how far apart two answers are, and how far `A*x` is from `b`.

**Inverse method**

```matlab
A = [2 -1 3 2; 1 4 -2 1; 3 2 1 -1; -2 3 4 2];
b = [16; -7; 6; 7];

x_inv = inv(A)*b;
```

**Cramer's Rule**

Each unknown is a ratio of determinants, **x_k = det(A_k) / det(A)**, where `A_k` is the matrix `A` with its k-th column replaced by `b`.

```matlab
detA = det(A);
x_cramer = zeros(4,1);
for k = 1:4
    Ak = A;          % copy A so the original stays unchanged
    Ak(:,k) = b;     % replace column k with b
    x_cramer(k) = det(Ak)/detA;
end
```

**Required displays and checks**

```matlab
disp('x_inv:');                  disp(x_inv);
disp('x_cramer:');               disp(x_cramer);
disp('det(A):');                 disp(det(A));
disp('norm(x_inv - x_cramer):'); disp(norm(x_inv - x_cramer));
disp('norm(A*x_inv - b):');      disp(norm(A*x_inv - b));
```

**What happened in this problem:**

| Quantity | Result |
|---|---|
| `x_inv` | [2; -1; 3; 1] |
| `x_cramer` | [2; -1; 3; 1] |
| `det(A)` | 280 (nonzero, so a unique solution exists) |
| `norm(x_inv - x_cramer)` | about 1.1102e-16 |
| `norm(A*x_inv - b)` | about 2.6645e-15 |

Both methods produced the same solution, x1 = 2, x2 = -1, x3 = 3, and x4 = 1. The two norm checks are approximately zero, and the tiny leftover values come from floating-point round-off in MATLAB. This confirms that both methods are correct and that the solution satisfies the original system.

---

Thank you for reading!

To see the main MATLAB program for Programming Assignment 5, click this link https://github.com/your-username/ECE-2112-PA-5/blob/main/Corporal_PA5.m and download. Open it in MATLAB, then click **Run** to execute the whole script.

## README file Version History

October 27, 2026 - Initial README output uploaded.
