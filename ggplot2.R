library(readxl)
library(ggplot2)
library(scales)

bw_kreis_popn <- read_excel("F:/Projects/ggplot_practice/BW_Kreis_data.xlsx")
print(bw_kreis_popn)
ggplot(bw_kreis_popn, aes(x=reorder(Name,`2022_Pop`),y=`2022_Pop`))+
  geom_col(fill="forestgreen")+
  labs(title="Kreiswise Population Baden-Württemburg", x="Kreis", y="Population in 2022")+
  theme(axis.text.x = element_text(angle = 45, hjust = 1, color = "black"),
        axis.text.y = element_text(color = "black"),
        panel.background = element_rect(fill = "lightgray"),
        plot.background = element_rect(fill = "white"))+
  scale_y_continuous(labels = comma)
