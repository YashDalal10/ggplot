# GGPLOT2: 7 Days Challenge (Day 1)
# https://towardsdatascience.com/7-day-challenge-mastering-ggplot2-day-1-bar-chart-4b2ced928a31

library(regclass)
library("skimr")
library(ggplot2)
library("dplyr")
library(scales)
library(ggthemes)
library(grid)

data(EX2.TIPS)
skimmed <- skim(EX2.TIPS)
# print(skimmed)
count_gender <- EX2.TIPS %>%
  group_by(Gender) %>%
  summarise(total_count = n())
# print(count_gender)

plot1 <- ggplot(count_gender, aes(x = Gender, y = total_count)) +
  geom_bar(color = "black", fill = "#0f6c0f", width = 0.5, stat = "identity") +
  geom_text(aes(label = total_count), size = 5, vjust = -0.25) +
  ggtitle("Distribution of Gender") +
  xlab("Gender") +
  ylab("Total") +
  theme(plot.title = element_text(color = "black", size = 14, face = "bold", hjust = 0.5),
  axis.title.x = element_text(color = "black", size = 12, face = "bold"),
  axis.title.y = element_text(color = "black", size = 12, face = "bold"))
  # coord_flip()

# stacked bar chart
plot2 <- ggplot(EX2.TIPS, aes(x = Weekday, fill = Gender)) +
  geom_bar(position = "stack")

pct_data <- EX2.TIPS %>%
  group_by(Weekday, Gender) %>%
  summarise(total_count = n()) %>%
  mutate(pct = total_count/sum(total_count), percent_scale = scales::percent(pct))

print(pct_data)

# stacked bar chart with percentage (segmented bar plot)
plot3 <- ggplot(pct_data, aes(x = Weekday, y = pct, fill = Gender)) +
  geom_bar(position = "fill", stat = 'identity') +
  scale_y_continuous(breaks = seq(0, 1, .2), label = percent) +
  geom_text(aes(label = percent_scale), size = 3, position = position_stack(vjust = 0.5)) +
  scale_fill_brewer(palette = "Set3") +
  ggtitle("Gender Distribution") +
  xlab("Weekdays") +
  ylab("Percentage") +
  theme_stata() +
  theme(plot.title = element_text(color = "black", size = 14, face = "bold", hjust = 0.5),
  axis.title.x = element_text(color = "black", size = 12, face = "bold"),
  axis.title.y = element_text(color = "black", size = 12, face = "bold"))

# side by side plot

plot4 <- ggplot(pct_data, aes(x = Weekday, y = total_count, fill = Gender)) +
  geom_bar(position = "dodge", stat = 'identity') +
  geom_text(aes(label = total_count), size = 5, vjust = 1.25, position = position_dodge(.9)) +
  scale_fill_brewer(palette = "Set3") +
  ggtitle("No of females/males by days of week") +
  xlab("Weekdays") +
  ylab("Total Number") +
  theme_stata() +
  theme(plot.title = element_text(color = "black", size = 14, face = "bold", hjust = 0.5),
  axis.title.x = element_text(color = "black", size = 12, face = "bold"),
  axis.title.y = element_text(color = "black", size = 12, face = "bold"))

# plot(plot4)

grid.newpage()

pushViewport(viewport(layout = grid.layout(nrow = 1, ncol = 2)))

define_region <- function(row, col){
  viewport(layout.pos.row = row, layout.pos.col = col)
}

print(plot3, vp = define_region(row = 1, col = 1))
print(plot4, vp = define_region(row = 1, col = 2))
