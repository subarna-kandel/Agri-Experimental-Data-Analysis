library(readxl)
library(agricolae)
y2 <- read_excel("data/year_2.xlsx")
str(y2)
print(is.data.frame(y2))
attach(y2)
Treatment <- as.factor(Treatment)
Rep <- as.factor(Replication)
Block <- as.factor(Block)

#test for anthesis


for (i in 4:17) {
  column_name <- colnames(y2)[i]
  response_variable <- y2[[i]]
  
  result <- PBIB.test(Block, Treatment, Rep, response_variable, 2, 
                      method="ML", test="lsd", alpha=0.05, console=TRUE, group=TRUE)
  
  print(result)
  
  # Clean file name
  safe_name <- gsub("[/\\(\\) ]", "_", column_name)
  
  # Write result to a text file
  sink(paste0(safe_name, ".txt"))
  print(result)
  sink()
}

for (i in 4:16) {
  column_name <- colnames(y2)[i]
  response_variable <- y2[[i]]
  
  if (length(Block) == length(Treatment) && length(Treatment) == length(Rep) && length(Rep) == length(response_variable)) {
    
    result <- PBIB.test(Block, Treatment, Rep, response_variable, 2, 
                        method="ML", test="lsd", alpha=0.05, console=TRUE, group=TRUE)
    
    print(result)
    
    # Clean file name
    safe_name <- gsub("[/\\(\\) ]", "_", column_name)
    
    # Write result to a text file
    sink(paste0(safe_name, ".txt"))
    print(result)
    sink()
    
  } else {
    cat("Length mismatch in", column_name, "\n")
  }
}



#test for heritability
#Install the packages
library(variability)

#test for heritability
her_y2 <- gen.var(y2[4:17], Treatment, Replication)

#write out file of heritability

sink("her_y2.txt")
print(her_y2)
sink()


library(agricolae)

# Initialize empty dataframe to store LSD values
lsd_results <- data.frame(Variable = character(),
                          LSD_Value = numeric(),
                          stringsAsFactors = FALSE)

for (i in 4:16) {
  column_name <- colnames(y2)[i]
  response_variable <- y2[[i]]
  
  result <- PBIB.test(Block, Treatment, Rep, response_variable, 2, 
                      method = "ML", test = "lsd", alpha = 0.05, console = TRUE, group = TRUE)
  
  # Extract error degrees of freedom and Mean Square Error
  df_error <- result$ANOVA$Df[2]
  MSE <- result$ANOVA$`Mean Sq`[2]
  
  # Extract number of replications
  r <- result$parameters$r
  
  # t-critical value for 95% CI
  t_critical <- qt(1 - 0.05 / 2, df_error)
  
  # Standard Error of the Difference
  SE_diff <- sqrt(2 * MSE / r)
  
  # LSD calculation
  LSD_value <- t_critical * SE_diff
  
  # Append to dataframe
  lsd_results <- rbind(lsd_results, data.frame(Variable = column_name,
                                               LSD_Value = LSD_value))
}

# Save the LSD values to a CSV file
write.csv(lsd_results, "LSD_values.csv", row.names = FALSE)

# View result
print(lsd_results)

library(agricolae)

# Create an empty dataframe to store LSD values
lsd_results <- data.frame(
  Column = character(),
  LSD = numeric(),
  stringsAsFactors = FALSE
)

for (i in 4:16) {
  column_name <- colnames(y2)[i]
  response_variable <- y2[[i]]
  
  # Run PBIB.test
  result <- PBIB.test(Block, Treatment, Rep, response_variable, 2, 
                      method = "ML", test = "lsd", alpha = 0.05, console = TRUE, group = TRUE)
  
  # Extract error df and MSE
  df_error <- result$ANOVA$Df[2]
  MSE <- result$ANOVA$`Mean Sq`[2]
  
  # Get number of replications
  r <- result$parameters$r
  
  # Calculate LSD
  t_critical <- qt(1 - 0.05/2, df_error)
  SE_diff <- sqrt(2 * MSE / r)
  LSD <- t_critical * SE_diff
  
  # Print result
  cat("Column:", column_name, "- LSD:", LSD, "\n")
  
  # Save to results table
  lsd_results <- rbind(lsd_results, data.frame(Column = column_name, LSD = LSD))
}

# Save to CSV
write.csv(lsd_results, "LSD_values_results.csv", row.names = FALSE)

print(lsd_results)
