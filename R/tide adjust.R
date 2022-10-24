# #library(reshape)
# #
# #root<-'D:/Lavoro/LAVAL/HLO/data'
# #
# #
# ## load tides
# #
# #tides<-read.table(paste0(root,'/tide.txt'), skip=1, head=T,sep='\t', dec='.')
# #names(tides)<-c('date',0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)
# #tid<-melt(tides)
# #names(tid)<-c('date','time','diff')
# #
# #tid$date.time<-paste(tid$date,tid$time)
# #tid$date.time<-strptime(tid$date.time,'%Y/%m/%d %H')
# #tid$date.time<-as.POSIXct(tid$date.time) 
# #tid<-tid[order(tid$date.time),]
# #
# #
# #
# ###
# #
# #wp<-read.table(paste0(root,'/metis bottom survey.csv'), head=T,sep=';', dec=',')
# #
# #wp$date.time<-paste(wp$date, wp$time)
# #
# #wp$date.time<-strptime(wp$date.time,'%d/%m/%Y %H.%M')
# #wp$date.time<-as.POSIXct(wp$date.time) # as.POSIXct aslo attach the time zone to the value. This created problems during the shift from EDT to EST.   as.POSIXlt do not provide info on time zone.
# #
# #
# #
# ##wac$date.time[1]<tidtab$date.time[1]
# ##awac$date.time[1]==tidtab$date.time[1]
# ##awac$date.time[1]>tidtab$date.time[1]
# ##
# #wp$adj<-NA
# #wp$depth.adj<-NA
# #for (i in 1: nrow(wp)){
# #
# #
# #
# #inf<-max(which(tid$date.time<=wp$date.time[i]))
# #sup<-min(which(tid$date.time>=wp$date.time[i]))
# #
# #m<-lm(diff~date.time, data=tid[c(inf,sup),])
# #p<-predict(m, data.frame(date.time=wp$date.time[i]))
# #
# #wp$adj[i]<-p
# #wp$depth.adj[i]<- wp[i,11]- wp$adj[i]
# #
# #}
# #
# #

# #
# #
# #######
# #
# #
# #
# #dept.adjust<-function(dataset) {
# #
# #library(reshape)
# #root<-'D:/Lavoro/LAVAL/HLO/data'
# #
# #
# ## load tides
# #
# #tides<-read.table(paste0(root,'/tide.txt'), skip=1, head=T,sep='\t', dec='.')
# #names(tides)<-c('date',0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)
# #tid<-melt(tides)
# #names(tid)<-c('date','time','diff')
# #
# #tid$date.time<-paste(tid$date,tid$time)
# #tid$date.time<-strptime(tid$date.time,'%Y/%m/%d %H')
# #tid$date.time<-as.POSIXct(tid$date.time) 
# #tid<-tid[order(tid$date.time),]
# #
# #
# ###
# #
# #wp<-read.table(paste0(root,'/',dataset,'.csv'), head=T,sep=';', dec=',')
# #
# #wp$date.time<-paste(wp$date, wp$time)
# #
# #wp$date.time<-strptime(wp$date.time,'%d/%m/%Y %H.%M')
# #wp$date.time<-as.POSIXct(wp$date.time) # as.POSIXct aslo attach the time zone to the value. This created problems during the shift from EDT to EST.   as.POSIXlt do not provide info on time zone.
# #
# #
# #
# ##wac$date.time[1]<tidtab$date.time[1]
# ##awac$date.time[1]==tidtab$date.time[1]
# ##awac$date.time[1]>tidtab$date.time[1]
# ##
# #wp$adj<-NA
# #wp$depth.adj<-NA
# #for (i in 1: nrow(wp)){
# #
# #
# #
# #inf<-max(which(tid$date.time<=wp$date.time[i]))
# #sup<-min(which(tid$date.time>=wp$date.time[i]))
# #
# #m<-lm(diff~date.time, data=tid[c(inf,sup),])
# #p<-predict(m, data.frame(date.time=wp$date.time[i]))
# #
# #wp$adj[i]<-p
# #wp$depth.adj[i]<- wp[i,11]- wp$adj[i]
# #}
# #
# #
# #write.table(wp,paste0(root,'/',dataset,'.csv'), sep=';', dec=',', row.names=F)
# #}
# #

# ##############################
# ##############################
# ##############################
# ##############################


# dept.adjust<-function(TideTablePath='./data/tide.txt',dataset, depth=NULL, date.time=NULL) {

# # root<-'D:/Lavoro/LAVAL/HLO/'
# # setwd(root)
# # TideTablePath='./data/tide.txt'
# # date.time='2015-08-05 15:10'
# # depth=10

# library(reshape)



# # load tides

# tides<-read.table(TideTablePath, skip=1, head=T,sep='\t', dec='.')
# names(tides)<-c('date',0:23)
# tid<-melt(tides)
# names(tid)<-c('date','time','diff')

# tid$date.time<-paste(tid$date,tid$time)
# tid$date.time<-strptime(tid$date.time,'%Y/%m/%d %H')
# tid$date.time<-as.POSIXct(tid$date.time) 
# tid<-tid[order(tid$date.time),]


# ##

# if (is.null(depth)) {


# wp<-read.table(paste0(root,'/',dataset,'.csv'), head=T,sep=';', dec=',')

# wp$date.time<-paste(wp$date, wp$time)

# wp$date.time<-strptime(wp$date.time,'%d/%m/%Y %H.%M')
# wp$date.time<-as.POSIXct(wp$date.time) # as.POSIXct aslo attach the time zone to the value. This created problems during the shift from EDT to EST.   as.POSIXlt do not provide info on time zone.



# #wac$date.time[1]<tidtab$date.time[1]
# #awac$date.time[1]==tidtab$date.time[1]
# #awac$date.time[1]>tidtab$date.time[1]
# #
# wp$adj<-NA
# wp$depth.adj<-NA
# for (i in 1: nrow(wp)){



# inf<-max(which(tid$date.time<=wp$date.time[i]))
# sup<-min(which(tid$date.time>=wp$date.time[i]))

# m<-lm(diff~date.time, data=tid[c(inf,sup),])
# p<-predict(m, data.frame(date.time=wp$date.time[i]))

# wp$adj[i]<-p
# wp$depth.adj[i]<- wp[i,11]- wp$adj[i]
# }


# write.table(wp,paste0(root,'/',dataset,'.csv'), sep=';', dec=',', row.names=F)
# } else {

# date.time<-strptime(date.time,format='%Y-%m-%d %H:%M')
 
# inf<-max(which(tid$date.time<=date.time))
# sup<-min(which(tid$date.time>=date.time))


# m<-lm(diff~date.time, data=tid[c(inf,sup),])
# p<-predict(m, data.frame(date.time=date.time))

# adj<-p
# depth.adj<- depth- adj

# print(paste('On',date.time,',',depth,'m equals',round(depth.adj,1),'meters at lowest tide') )

# }



# }











