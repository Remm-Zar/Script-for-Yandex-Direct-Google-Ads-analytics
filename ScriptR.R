#Установка модуля
install.packages("ryandexdirect")
#Подключение модуля
library(ryandexdirect)
#Получение пути к рабочей директории
WorkPath <- getwd()
#Двухэтапная авторизация

#ПРИМЕЧАНИЕ:если у вас ещё нет токена, то при выполнении yadirAuth() откроется браузер и попросит авторизоваться в Яндекс аккаунте.
#После успешной авторизации вы будете перенаправлены на страницу, где автоматически сгенерируется код для получнения токена (7 цифр).
#Код нужно скопировать и вставить в консоль (Enter authorize code: ) и нажать Enter.
#Далее появится вопрос о сохранении токена по пути WorkPath - жмём y (yes).
#Готово.Токен сохранен в файл, и пока он у вас есть, подключение из скрипта к Яндекс кабинету по указанному логину будет происходить автматически.

yadirAuth(Login="sea-mg-dzo-sbereducation-guest",TokenPath=WorkPath)

#Получение отчёта за определенный период
date_from <- as.Date(readline(prompt = "Введите начальную дату в формате ГГГГ-ММ-ДД без кавычек: "))
date_to <- as.Date(readline(prompt = "Введите конечную дату в формате ГГГГ-ММ-ДД без кавычек: "))

report <- yadirGetReport(DateFrom = date_from,DateTo = date_to,FieldNames = c("CampaignName","Date","Clicks","Conversions","Cost"),Login="sea-mg-dzo-sbereducation-guest",TokenPath = WorkPath)

#Просмотреть отчёт
View(report)