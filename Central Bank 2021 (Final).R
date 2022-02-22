#-----A Simple Program to Automatically Extract Appendix Tables from the Central Bank of Barbados Review of the Economy in 2021
#----by Zach Gaskin
#---Last Update: February 18th, 2022
#--Note: Required packages: pdftools, tidyverse and  xlsx. You can either install through the install.packages() command line or Tools -> Install Packages.
#-Version: I am currently using R version 4.1.2 (2021-11-01) -- "Bird Hippie"


library(pdftools)
library(tidyverse)
library(openxlsx)


#Retrieve PDF document from Central Bank of Barbados' Website
pdf <- "http://www.centralbank.org.bb/Portals/0/Files/Central%20Bank%20of%20Barbados%20Review%20of%20the%20Economy%20in%202021.pdf"

#Convert PDF file to plain text formatting
text <- pdftools::pdf_text(pdf)
text <- str_split(text, "\n")

#Beginning with Table 1 - Economic Indicators, convert list to a vector preserving all components
Table1 <- unlist(text[19])
#Replace all multiple spaces in vector with an arbitrary delimiter ~. This will be key when we split the vector into multiple columns.
Table1 <- gsub("    +","~",Table1)
#Perform some basic cleaning and formatting operations
Table1 <- replace(Table1, 7, "Avg. Unemployment (%)3~9.7~10.0~10.1~10.1~17.9**~12.4*")
Table1 <- replace(Table1, 28, "Domestic Currency Deposits (% of GDP)5~114.8~112.7~111.5~109.6~131.0~129.6")
Table1 <- replace(Table1, 44, "(p)-Provisional")
Table1 <- replace(Table1, 46, "(e)-Estimate")
Table1 <- replace(Table1, 48, "1 - Central Bank of Barbados and Barbados Statistical Service")
Table1 <- replace(Table1, 50, "2 - Twelve Month Moving Average- Data as at November, 2021")
Table1 <- replace(Table1, 52, "3 - Four Quarter Moving Average")
Table1 <- replace(Table1, 54, "4 - Gross Public Sector Debt = Gross Central Government Debt + Other Public Sector Debt")
Table1 <- replace(Table1, 56, "5 - Based on consolidated data for deposit-taking insitutions (Commercial Banks, Finance & Trust Companies and Credit Unions)")
Table1 <- replace(Table1, 57, "* - Data as at September 2021")
Table1 <- replace(Table1, 58, "** Data as at September 2020")
Table1 <- replace(Table1, 59, "Sources: Barbados Statistical Service, Accountant General, Ministry of Finance, and Central Bank of Barbados")
#Create a dataframe 
Table1 <- data.frame(Table1)
#Split vector into multiple columns
Table1 <- separate(Table1, col=1, into=c("Indicator","2016","2017","2018","2019","2020(p)","2021(e)"), sep="~")
#Remove unwanted rows in the dataframe
Table1 <- Table1[-c(1,2,3,8,9,10,17,20,21,29,30,31,33,43,45,47,49,51,53,55,60:65), ]
#Replace all NAs with blank cells
Table1[is.na(Table1)] <- ""
#Inspect Table1
view(Table1)

#We now simulate a similar process for Tables 2 - Table 7

#Table 2 - GDP by Sector and Activity (BDS$Millions, Constant Prices)
Table2 <- unlist(text[20])
Table2 <- gsub("  +","~",Table2)
Table2 <- replace(Table2, 35, "~(p)–Provisional")
Table2 <- replace(Table2, 38, "~(e)–Estimate")
Table2 <- replace(Table2, 41, "~BSS' 2010 Base Year Series")
Table2 <- replace(Table2, 42, "~Sources: Barbados Statistical Service and Central Bank of Barbados")
Table2 <- data.frame(Table2)
Table2 <- separate(Table2, col=1, into=c("Blank","Indicator","2016","2017","2018","2019","2020(p)","2021(e)"), sep="~")
Table2 <- Table2[-c(1)]
Table2 <- Table2[-c(1:3,17,18,29,30,34,36,37,39,40,43:48), ]
Table2[is.na(Table2)] <- ""
view(Table2)

#Table 3 - Balance of Payments (BDS $Millions)
Table3 <- unlist(text[21])
Table3 <- gsub("  +","~",Table3)
Table3 <- sub("Current","~Current", Table3)
Table3 <- sub("Inflows","~Inflows",Table3)
Table3 <- sub("Merchanting","~Net Export of Goods under Merchanting",Table3)
Table3 <- sub("Outflows","~Outflows",Table3)
Table3 <- sub("Capital","~Capital",Table3)
Table3 <- sub("Financial","~Financial",Table3)
Table3 <- sub("Net Errors","~Net Errors",Table3)
Table3 <- sub("Overall","~Overall",Table3)
Table3 <- sub("Change","~Change",Table3)
Table3 <- replace(Table3, 47, "~(p)-Provisional")
Table3 <- replace(Table3, 49, "~(e)–Estimate")
Table3 <- replace(Table3, 50, "~Source: Central Bank of Barbados")
Table3 <- data.frame(Table3)
Table3 <- separate(Table3, col=1, into=c("Blank","Indicator","2016","2017","2018","2019","2020(p)","2021(e)"), sep="~")
Table3 <- Table3[-c(1)]
Table3 <- Table3[-c(1:3,17,30,39,43,46,48,51:54), ]
Table3[is.na(Table3)] <- ""
view(Table3)

#Table 4 - Summary of Government Operations (BDS$ Millions)
Table4 <- unlist(text[22])
Table4 <- gsub("  +","~",Table4)
Table4 <- replace(Table4, 23, "~Fuel Tax~~~68.6~82.1~63.8~26.5~61.3~54.8~50.2")
Table4 <- replace(Table4, 24, "~Room Rate/Shared Accommodation~~~10.1~28.1~9.5~4.9~18.1~5.4~12.5")
Table4 <- replace(Table4, 53, "~(p) Provisional")
Table4 <- replace(Table4, 56, "~Source: Ministry of Finance and Central Bank of Barbados")
Table4 <- data.frame(Table4)
Table4 <- separate(Table4, col=1, into=c("Blank","Indicator","2016/17","2017/18","2018/19","2019/20","2020/21","Apr-Dec 2018", "Apr-Dec 2019", "Apr-Dec 2020", "Apr-Dec 2021(p)"), sep="~")
Table4 <- Table4[-c(1)]
Table4 <- Table4[-c(1:5,43,52,54,55,57:62), ]
Table4[is.na(Table4)] <- ""
view(Table4)

#Table 5 - Government Financing (BDS$ Millions)
Table5 <- unlist(text[23])
Table5 <- gsub("   +","~",Table5)
Table5 <- replace(Table5, 9, "~Arrears Payments~~~(10.0)~(208.3)~(61.9)~0.0~(208.3)~(61.9)~(29.9)")
Table5 <- replace(Table5, 11, "~Financing Requirement~524.1~450.2~40.5~(176.2)~491.5~(74.2)~(112.7)~97.8~250.4")
Table5 <- replace(Table5, 24, "~Private Non-Bank~94.6~(57.2)~(119.6)~(217.7)~(34.9)~(83.5)~(132.6)~(72.0)~(0.4)")
Table5 <- replace(Table5, 26, "~Other~61.3~332.8~(111.2)~(58.3)~(167.9)~(185.2)~(46.9)~(172.2)~(318.1)")
Table5 <- replace(Table5, 38, "~(p) Provisional")
Table5 <- replace(Table5, 41, "~Source: Central Bank of Barbados")
Table5 <- data.frame(Table5)
Table5 <- separate(Table5, col=1, into=c("Blank","Indicator","2016/17","2017/18","2018/19","2019/20","2020/21","Apr-Dec 2018", "Apr-Dec 2019", "Apr-Dec 2020", "Apr-Dec 2021(p)"), sep="~")
Table5 <- Table5[-c(1)]
Table5 <- Table5[-c(1:5,7,8,10,12,13,16,18,20,22,23,25,27,30,32,34,36,39,40,42:47), ]
Table5[is.na(Table5)] <- ""
view(Table5)

#Table 6 - Public Debt Outstanding (BDS $Millions)
Table6 <- unlist(text[24])
Table6 <- gsub("   +","~",Table6)
Table6 <- sub("Gross","~Gross",Table6)
Table6 <- replace(Table6, 29,"~Other Public Sector Debt")
Table6 <- replace(Table6, 7,"~Gross Central Government Debt1~13,294.1~13,704.1~12,573.8~12,426.4~12,761.2~13,310.7")
Table6 <- replace(Table6, 10, "~Central Bank2~2,012.4~2,227.7~703.8~814.1~757.0~811.5")
Table6 <- replace(Table6, 30, "~Domestic Debt~965.8~884.6~-~-~-~-")
Table6 <- replace(Table6, 33, "~Other Public Sector Arrears~n.a.~n.a.~n.a.~6.0~-~-")
Table6 <- replace(Table6, 36,"~Gross Public Sector Debt3~14,532.2~14,848.1~12,668.2~12,498.7~12,814.7~13,358.2")
Table6 <- replace(Table6, 40,"~Central Government Financial Assets~752.1~715.1~795.0~739.6~912.3~525.9")
Table6 <- replace(Table6, 47,"~Other Public Sector Financial Assets~239.8~189.0~221.6~392.6~426.0~502.6")
Table6 <- replace(Table6, 57, "~(p) Provisional")
Table6 <- replace(Table6, 59, "~1 Gross Central Government Debt = Domestic Debt + External Debt+ Domestic and External Arrears")
Table6 <- replace(Table6, 61, "~2 Comprises Treasury Bills, Debentures and Ways & Means Account Balance")
Table6 <- replace(Table6, 63, "~3 Gross Public Sector Debt = Gross Central Government Debt + Other Public Sector Debt +Arrears")
Table6 <- replace(Table6, 65, "~4 Net Central Government Debt = Gross Central Government Debt - Central Government Financial Assets")
Table6 <- replace(Table6, 66,"~n.a.- Not Available")
Table6 <- replace(Table6, 67,"~Sources: Accountant General, Ministry of Finance and Central Bank of Barbados")
Table6 <- data.frame(Table6)
Table6 <- separate(Table6, col=1, into=c("Blank","Indicator","2016","2017","2018","2019","2020","2021(e)"), sep="~")
Table6 <- Table6[-c(1)]
Table6 <- Table6[-c(1:6,8,11,19,27,34,37,38,41,45,46,48,51,58,60,62,64,68:72), ]
Table6[is.na(Table6)] <- ""
view(Table6)

#Table 7 - Select Monetary Aggregates and Financial Stability Indicators (BDS $Millions)
Table7 <- unlist(text[25])
Table7 <- gsub("   +","~",Table7)
Table7 <- replace(Table7, 41,"~ (p) Provisional")
Table7 <- replace(Table7, 44,"~1 Comprises Commercial Banks, Deposit Taking Finance & Trust Companies and Credit Unions")
Table7 <- replace(Table7, 46, "~2 Reflects both security holdings and loans.")
Table7 <- replace(Table7, 48, "~3 Does not include credit to the non-resident sector")
Table7 <- replace(Table7, 50, "~4 These comprise of call deposits, demand deposits and savings deposits with unrestricted withdrawal privileges")
Table7 <- replace(Table7, 52, "~5 Data on commercial banking sector")
Table7 <- data.frame(Table7)
Table7 <- separate(Table7, col=1, into=c("Blank","Indicator","2016","2017","2018","2019","2020","2021(e)"), sep="~")
Table7 <- Table7[-c(1)]
Table7 <- Table7[-c(1:3,8,15,18,21,26,31,40,42,43,45,47,49,51,54:59), ]
Table7[is.na(Table7)] <- ""
view(Table7)


#Export the Appendix tables to Microsoft Excel
Tables <- list("Table 1 - Economic Indicators"=Table1, "Table 2 - GDP by Sector"=Table2, "Table 3 - Balance of Payments"=Table3, "Table 4 - Government Operations"=Table4, "Table 5 - Government Financing"=Table5, "Table 6 - Public Debt"=Table6, "Table 7 - Monetary Agg and FSI"=Table7)
write.xlsx(Tables, paste("Central Bank of Barbados Review of the Barbados Economy in 2021(BDS $Millions).xlsx"))

#Once in Excel, you can easily convert to numbers and perform your data analysis!

