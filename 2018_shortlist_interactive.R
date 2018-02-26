#install packages
install.packages("DT")
install.packages("htmlwidgets")
install.packages("widgetframe")

unloadNamespace('data.table')
unloadNamespace('reshape2')
unloadNamespace('plyr')

#load datatables library
library(DT)
library(htmlwidgets)
library(widgetframe)

#load neighborhood stress index csv
dat <- read.csv("//FILESHARE/projects/Azavea_SummerOfMaps/documents/2018/project_descriptions/2018_shortlist.csv")

dat_clean <- dat[,c(23,16,22,17)]

#create data table as R object
shortlist_table <- datatable(dat_clean, rownames = FALSE,
                             colnames=c("Category", "Organization","Project Title", "Organization URL"), 
                             extensions = 'Responsive',
                             options = list(
                               searching = FALSE,
                               pageLength = 12,
                               paging = FALSE,
                               initComplete = JS(
                                 "function(settings, json) {",
                                 "$(this.api().table().header()).css({
                                 'background-color': '#092253', 
                                 'color': '#fff', 
                                 'font-family': 'verdana',
                                 'font-size': '14px'});",
                                 "}")
)) %>%
  formatStyle(columns = c(1, 2, 3, 4), fontSize = '80%', fontFamily = 'verdana')


#create htmlwidget object with neighborhood score table
saveWidget(frameableWidget(shortlist_table), "//FILESHARE/projects/Azavea_SummerOfMaps/documents/2018/project_descriptions/2018_summerofmaps_shortlist/docs/index.html", selfcontained = FALSE, libdir = "src")
