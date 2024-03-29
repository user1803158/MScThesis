###########################
### prepare environment ###
###########################

# load datasource
('Z:/Documents/Scripts/data_management_RQ3.R')

# load libraries 
library(ggplot2) # create plots
library(GGally) # create pairs matrix with ggplot
library(RColorBrewer) # use nice colors

# dataframe without missing PSA values 
long_meas_train_noNA <- long_meas_train %>%
  filter(!is.na(PSA)) %>%
  filter(!is.na(ALP)) %>%
  filter(!is.na(LDH)) %>%
  mutate(log2LDH = log(LDH + 0.01, 2),
         log2ALP = log(ALP + 0.01, 2))

######################################################
### distributions of (log-transformed) LDH and ALP ### 
######################################################

# histograms
## LDH
hist1.LDH <- ggplot(long_meas_train_noNA, aes(x=LDH)) + 
  geom_histogram(color=brewer.pal(name='Paired', n = 12)[2], 
                 fill=brewer.pal(name='Paired', n = 12)[1], 
                 bins = 100) + 
  theme_bw() + 
  xlab('LDH (U/L)') +
  ylab('Count') +
  theme(axis.text=element_text(size=20),
        axis.title=element_text(size=22))

hist2.LDH <- ggplot(long_meas_train_noNA, aes(x=log2LDH)) + 
  geom_histogram(color=brewer.pal(name='Paired', n = 12)[2], 
                 fill=brewer.pal(name='Paired', n = 12)[1], 
                 bins = 100) + 
  theme_bw() + 
  xlab(expression(paste(log[2](LDH)))) + 
  ylab('Count') +
  theme(axis.text=element_text(size=20),
        axis.title=element_text(size=22))

## ALP
hist1.ALP <- ggplot(long_meas_train_noNA, aes(x=ALP)) + 
  geom_histogram(color=brewer.pal(name='Paired', n = 12)[2], 
                 fill=brewer.pal(name='Paired', n = 12)[1], 
                 bins = 100) + 
  theme_bw() + 
  xlab('ALP (U/L)') +
  ylab('Count') +
  theme(axis.text=element_text(size=20),
        axis.title=element_text(size=22))

hist2.ALP <- ggplot(long_meas_train_noNA, aes(x=log2ALP)) + 
  geom_histogram(color=brewer.pal(name='Paired', n = 12)[2], 
                 fill=brewer.pal(name='Paired', n = 12)[1], 
                 bins = 100) + 
  theme_bw() + 
  xlab(expression(paste(log[2](ALP)))) + 
  ylab('Count') +
  theme(axis.text=element_text(size=20),
        axis.title=element_text(size=22))

#############################
### correlation structure ###
#############################

data <- long_meas_train %>%
  select(id_num, date_lab, log2PSA, ALP, LDH, time) %>%
  mutate(log2ALP = log(ALP + 0.01, 2),
         log2LDH = log(LDH + 0.01, 2),
         time = round(time)) %>%
  filter(!is.na(log2PSA)) %>%
  filter(!is.na(log2ALP)) %>%
  filter(!is.na(log2LDH))

df <- data[,c('log2PSA', 'log2ALP', 'log2LDH', 'time')]

cor(df[,1:3])
cor.test(df$log2PSA, df$log2ALP)
cor.test(df$log2PSA, df$log2LDH)
cor.test(df$log2ALP, df$log2LDH)

times <- sort(unique(df$time))
cors <- data.frame(time = times,
                   PSA_ALP = NA, PSA_LDH = NA, ALP_LDH = NA)

for(i in 1:length(times)){
  cors[i,'PSA_ALP'] <- cor(df[df$time == times[i],1:3])[1,2]
  cors[i,'PSA_LDH'] <- cor(df[df$time == times[i],1:3])[1,3]
  cors[i,'ALP_LDH'] <- cor(df[df$time == times[i],1:3])[2,3]
}

cors <- cors %>% 
  filter(!is.na(PSA_ALP)) %>%
  filter(abs(PSA_ALP) != 1)

ggplot(data = cors) +
  geom_line(aes(x = time, y = PSA_ALP), colour = 'blue') +
  geom_line(aes(x = time, y = PSA_LDH), colour = 'red') +
  geom_line(aes(x = time, y = ALP_LDH), colour = 'black') +
  theme_bw()

mean(cors$PSA_ALP, na.rm = T)
mean(cors$PSA_LDH, na.rm = T)
mean(cors$ALP_LDH, na.rm = T)

sd(cors$PSA_ALP, na.rm = T)
sd(cors$PSA_LDH, na.rm = T)
sd(cors$ALP_LDH, na.rm = T)

####################
### export plots ### 
#################### 

plots <- list(hist1.LDH, hist2.LDH, hist1.ALP, hist2.ALP) 

filenames <- c('hist_LDH', 'hist_LDH_log', 'hist_ALP', 'hist_ALP_log')

for (i in 1:length(plots)){  
  file_name = paste('Z:/Documents/Figures/RQ3/', filenames[i], '.pdf', sep='')
  pdf(file_name, height=5,width=8)
  print(plots[[i]])
  dev.off()
}
