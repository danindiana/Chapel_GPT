use BlockDist;

// Define dimensions for each matrix
config const n1 = 10;
config const n2 = 10;
config const n3 = 10;

if (n2 != n3) {
  writeln("Error: Matrices are incompatible for multiplication");
  return;
}

// Define 2D domains and distribute them over all locales.
const ProblemSpaceA = {1..n1, 1..n2} dmapped Block(boundingBox={1..n1, 1..n2});
const ProblemSpaceB = {1..n2, 1..n3} dmapped Block(boundingBox={1..n2, 1..n3});
const ProblemSpaceC = {1..n1, 1..n3} dmapped Block(boundingBox={1..n1, 1..n3});

// Define two matrices over the distributed domains and initialize them.
var A: [ProblemSpaceA] real;
var B: [ProblemSpaceB] real;

forall (i,j) in ProblemSpaceA {
  A[i, j] = i * 0.1;
}

forall (i,j) in ProblemSpaceB {
  B[i, j] = j * 0.2;
}

// Define a matrix to hold the result of the multiplication.
var C: [ProblemSpaceC] real;

// Perform the matrix multiplication in parallel.
forall (i,j) in ProblemSpaceC {
  for k in 1..n2 {
    C[i, j] += A[i, k] * B[k, j];
  }
}

// Print the result matrix.
writeln("C = ", C);
