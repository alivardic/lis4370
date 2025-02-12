# Create matrices (Denoted by uppercase A,B)
A <- matrix(1:100, nrow=10)  
B <- matrix(1:1000, nrow=10)

# Transpose (Flip columns and rows)
tA <- t(A)
tB <- t(B)

# Create vectors (Denoted by lowercase a,b)
a <- 1:10
b <- 1:100

# Matrix-Vector Multiplication
A_a_result <- A %*% a
B_b_result <- B %*% b

print(A_a_result)
print(B_b_result)

# Matrix-Matrix Multiplication
A_tA_result <- A %*% tA
B_tB_result <- B %*% tB

print(A_tA_result)
print(B_tB_result)

# Calculate Determinants
det_A <- det(A)
det_B <- tryCatch({ det(B) }, error = function(e) paste("Error:", e$message)) # Should Give an Error becuase B is not a Square Matrix

# Calculate the Inverse of A if possible
if (det_A != 0) {
  inv_A <- solve(A)
} else {
  inv_A <- "Matrix A has no inverse."
}

# Print Results
cat("Determinant of A:", det_A)
cat("Inverse of A (if possible):", inv_A)

cat("Attempting determinant of B:", det_B)



