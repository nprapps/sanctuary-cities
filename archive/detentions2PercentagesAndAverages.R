# DETENTIONS 
# 2016-05-04 
# -----------

library(dplyr)

# load data 
setwd("Desktop")
d = read.csv("requests.csv",header=TRUE,stringsAsFactors = FALSE)
f = read.csv("joinpvtfacility.csv",header=TRUE,stringsAsFactors = FALSE)

# find out the percentage of all list_reason's for all det_facilities.
percentages = f %>% 
  group_by(det_facility,lift_reason) %>%
  mutate(count =n()) %>%
  group_by(det_facility) %>%
  mutate(count_all =n()) %>%
  mutate(freq = 100/count_all*count) %>%
  group_by(det_facility,lift_reason,count,count_all,freq) %>%
  summarise()

# find out the average percentage for all list_reasons
averages = percentages %>%
  group_by(lift_reason) %>%
  summarise(average=mean(freq))

# export as csv
write.csv(percentages, file="detentations_percentages.csv")
write.csv(averages, file="detentations_averages.csv")

