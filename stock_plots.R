library(readxl)
library(ggplot2)
library(scales)
# install.packages("treemapify")
library(treemapify)
library(treemap)
library(RColorBrewer)

valuation <- read.csv("F:/Projects/ggplot_practice/stock_valuation.csv")
print(valuation)
#ggplot(valuation, aes(area=))
treemap(valuation, index = "Scrip", vSize = "Valuation", type = "index",
        fontsize.labels = 9, fontcolor.labels = "black", fontface.labels = 1,
        palette = "Set3", title = "Stock Valuation", fontsize.title = 12)

ggplot(valuation, aes(x=Valuation, y=Scrip)) +
  geom_segment(aes(x=0, xend = Valuation, y = Scrip, yend = Scrip), color = "skyblue") +
  geom_point(color = "blue", size = 4, alpha = 0.6) +
  theme_light() +
  theme(
    panel.grid.major.y = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank(),
    axis.text.y = element_text(size = 9)
  ) +
  labs(x="Valuation", y="Scrip", title="Bar Chart of Scrip wise Valuation")