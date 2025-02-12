# GGPLOT2: 7 Days Challenge (Day 2)
# https://towardsdatascience.com/7-day-challenge-mastering-ggplot2-day-2-line-graph-2cfbdf164c81/

library(regclass)
library("skimr")
library(ggplot2)
library("dplyr")
library(scales)
library(ggthemes)
library(grid)
library("tsibble")


# Single Line graph

df1 <- pedestrian
# print(df1)
df1 <- df1 %>%
  mutate(month_year = yearmonth(Date_Time))
count_all <- df1 %>% 
    group_by(month_year) %>%
    summarise(total = sum(Count))
# print(count_all)

plot1 <- ggplot(count_all, aes(x = month_year, y = total)) +
  geom_line(group = 1) +
#   geom_text(aes(label = total_count), size = 5, vjust = -0.25) +
#   ggtitle("Distribution of Gender") +
  xlab("Year-Month") +
  ylab("Total Pedestrians (thousands)") +
  ggtitle("Total Pedestrians by month") +
  theme_economist() + scale_fill_economist() +
  theme(plot.title = element_text(color = "black", size = 14, face = "bold", hjust = 0.5),
  axis.title.x = element_text(color = "black", size = 12, face = "bold"),
  axis.title.y = element_text(color = "black", size = 12, face = "bold"))

plot2 <- plot1 + theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust = 0.5, size = 9)) +
    scale_y_continuous(labels = function(x) format(x/1000))

# plot(plot2)

plot3 <- plot2 + geom_line(group=1, size=1.5, color="darkblue") +
    geom_point(size=3.5, color="darkblue", shape=17)

# plot(plot3)

# plot4 <- plot3 + geom_label(aes(label=round(total/1000,0)), size=3, color="darkblue")

# plot(plot4)


# Multi Line Graph

count_sensor <- df1 %>% 
    group_by(month_year, Sensor) %>%
    summarise(total = sum(Count))
# print(count_sensor)

plot5 <- ggplot(count_sensor, aes(x=month_year, y=total, group=Sensor, color=Sensor)) +
    geom_line(size=1.5) +
    xlab("Year-Month") + ylab("Total Pedestrians") + ggtitle("Total Pedestrians by Sensor") +
    scale_y_continuous(labels = function(x) format(x/1000)) +
    theme_economist() + scale_fill_economist() +
    theme(
      plot.title = element_text(color = "black", size = 15, face = "bold", hjust = 0.5),
      axis.title.x = element_text(color = "black", size = 12, face = "bold"),
      axis.title.y = element_text(color = "black", size = 12, face = "bold"),
      axis.text.x = element_text(angle = 45, vjust = 0.5, hjust = 0.5, size=9)
    )

# plot(plot5)

plot6 <- plot5 + scale_color_manual(values = c("green", "orange", "red", "blue")) +
    theme(legend.position = "top") +
    theme(legend.title = element_text(color = "black", size = 10, face = "italic"),
    legend.text = element_text(color = "black", size = 10, face = "italic"))
# plot(plot6)

values <- count_sensor %>% 
    filter(Sensor == 'Bourke Street Mall (North)', month_year %in% c("2016-12", "2015-11"))

print(values)

plot7 <- plot6 + geom_label(aes(label = round(total/1000.0)), data = values, size = 10, color = "darkgreen")
plot(plot7)
