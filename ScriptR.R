#��������� ������
install.packages("ryandexdirect")
#����������� ������
library(ryandexdirect)
#��������� ���� � ������� ����������
WorkPath <- getwd()
#����������� �����������

#����������:���� � ��� ��� ��� ������, �� ��� ���������� yadirAuth() ��������� ������� � �������� �������������� � ������ ��������.
#����� �������� ����������� �� ������ �������������� �� ��������, ��� ������������� ������������� ��� ��� ���������� ������ (7 ����).
#��� ����� ����������� � �������� � ������� (Enter authorize code: ) � ������ Enter.
#����� �������� ������ � ���������� ������ �� ���� WorkPath - ��� y (yes).
#������.����� �������� � ����, � ���� �� � ��� ����, ����������� �� ������� � ������ �������� �� ���������� ������ ����� ����������� ������������.

yadirAuth(Login="sea-mg-dzo-sbereducation-guest",TokenPath=WorkPath)

#��������� ������ �� ������������ ������
date_from <- as.Date(readline(prompt = "������� ��������� ���� � ������� ����-��-�� ��� �������: "))
date_to <- as.Date(readline(prompt = "������� �������� ���� � ������� ����-��-�� ��� �������: "))

report <- yadirGetReport(DateFrom = date_from,DateTo = date_to,FieldNames = c("CampaignName","Date","Clicks","Conversions","Cost"),Login="sea-mg-dzo-sbereducation-guest",TokenPath = WorkPath)

#����������� �����
View(report)