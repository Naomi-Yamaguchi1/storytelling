#libs
library(naniar)
library(visdat)

#initial read in
bigPapa <- read.csv("SummerStudentAdmissions2.csv")

#checking the data out
head(bigPapa)
vis_miss(bigPapa)
glimpse(bigPapa)
summary(bigPapa)
vis_dat(bigPapa)

#Decision cleanup
dec <- unique(bigPapa$Decision)
print(dec)
allowDec <- c("Admit", "Decline", "Waitlist")
#convert all empty strings and wrong values to NAs
bigPapa$Decision <- ifelse(bigPapa$Decision %in% allowDec, bigPapa$Decision, NA)
dec <- unique(bigPapa$Decision)
print(dec)

#States cleanup
states <- unique(bigPapa$State)
print(states)
#no NAs, so convert all to caps
bigPapa$State <- ifelse(bigPapa$State == 'virginia', 'Virginia', ifelse(bigPapa$State == 'mississippi', 'Mississippi', bigPapa$State))
states <- unique(bigPapa$State)
print(states)

#GPA cleanup
print(bigPapa$GPA)
#a few empty cells and one misvalue of 6
bigPapa$GPA <- ifelse(bigPapa$GPA > 4, NA, ifelse(bigPapa$GPA < 0, NA, bigPapa$GPA))
print(bigPapa$GPA)

#WorkExp cleanup
print(bigPapa$WorkExp)
bigPapa$WorkExp <- ifelse(bigPapa$WorkExp > 10, NA, ifelse(bigPapa$WorkExp < 0, NA, bigPapa$WorkExp))
print(bigPapa$WorkExp)

#TestScore cleanup
print(bigPapa$TestScore)
#this all looks kosher

#WritingScore cleanup
print(bigPapa$WritingScore)
bigPapa$WritingScore <- ifelse(bigPapa$WritingScore > 100, NA, ifelse(bigPapa$WritingScore < 50, NA, bigPapa$WritingScore))
print(bigPapa$WritingScore)

#Gender cleanup
print(bigPapa$Gender)
bigPapa$Gender <- ifelse(bigPapa$Gender != 1, ifelse(bigPapa$Gender != 0, NA, bigPapa$Gender), bigPapa$Gender)
print(bigPapa$Gender)

#VolunteerLevel cleanup
print(bigPapa$VolunteerLevel)
#this all looks good

#post cleaning
#take a look
head(bigPapa)
vis_miss(bigPapa)
glimpse(bigPapa)
summary(bigPapa)
vis_dat(bigPapa)

#drop NAs and reset index
bigPapaClean <- na.omit(bigPapa)
row.names(bigPapaClean) <- NULL

#post dropping NAs
#take a look
head(bigPapaClean)
vis_miss(bigPapaClean)
glimpse(bigPapaClean)
summary(bigPapaClean)
vis_dat(bigPapaClean)

#final writeout
write.csv(bigPapaClean, "cleanedAdmissions.csv")
