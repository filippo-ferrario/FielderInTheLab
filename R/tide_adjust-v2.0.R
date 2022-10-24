#===============================================================================
# Name   : Depth correction for tide	
# Author : Filippo Ferrario
# Date   : 08/07/2020
# Version: 2.0
# Aim    : Correct depths recorded in the field to remove the tidal level.
#		   The function need to work independently from the source of data of both tide and depths to correct.
#		   The correction is made by fitting a line between water levels at 2 successives timepoints from the tide tables (or observations).
#		   The fitted regression line is then used to predict the tide level at the time point of the observed depth to be corrected.
#		   Finally the predicted tide level is subtracted from the observed depth.
#		   Strategy:
#		   - import tide table : specify timestamp column and water level columns.
#		   - import dataset of observed depth: : specify timestamp column and observed level columns.
#		   - return a vector of corrected depths.
# 			Based on the "dept.adjust" function wrote for the HLO project.
# 		   	
#===============================================================================


#' Correction of depth measures for tide level
#' 
#'  
#' @param tidetable_df dataframe with tide table
#' @param observed_df dataframe with observed depth to be corrected. 
#' @param time_tide_col either a number or a character specifying the position or the name of the column in `tidetable_df` for the time of the tide table 
#' @param lev_tide_col either a number or a character specifying the position or the name of the column in `tidetable_df` for the tide level of the tide table
#' @param time_obs_col either a number or a character specifying the position or the name of the column in `observed_df` for the time of the observed depths
#' @param depth_obs_col either a number or a character specifying the position or the name of the column in `observed_df` for the observed depths
#' @param depth
#' @param date.time
#' @param ts_tide_format format used for time in `tidetable_df`
#' @param ts_obs_format format used for time in `observed_df`
#' 
#' 
#' 
#' 
#' @export



depth_adjust<-function(tidetable_df,observed_df, time_tide_col=NULL, lev_tide_col=NULL, time_obs_col=NULL,depth_obs_col=NULL, depth=NULL, date.time=NULL, ts_tide_format='%d/%m/%Y %H.%M', ts_obs_format=ts_tide_format) {

	#agrs check
	if( ! is.data.frame(tidetable_df)) stop('tidetable_df must be dataframe')
	if( ! is.data.frame(observed_df)) stop('observed_df must be dataframe')
	if(! (is.null(lev_tide_col)| is.null(time_tide_col) | is.null(time_obs_col) | is.null(depth_obs_col) )) {
		if (!(is.numeric(lev_tide_col) | is.character(lev_tide_col))) stop('lev_tide_col must be a character or a number')
		if (!(is.numeric(time_tide_col) | is.character(time_tide_col))) stop('time_tide_col must be a character or a number')
		if (!(typeof(lev_tide_col) == typeof(time_tide_col))) stop('lev_tide_col and time_tide_col must be of the same class/type')
		if (!(is.numeric(time_obs_col) | is.character(time_obs_col))) stop('time_obs_col must be a character or a number')
		if (!(is.numeric(depth_obs_col) | is.character(depth_obs_col))) stop('depth_obs_col must be a character or a number')
		if (!(typeof(depth_obs_col) == typeof(time_obs_col))) stop('lev_tide_col and time_tide_col must be of the same class/type')
	}
	if (!(is.numeric(ts_tide_format) | is.character(ts_tide_format))) stop('ts_tide_format must be a character')
	if (!(is.numeric(ts_obs_format) | is.character(ts_obs_format))) stop('ts_obs_format must be a character')



	# internal function that does the correction 
	pred_lev<-function(obs_time, TT){

		# define the upper and lower limits of the time interval of interest in the tide table	
		inf<-max(which(TT$ts<=obs_time))
		sup<-min(which(TT$ts>=obs_time))

		if(inf!=sup){
				# predict tide level at observed time
				m<-lm(lev~ts, data=TT[c(inf,sup),])
				p<-predict(m, data.frame(ts=obs_time))
		} else{
			p<-unique(TT[c(inf,sup),]$lev)
		}
		# return value
		return(p)
	}

    # rename tide table dataset and columns for ease of coding
	TT<-tidetable_df
	if (is.numeric(lev_tide_col)) {
			names(TT)[c(lev_tide_col,time_tide_col)]<-c('lev','ts')
			} else{
			   names(TT)[names(TT)==lev_tide_col]<-'lev'
			   names(TT)[names(TT)==time_tide_col]<-'ts'	
			}

	# make sure time is correctely formatted
	TT$ts<-as.POSIXct(strptime(TT$ts,format= ts_tide_format) )
	if(sum(is.na(TT$ts))>0) stop ('double check time format specification and that no missing values are present in Time column')
	TT<-TT[order(TT$ts),]

	# IF Single depth
	if (!is.null(depth)) {
		date.time<-as.POSIXct(strptime(date.time,format= ts_obs_format) )
		p<-pred_lev(obs_time=date.time,TT)	
		#correct depth	
		res<-depth-p
	} else {
	# IF dataset to be corrected
		OBS<-observed_df
		if (is.numeric(depth_obs_col)) {
			names(OBS)[c(depth_obs_col,time_obs_col)]<-c('depth','ts')
			} else{
			   names(OBS)[names(OBS)==depth_obs_col]<-'depth'
			   names(OBS)[names(OBS)==time_obs_col]<-'ts'	
			}
		OBS$ts<-as.POSIXct(strptime(OBS$ts,format= ts_obs_format) )
		# initialize result vector
		res<-NULL
		# loop through TT times to estimate tide levels (probably not the moste efficient coding!)
		 for (i in 1: nrow(OBS)){ #browser()
		 	date.time<-OBS$ts[i]
		 	p<-pred_lev(obs_time=date.time,TT)	
		 	res[i]<- OBS$depth[i]-p
		 }
	}

	return(res)

}


## Bench
## ------

## FUNCTION ARGS: tidetable_df,observed_df, time_tide_col=NULL, lev_tide_col=NULL, time_obs_col=NULL,depth_obs_col=NULL, depth=NULL, date.time=NULL, ts_format='%d/%m/%Y %H.%M'

# tides<-read.csv('C:/Users/Utilisateur/Documents/Lavoro/LAVAL/CHONE/data/tide-2780-01-JUL-2018_slev.csv', skip=7,  row.names =NULL)
# tides<-tides[,-3];names(tides)<-c('time','slev'); head(tides)

# # depth=5
# # date.time='2018/07/01 0:30'
# # ts_format='%Y/%m/%d %H:%M'

# depth_adjust(tidetable_df=tides,time_tide_col=1, lev_tide_col=2,depth=5,date.time='2018/07/01 1:0',ts_format='%Y/%m/%d %H:%M')


# tidetable_df=tides; observed_df=bsi2; time_tide_col = 1; lev_tide_col = 2; 
#     time_obs_col = 3; depth_obs_col = 6; depth = NULL; 
#     date.time = NULL; ts_tide_format = "%Y/%m/%d %H:%M";ts_obs_format = "%Y-%m-%d %H:%M"


