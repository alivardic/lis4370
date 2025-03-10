# Step # 1 Import assignment 6 Data-set to R Download Import assignment 6 Data-set to R. Then, Run the commend "mean" using Sex as the category (use plyr package for this operation). Last commend in this step: write the resulting output to a file.
library(plyr)
mod8 <- read.table("Assignment 6 Dataset.txt", header = TRUE, sep = ",")
StudentAverage = ddply(mod8,"Sex",transform,Grade.Average=mean(Grade))

# Text File
write.table(mod8,"Sorted_Average_txt")
# CSV
write.table(mod8,"Sorted_Average_csv",sep=",")

# Sort for Student who have i/I in their name
newx = subset(mod8,grepl("[iI]",mod8$Name))
write.table(newx,"DataSubset",sep=",")
