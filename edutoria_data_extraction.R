#install.packages("googleAuthR")
#install.packages("googleAnalyticsR")
#install.packages("openxlsx")
#install.packages('Rcpp')
library(Rcpp)
library(googleAnalyticsR)
library(openxlsx)


# Authentification
googleAuthR::gar_auth_service(
  json_file = "C:/Scripts/ga-data-extraction-edutoria-23199bd79bf8.json",
  scope = "https://www.googleapis.com/auth/analytics.readonly"
)

googleAuthR::gar_set_client(
  json = "C:/Scripts/client_secret_764341467749-uj4k0bnk4rq93rau61h61fv0ggqfd5oi.apps.googleusercontent.com.json", 
  scopes = c("https://www.googleapis.com/auth/analytics.readonly")
)

# Query list of accounts
accounts <- ga_account_list()
accounts[, c("accountName", "webPropertyName", "viewId", "viewName")]

# Getting data from GA
edutoriaDataList <- google_analytics(
  viewId = 268316287,
  date_range = c("2022-07-01","2022-07-07"),
  metrics = c("adCost","adClicks","pageViews","sessions","bounces","goal2Value","goal3Completions"), 
  dimensions = c("medium","source","campaign"),
  filtersExpression = "ga:source==yandex;ga:medium==cpc"
)

#Converting data to Excel file
edutoriaDataFrame<-as.data.frame(edutoriaDataList)
headlineStyle <- createStyle(halign = "center", textDecoration = "Bold", fontSize = 12)
write.xlsx(edutoriaDataFrame,"data.xlsx", headerStyle = headlineStyle, tableStyle = "TableStyleLight1")

