library(dplyr)

# read in the data
train <- read.csv(file = './data/train.csv', stringsAsFactors = T)

# Exploratory data analysis
head(train, 3)

# distribution of ages in the data
hist(train$age)

# division of female and male data points
barplot(table(train$gender))

str(train)

# Linear Model, with text column taken out
age.lm <- lm(age ~ gender+sign, data = train)

# read in test data
test <- read.csv(file='./data/test.csv', stringsAsFactors = T)

# predict on the test data
age_preds <- predict(age.lm, newdata = test)

pred_df <- data.frame(user.id=test$user.id, age=age_preds)

pred_df <- pred_df %>% group_by(user.id) %>% summarise(age=mean(age))

# write predictions to csv
write.csv(pred_df, file = 'pred.csv', row.names = F)
