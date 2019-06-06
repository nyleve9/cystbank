rm(list=ls())  # clear all variables
fail.mx<-matrix(c(0,0,0,0.5,0,0,0,0.5,0.49),3,3,byrow=TRUE)
mean.mx<-matrix(c(3.6,0.98,0.65,0.5,0,0,0,0.5,0.49),3,3,byrow=TRUE)
max.mx<-matrix(c(120.5,4.53,3.95,0.5,0,0,0,0.5,0.98),3,3,byrow=TRUE)

# -----INPUT PARAMETERS----------------------

maxyr = 100 # the number of years to simulate

startN = c(10000,0,0) # starting population size vector/matrix

Reps = 5 # number of replicate runs to make    

Nqe = 100 # quasi-extinction threshold

maxcap = 100000  #simulates a carrying capacity

prob.fail= .6

#---- END OF INPUTS ---------------------------
Ns = matrix(0,maxyr,Reps) # set up a matrix for the pop sizes to fill
n<-c(1,2)

for (jj in 1:Reps) {  
  prob.mean<-(1-prob.fail)
  N0 = startN
  Ns[1,jj]=sum(startN) # initialize with starting pop size
  
  for (ii in 1:(maxyr-1)) {
    mx=NULL
    choose<-sample(n,1,replace=TRUE,prob=c(prob.mean,prob.fail))
    if (choose == 1 ) {
      mx = mean.mx
    } else {
      mx = fail.mx
    }              
    
    N0<-mx%*%N0
    Ns[(ii+1),jj]<-sum(N0)  #this grows the population one year
    
    #enforcing the quasi-extinction threshold:
    if (Ns[(ii+1),jj] <= Nqe) {Ns[(ii+1),jj]=0} 
    #enforcing the maximum cap on population numbers:
    if (Ns[(ii+1),jj] >= maxcap)  {Ns[(ii+1),jj]=maxcap}  
    
  } # end of ii loop
} # end of jj loop

l=length(Ns)
lambdas<-((Ns[2:l])/(Ns[1:(l-1)]))
#lambdas
geomean<-(prod(lambdas))^(1/99)
#mean(log(lambdas))

#plot(Ns,xlab="years",type="l",col="1")
lines(Ns,type="l",col="8")

#perparing a matrix to use in estimating extinction risk:
Ns2=Ns 
Ns2[Ns2 >0] = 1 #set all values of Ns that are greater than one to 
alive = apply(Ns2,1,sum)
dead = 100*(1-alive/Reps)


allyrs = c(1:maxyr)
windows()

plot(allyrs,dead,type = "l",xlab="Year",ylab="Extinction CDF")

windows()
matplot(allyrs,Ns, type = "l",xlab="Year",ylab="Nt",main="Arithmetic scale")

windows()
matplot(allyrs,log(Ns), type = "l",xlab="Year",ylab="log(Nt)",main="Log scale")
