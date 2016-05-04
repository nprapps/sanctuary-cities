# DETENTIONS 
# 2016-05-04 
# -----------

library(dplyr)

# load data 
setwd("gitspace/sanctuary-cities")
d = read.csv("requests.csv",header=TRUE,stringsAsFactors = FALSE)
f = read.csv("joinpvtfacility.csv",header=TRUE,stringsAsFactors = FALSE)
g = read.csv("nopvtfacility.csv",header=TRUE,stringsAsFactors = FALSE)

# ------------

# PUBLIC PRISONS: find out the percentage of all list_reason's for all det_facilities.
public_percentages = g %>% 
  group_by(det_facility,lift_reason) %>%
  mutate(count =n()) %>%
  group_by(det_facility) %>%
  mutate(count_all =n()) %>%
  mutate(freq = 100/count_all*count) %>%
  group_by(det_facility,lift_reason,count,count_all,freq) %>%
  summarise()

# PUBLIC PRISONS: find out the average percentage for all list_reasons
public_averages = public_percentages %>%
  group_by(lift_reason) %>%
  summarise(average=mean(freq))

# ------------

# PRIVATE PRISONS: find out the percentage of all list_reason's for all det_facilities.
private_percentages = f %>% 
  group_by(det_facility,lift_reason) %>%
  mutate(count =n()) %>%
  group_by(det_facility) %>%
  mutate(count_all =n()) %>%
  mutate(freq = 100/count_all*count) %>%
  group_by(det_facility,lift_reason,count,count_all,freq) %>%
  summarise()

# PRIVATE PRISONS: find out the average percentage for all list_reasons
private_averages = private_percentages %>%
  group_by(lift_reason) %>%
  summarise(average=mean(freq))

# ------------

# export as csv
write.csv(private_percentages, file="detentations_percentages.csv")
write.csv(private_averages, file="detentations_averages.csv")
write.csv(public_percentages, file="detentations_percentages.csv")
write.csv(public_averages, file="detentations_averages.csv")
