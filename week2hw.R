set.seed(15)
hw2 <- runif(50, 4, 50)
hw2 <- replace(hw2, c(4,12,22,27), NA)
hw2

### Question 1 ----
hw2 <- hw2[-c(4,12,22,27)]
hw2
prob1 <- hw2[c(hw2 > 14 & hw2 < 38)]
prob1

### Question 2 ----
times3 <- prob1 * 3
times3
plus10 <- times3 + 10
plus10

### Question 3 ----
final <- plus10[c(TRUE, FALSE)]
final
