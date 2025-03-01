# Load the Dataset (Olympics) and Libraries
library(readr)
library(sloop)
library(pryr)
library(methods)


starbucks_purchases <- read_csv("~/CODING/Datasets/starbucks_purchases.csv")
starbucks_purchases$purchase_date <-as.Date(starbucks_purchases$purchase_date)

# ------------------------------------------------------------------------------
# How do you tell what OO system (S3 vs. S4) an object is associated with?

# Using Base R, you can use the isS4() function. if the function returns True, 
# the object is an S4 object. If it returns False it is most likely an S3
isS4(starbucks_purchases)
# Through process of elimination, this is an S3 object. 

# You can also use otype from the pryr package:
otype(starbucks_purchases)


# ------------------------------------------------------------------------------
# How do you determine the base type (like integer or list) of an object?
# You can use the function typeof() to determine precise storage type for an object in R

number <- 1
number2 <- 1L
boolean <- FALSE

typeof(number)
typeof(number2)
typeof(boolean)
typeof(starbucks_purchases)


# ------------------------------------------------------------------------------
# What is a generic function?
# a generic function chooses it method based on the object that is passed through 
# it's class. R has many built in generic functions, like str(), head(), and summary()

# to determine what type of function a function is in R, we can use the ftype() function from 
# the sloop package. This function returns if a function is primative, generic (S3/S4), or 
# a regular function. Primitive functions are built in, low level functions written in C, 
# generic functions function differently depending on the class of the input, regular
# functions function always execute the same way

# Primative
ftype(mean)
ftype(sum)

# Generic 
ftype(str)
ftype(show)

#Regular 
ftype(paste)

# You can use the methods() function on a function to see it's available applications
# Primative and Generic functions will return a list of methods that can be used,
# meaning, these functions will change is the input is any of these objects, but will use 
# the default if the input is not one of these objects, however, the default might not always
# return an expected value, and usually comes with a warning

# Primative
methods(mean)
# Generic 
methods(str)

# however, if you use methods() on a regular function, it will return (no methods found)
# becuase it functions the same regardless of input

# Regular 
methods(paste)

# For my starbucks_purchases dataset, I can use generic s3 functions 
str(starbucks_purchases)

# However, when I try to use a primitive function, I am met with a warning message
mean(starbucks_purchases)


# ------------------------------------------------------------------------------
# What are the main differences between S3 and S4?
# ------------------------------------------------------------------------------
# S3 is R’s first and simplest OO system. S3 is the only OO system used in the 
# base and stats packages, and it’s the most commonly used system in CRAN packages.

# An S3 object is a base type with at least a class attribute (other attributes may 
# be used to store other data). For example, take the factor. Its base type is the integer 
# vector, it has a class attribute of “factor”, and a levels attribute that stores 
# the possible levels. S3 Objects have no formal definition of what a Class is.

# So essentially, an S3 object is a list with a class attribute
# ------------------------------------------------------------------------------
# S4 provides a formal approach to functional OOP. The underlying ideas are similar 
# to S3, but implementation is much stricter and makes use of specialised functions 
# for creating classes (setClass()), generics (setGeneric()), and methods (setMethod()). 

# All functions related to S4 live in the methods package. This package is always 
# when you’re running R interactively, but may not be available when running R in 
# batch mode. For this reason, it’s a good idea to call library(methods)whenever you use S4. 
# This also signals to the reader that you’ll be using the S4 object system.

# S4 requires that the fields on an object be limited to those established in its 
# class definition. Fields in an S4 class are also strictly typed, throwing an error 
# if a value of the wrong type is assigned to them.

# 2 main challenges to using S4
# There is no one reference that will answer all your questions about S4.
# R’s built-in documentation sometimes clashes with community best practices.

# Martin Morgan, Hervé Pagès, and John Chambers are excellant resourcrs for S4 usage


# ------------------------------------------------------------------------------
# s3 Example
# I can make my starbucks_purchases dataset a starbucks object using class()
starbucks_purchasesS3 <- starbucks_purchases
class(starbucks_purchasesS3) <- "starbucks"

# Now that my dataset is a starbucks object, I can define a custom print function 
# specifically for starbucks objects 

print.starbucks <- function(x) {
  cat("S3- Starbucks Purchase Dataset\n")
  cat("Total Orders:", lengths(x[1]), "\n")
  cat("Total Revenue: $", sum(x$sales_amount, na.rm = TRUE), "\n")
  cat("Date Range:", format(min(x$purchase_date)), "-", format(max(x$purchase_date)))
}

print(starbucks_purchasesS3)


# ------------------------------------------------------------------------------
# S4 Example
# To convert my dataset to an S4 object, I need to define the structure of the S4 Class

setClass("S4Starbucks",
         slots = list(
           order_id = "character",
           customer_id = "character",
           sales_amount = "numeric",
           purchase_date = "Date"
         ))

# With my S4 class defined, I can convert my dataset into this S4 object using new()
starbucks_obj <- new("S4Starbucks",
                     order_id = starbucks_purchases$order_id,
                     customer_id = starbucks_purchases$customer_id,
                     sales_amount = starbucks_purchases$sales_amount,
                     purchase_date = as.Date(starbucks_purchases$purchase_date))

# Using otype(), I can check the type of my starbucks_obj
otype(starbucks_obj)

# If we try to use show() before defining it as a function, we will get the 
# equvilivent of an S4 print(). However, we can define a custom methods like we did
# with the S3 object:
setMethod("show", "S4Starbucks", function(object) {
  cat("S4 - Starbucks Purchases Dataset\n")
  cat("Total Orders:", length(object@order_id), "\n")
  cat("Total Revenue: $", sum(object@sales_amount, na.rm = TRUE), "\n")
  
  # Date Range
  date_min <- format(min(object@purchase_date, na.rm = TRUE), "%Y-%m-%d")
  date_max <- format(max(object@purchase_date, na.rm = TRUE), "%Y-%m-%d")
  cat("Date Range:", date_min, "-", date_max, "\n")
})

# Calling the method's class will confirm we had assignemed a show() method to 
 # our S4Starbucks object
methods(class = "S4Starbucks")

# If we use show() on starbucks_obj, it will now call the show() method we defined
show(starbucks_obj)












