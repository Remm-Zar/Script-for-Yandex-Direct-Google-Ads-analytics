install.packages("googleAuthR")
install.packages("googleAnalyticsR")
library(googleAnalyticsR)

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

sessions <- google_analytics(
  viewId = 268316287,
  date_range = c("2022-07-01", "2022-07-05"), 
  metrics = "sessions", 
  dimensions = "date"
)

sessions
