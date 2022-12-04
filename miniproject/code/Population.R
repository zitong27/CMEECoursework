rm(list = ls())
graphics.off()
library(minpack.lm)
library(ggplot2)
data <- read.csv("../data/IDData.csv")
data[is.na(data) | data == "Inf" | data == "-Inf"] <- NA


quadratic_model<-data.frame()
for (i in unique(data$ID)){
  data_subset <- data[data$ID == i,]
  if (nrow(data_subset) < 5) { 
    next
  }
  else {
    try(
      fit_quad<-lm(log_PopBio ~ poly(Time,2),data = data_subset)
      )
    summQuad<-summary(fit_quad)
    df<-data.frame(
      ID=i,
      R2=summQuad$r.squared,
      AIC=AIC(fit_quad),
      BIC=BIC(fit_quad)
    )}
  quadratic_model=rbind(quadratic_model,df)
}


cubic_model<-data.frame()
for (i in unique(data$ID)){
  data_subset <- data[data$ID == i,]
  if (nrow(data_subset) < 5) { 
    next
  }
  else {
    try(
      fit_cubic<-lm(log_PopBio ~ poly(Time,3),data = data_subset))
    summCubic<-summary(fit_cubic)
    df<-data.frame(
      ID=i,
      R2=summCubic$r.squared,
      AIC=AIC(fit_cubic),
      BIC=BIC(fit_cubic)
      
    )}
  cubic_model=rbind(cubic_model,df)
}



logistic <- function(t, r, K, N0){ # The classic logistic equation
  return((N0 * K * exp(r * t)/(K + N0 * (exp(r * t) - 1))))
}
logistic_model<- data.frame()
for (i in unique(data$ID)){
  data_subset <- data[data$ID == i,]
  if (nrow(data_subset) < 5) { 
    next
  }
  else {
    N0_start <- min(data_subset$PopBio)
    K_start <- max(data_subset$PopBio)
    #r_model <- lm(data_subset$PopBio~data_subset$Time)
    #r_start <- coef(r_model)[[2]]
    r_start <- 0.00000001
    
    fit_logistic = try(nlsLM(PopBio ~ logistic(t = Time, r, K, N0), data_subset,
                        list(r=r_start, N0 = N0_start, K = K_start),
                        control = nls.lm.control(maxiter = 100)),silent = T)
    if(class(fit_logistic) != "try-error"){
      summLogis <- summary(fit_logistic)
      rss <- sum((logistic(t=data_subset$Time,r=summLogis$parameters[1],
                           K=summLogis$parameters[3],
                           N0=summLogis$parameters[2]) 
                - data_subset$PopBio) ^ 2)
      tss <- sum((data_subset$PopBio-mean(data_subset$PopBio))^2)
      rsq <- 1-rss/tss
    
      df<-data.frame(
      ID=i,
      R2=rsq,
      AIC=AIC(fit_logistic),
      BIC=BIC(fit_logistic),
      MaxTime=max(data_subset$Time),
      r=(summLogis$parameters[1]),
      K=(summLogis$parameters[3]),
      N0=(summLogis$parameters[2])
      )
      }else{
        df <- data.frame(
          ID=i,
          R2=NA,
          AIC=NA,
          BIC=NA,
          MaxTime=NA,
          r=NA,
          K=NA,
          N0=NA
          )
      }
    logistic_model=rbind(logistic_model,df)}
}


gompertz <- function(t, r, K, N0, t_lag){ # Modified gompertz growth model (Zwietering 1990)
  return(N0 + (K - N0) * exp(-exp(r * exp(1) * (t_lag - t)/((K - N0) * log(10)) + 1)))
}   
gompertz_model<- data.frame()
for (i in unique(data$ID)){
  data_subset <- data[data$ID == i,]
  if (nrow(data_subset) < 5) { 
    next
  }
  else {
    N0_start <- rnorm(100, m = min(data_subset$log_PopBio), sd = abs(3*min(data_subset$log_PopBio)))
    K_start <- rnorm(100, m = 2*max(data_subset$log_PopBio), sd = abs(3*2*max(data_subset$log_PopBio)))
    r_start <- runif(100, min = 10^-10, max = 10^-2)
    t_lag_start <- rnorm(100, m = data_subset$Time[which.max(diff(diff(data_subset$log_PopBio)))], 
                         sd = abs(3*data_subset$Time[which.max(diff(diff(data_subset$log_PopBio)))]))
    
    for (k in 1:100){
      fit_gompertz = try(nlsLM(log_PopBio ~ gompertz(t = Time, r, K, N0,t_lag), data_subset,
                             list(r=r_start[k], N0 = N0_start[k], K = K_start[k], t_lag = t_lag_start[k]),
                             control = nls.lm.control(maxiter = 100)),silent = T)
      
      
      if(class(fit_gompertz) != "try-error"){
        summGomp <- summary(fit_gompertz)
        rss <- sum((gompertz(t=data_subset$Time,r=summGomp$parameters[1],K=summGomp$parameters[3],
                           N0=summGomp$parameters[2],t_lag = summGomp$parameters[4]) 
                  - data_subset$log_PopBio) ^ 2)
        tss <- sum((data_subset$log_PopBio-mean(data_subset$log_PopBio))^2)
        rsq <- 1-rss/tss
      
        df<-data.frame(
          ID=i,
          R2=rsq,
          AIC=AIC(fit_gompertz),
          BIC=BIC(fit_gompertz),
          MaxTime=max(data_subset$Time),
          r=summGomp$parameters[1],
          K=summGomp$parameters[3],
          N0=summGomp$parameters[2],
          t_lag = summGomp$parameters[4]
          )
        gompertz_model=rbind(gompertz_model,df)
        break
      }
    }  
    if (class(fit_gompertz) == "try-error"){
      df <- data.frame(
        ID=i,
        R2=NA,
        AIC=NA,
        BIC=NA,
        MaxTime=NA,
        r=NA,
        K=NA,
        N0=NA,
        t_lag = NA
        )
      gompertz_model=rbind(gompertz_model,df)
    }
  }
}


loglogis <- function(t, r, K, N0){ # Modify the logistic equation to log logistic
  return(log(N0 * K * exp(r * t)/(K + N0 * (exp(r * t) - 1))))
}
loglogis_model<- data.frame()
for (i in unique(data$ID)){
  data_subset <- data[data$ID == i,]
  if (nrow(data_subset) < 5) { 
    next
  }
  else {
    N0_start <- min(data_subset$PopBio)
    K_start <- max(data_subset$PopBio)
    r_start <- 0.00000001
    #log population fitted by log logistic model
    fit_loglogis = try(nlsLM(log_PopBio ~ loglogis(t = Time, r, K, N0), data_subset,
                             list(r=r_start, N0 = N0_start, K = K_start),
                             control = nls.lm.control(maxiter = 100)),silent = T)
    if(class(fit_loglogis) != "try-error"){
      summLoglogi <- summary(fit_loglogis)
      rss <- sum((loglogis(t=data_subset$Time,r=summLoglogi$parameters[1],
                           K=summLoglogi$parameters[3],
                           N0=summLoglogi$parameters[2]) 
                  - data_subset$log_PopBio) ^ 2)
      tss <- sum((data_subset$log_PopBio-mean(data_subset$log_PopBio))^2)
      rsq <- 1-rss/tss
      
      df<-data.frame(
        ID=i,
        R2=rsq,
        AIC=AIC(fit_loglogis),
        BIC=BIC(fit_loglogis),
        MaxTime=max(data_subset$Time),
        r=(summLoglogi$parameters[1]),
        K=(summLoglogi$parameters[3]),
        N0=(summLoglogi$parameters[2])
      )
    }else{
      df <- data.frame(
        ID=i,
        R2=NA,
        AIC=NA,
        BIC=NA,
        MaxTime=NA,
        r=NA,
        K=NA,
        N0=NA
      )
    }
    loglogis_model=rbind(loglogis_model,df)}
}

visual<-function(i){
  data_subset <- data[data$ID == i,]
  timepoints<-data_subset$Time
  
  quadratic_points= predict(lm(log_PopBio ~ poly(Time,2),data = data_subset))
  
  cubic_points=predict(lm(log_PopBio ~ poly(Time,3),data = data_subset))
  
  logistic_points= log(logistic(t = timepoints,
                                r = logistic_model$r[logistic_model$ID==i], 
                                K = logistic_model$K[logistic_model$ID==i], 
                                N0 = logistic_model$N0[logistic_model$ID==i]))
  gompertz_points = gompertz(t = timepoints, 
                             r = gompertz_model$r[gompertz_model$ID==i], 
                             K = gompertz_model$K[gompertz_model$ID==i], 
                             N0 = gompertz_model$N0[gompertz_model$ID==i], 
                             t_lag = gompertz_model$t_lag[gompertz_model$ID==i])
  loglogis_points=loglogis(t = timepoints,
                           r = loglogis_model$r[loglogis_model$ID==i], 
                           K = loglogis_model$K[loglogis_model$ID==i], 
                           N0 = loglogis_model$N0[loglogis_model$ID==i])
  
  
  df1 <- data.frame(timepoints, quadratic_points)
  df1$model <- "Quadratic model"
  names(df1) <- c("Time", "Log_PopBio", "model")
  
  df2 <- data.frame(timepoints, cubic_points)
  df2$model <- "Cubic model"
  names(df2) <- c("Time", "Log_PopBio", "model")
  
  df3 <- data.frame(timepoints, logistic_points)
  df3$model <- "Logistic model"
  names(df3) <- c("Time", "Log_PopBio", "model")
  
  df4 <- data.frame(timepoints, gompertz_points)
  df4$model <- "Gompertz model"
  names(df4) <- c("Time", "Log_PopBio", "model")
  
  df5 <- data.frame(timepoints, loglogis_points)
  df5$model <- "Log Logistic model"
  names(df5) <- c("Time", "Log_PopBio", "model")
  
  model_frame <- rbind(df1, df2,df3,df4,df5)
  
  ggplot(data_subset, aes(x = Time, y = log_PopBio)) +
    geom_point(size = 3) +
    geom_line(data = model_frame, aes(x = Time, y = Log_PopBio, col = model), size = 1) +
    theme_bw() + # make the background white
    theme(aspect.ratio=1)+ # make the plot square 
    labs(x = "Time", y = "log(Population)")
}
  
p1<-visual(1)
ggsave("../data/p1.pdf",p1)
p118<-visual(118)
ggsave("../data/p118.pdf",p118)
p261<-visual(261)
ggsave("../data/p261.pdf",p261)

#find the Best AIC BIC R2
listAIC<-c()
for (i in unique(data$ID)){
  data_subset <- data[data$ID == i,]
  if (nrow(data_subset) < 5) { 
    next
  }
  else {
    minAIC<-rep(NA,4)
    minAIC[1]<-quadratic_model$AIC[quadratic_model$ID==i]
    minAIC[2]<-cubic_model$AIC[cubic_model$ID==i]
    minAIC[3]<-loglogis_model$AIC[loglogis_model$ID==i]
    minAIC[4]<-gompertz_model$AIC[gompertz_model$ID==i]
    listAIC<-c(listAIC,which.min(minAIC))
  
  }
}

bestAIC<-c(length(which(listAIC==1)),length(which(listAIC==2)),
              length(which(listAIC==3)),length(which(listAIC==4)))



listBIC<-c()
for (i in unique(data$ID)){
  data_subset <- data[data$ID == i,]
  if (nrow(data_subset) < 5) { 
    next
  }
  else {
    minBIC<-rep(NA,4)
    minBIC[1]<-quadratic_model$BIC[quadratic_model$ID==i]
    minBIC[2]<-cubic_model$BIC[cubic_model$ID==i]
    minBIC[3]<-loglogis_model$BIC[loglogis_model$ID==i]
    minBIC[4]<-gompertz_model$BIC[gompertz_model$ID==i]
    listBIC<-c(listBIC,which.min(minBIC))
    
  }
}

bestBIC<-c(length(which(listBIC==1)),length(which(listBIC==2)),
            length(which(listBIC==3)),length(which(listBIC==4)))

listR2<-c()
for (i in unique(data$ID)){
  data_subset <- data[data$ID == i,]
  if (nrow(data_subset) < 5) { 
    next
  }
  else {
    maxR2<-rep(NA,4)
    maxR2[1]<-quadratic_model$R2[quadratic_model$ID==i]
    maxR2[2]<-cubic_model$R2[cubic_model$ID==i]
    maxR2[3]<-loglogis_model$R2[loglogis_model$ID==i]
    maxR2[4]<-gompertz_model$R2[gompertz_model$ID==i]
    listR2<-c(listR2, which.max(maxR2))
    
  }
}


bestR2<-c(length(which(listR2==1)),length(which(listR2==2)),
           length(which(listR2==3)),length(which(listR2==4)))


pdf('../data/bestfit.pdf',8, 4)
par(mfrow=c(1,3), mar=c(1,1,2,1),oma=c(3,1,2,1))

barplot(height = bestAIC, 
        names.arg = c('Quadratic','Cubic', 'Logistic', 'Gompertz'), 
        cex.names=0.9,
        col = 7,  
        cex.axis=0.8,
        font.axis = 3,
        border = '#ffffff', 
        ylab = "Count",
        main = 'AIC')
barplot(height = bestBIC,
        names.arg = c('Quadratic','Cubic', 'Logistic', 'Gompertz'), 
        cex.names=0.9,
        col = 8,  
        cex.axis=0.8,
        font.axis = 3,
        border = '#ffffff', 
        main = 'BIC')
barplot(height = bestR2, 
        names.arg = c('Quadratic','Cubic', 'Logistic', 'Gompertz'), 
        cex.names=0.9,
        cex.axis=0.8,
        font.axis = 3,
        col = 11, 
        border = '#ffffff', 
        main = 'R2')

graphics.off()

