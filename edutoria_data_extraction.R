#ПРИМЕЧАНИЕ:если у вас ещё нет токена, то при выполнении yadirAuth() откроется браузер и попросит авторизоваться в Яндекс аккаунте.
#После успешной авторизации вы будете перенаправлены на страницу, где автоматически сгенерируется код для получнения токена (7 цифр).
#Код нужно скопировать и вставить в консоль (Enter authorize code: ) и нажать Enter.
#Далее появится вопрос о сохранении токена по пути WorkPath - жмём y (yes).
#Готово.Токен сохранен в файл, и пока он у вас есть, подключение из скрипта к Яндекс кабинету по указанному логину будет происходить автматически.

# Installing packages
#install.packages("googleAuthR")
#install.packages("googleAnalyticsR")
#install.packages("ryandexdirect")
#install.packages("openxlsx")
#install.packages('Rcpp')

# Import of packages
library(googleAuthR)
library(googleAnalyticsR)
library(ryandexdirect)
library(openxlsx)
library(Rcpp)

# Yandex Direct authentification
WorkPath <- getwd()
yadirAuth(Login="sea-mg-dzo-sbereducation-guest",TokenPath=WorkPath)

# GA authentification
googleAuthR::gar_auth_service(
  json = "C:/Scripts/ga-data-extraction-edutoria-23199bd79bf8.json",
  scope = "https://www.googleapis.com/auth/analytics.readonly"
)

googleAuthR::gar_set_client(
  json = "C:/Scripts/client_secret_764341467749-uj4k0bnk4rq93rau61h61fv0ggqfd5oi.apps.googleusercontent.com.json", 
  scope = "https://www.googleapis.com/auth/analytics.readonly"
)

# Query list of accounts
accounts <- ga_account_list()
accounts[, c("accountName", "webPropertyName", "viewId", "viewName")]

# Getting data from GA
startDate <- "2022-07-01"
endDate <- "2022-07-07"

listGA <- google_analytics(
  viewId = 268321335,
  date_range = c(startDate,endDate),
  metrics = c("users","sessions","bounces","goal2Completions","goal3Completions"), 
  dimensions = c("medium","source","campaign"),
  filtersExpression = "ga:source==yandex;ga:medium==cpc"
)

# Getting data from Yandex Direct
listYD <- yadirGetReport(
  DateFrom = startDate,
  DateTo = endDate,
  FieldNames = c("CampaignName","CampaignId","Date","Clicks","Cost"),
  Login="sea-mg-dzo-sbereducation-guest",
  TokenPath = WorkPath
)

# Joining tables
dataGA <- as.data.frame(listGA)
dataYD <- as.data.frame(listYD)
colnames(dataYD) <- c("campaign","id","date","clicks","cost")
colnames(dataGA) <- c("medium","source","campaign","users","sessions","bounces","goal2","goal3")
report <- merge(dataGA, dataYD, by = "campaign")

# Converting data to Excel file
headlineStyle <- createStyle(
  valign = "center", 
  halign = "center", 
  textDecoration = "Bold", 
  fontSize = 12, 
  border = c("top","bottom","left","right")
)
write.xlsx(report,"report.xlsx", headerStyle = headlineStyle, tableStyle = "TableStyleLight1",borders = "all")



