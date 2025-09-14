install.packages("modeldata")
library(modeldata)
data("attrition")
# look at data structure
str(attrition)
# summary statistic
summary(attrition)

# create dataset with only factors
install.packages("dplyr")
library("dplyr")
dataset1 <- attrition %>% select_if(is.factor)
install.packages("installr")
library(installr)
library(partykit)
# Apply CHAID
install.packages("CHAID", repos = "http://R-Forge.R-project.org", type = "source")
library(CHAID)
control = chaid_control(maxheight=4
                        , minbucket = 30 # min bucket size
                        )
model1 <-chaid(Attrition ~ ., 
               data = dataset1,
               control = control)
# plot the CHAID model
plot(model1, main = "First CHAID model", gp = gpar(fontsize = 9, color = "black"))
# more important factors would be on the very top of the outputs
# Chi-square test
chisq.test(dataset1$OverTime, dataset1$Attrition) # p-value is less than 0.05

# checking accuracy
install.packages("caret")
library(caret)
library(dplyr)
library(magrittr)
predictions <- predict(model1)
confusionMatrix(predictions, dataset1$Attrition)
# ranking of the drivers
sort(varimp(model1), decreasing = TRUE)
unique(attrition$StockOptionLevel)

# function to check variables with few unique values
attrition %>% 
  select_if(function(col) length(unique(col)) <= 5 & is.integer(col)) %>% ncol()
attrition %>% 
  select_if(function(col) length(unique(col)) <= 10 & is.integer(col))
# transform into factors
attrition <- attrition %>% mutate_if(function(col) length(unique(col)) <= 10 & is.integer(col)
                        , as.factor)
str(attrition)

# create dataset with only factors
dataset2 <- attrition %>% select_if(is.factor)
# apply chaid
control = chaid_control(maxheight=4
                        , minbucket = 30 # min bucket size
)
model2 <-chaid(Attrition ~ ., 
               data = dataset2,
               control = control)
# plot the CHAID model
plot(model2, main = "Second CHAID model", gp = gpar(fontsize = 9, color = "black"))
# more important factors would be on the very top of the outputs
# Chi-square test
chisq.test(dataset2$OverTime, dataset2$Attrition) # p-value is less than 0.05
# accuracy
predictions2 <- predict(model2)
confusionMatrix(predictions2, dataset2$Attrition)
# ranking of the drivers
sort(varimp(model2), decreasing = TRUE)

# visualize numerical variables
install.packages("ggplot2")
library(ggplot2)
library(tidyr)
attrition %>%
  select_if(is.numeric) %>%
  gather(metric, value) %>%
  ggplot(aes(value, fill = metric)) +
  geom_density(show.legend = FALSE) + 
  facet_wrap(~metric, scales = "free")

# transforming years since last promo variables
attrition$YearsSinceLastPromotion <- cut(attrition$YearsSinceLastPromotion
                                         , breaks = c(-1, 0.9,1.9,2.9,16)
                                         , label = c("less than 1 year",
                                                     "1 year",
                                                     "2 years",
                                                     "more than 2 years"))# four intervals)
# transforming remaining variables into factors
attrition <- attrition %>% mutate_if(is.numeric, funs(cut_number(.,n=5)))
str(attrition)


# model 3
# apply chaid
control = chaid_control(maxheight=4
                        , minbucket = 30 # min bucket size
)
model3 <-chaid(Attrition ~ ., 
               data = attrition,
               control = control)
# plot the CHAID model
plot(model3, main = "Third CHAID model", gp = gpar(fontsize = 9, color = "black"))
# more important factors would be on the very top of the outputs
# Chi-square test
chisq.test(attrition$OverTime, attrition$Attrition) # p-value is less than 0.05
# accuracy
predictions3 <- predict(model3)
confusionMatrix(predictions3, attrition$Attrition)
# ranking of the drivers
sort(varimp(model2), decreasing = TRUE)
