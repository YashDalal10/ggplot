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