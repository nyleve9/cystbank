rm(list=ls())  # clear all variables
#mean.mx<-matrix(c(6.56,0.03,0.01,0.004,62.4,0,0,0,0,0.44,0,0,0,0,0.49,0.49),4,4,byrow=TRUE)
mean.mx<-matrix(c((78*0.1*.42),0.03,0.01,0.004,(78*0.9),0,0,0,0,0.44,0,0,0,0,0.49,0.49),4,4,byrow=TRUE)
fail.mx<-matrix(c(0,0,0,0,0,0,0,0,0,0.44,0,0,0,0,0.49,0.49),4,4,byrow=TRUE)

# -----INPUT PARAMETERS----------------------

maxyr = 200 # the number of years to simulate

startN = c(0,10000,0,0) # starting population size vector/matrix

Reps = 100 # number of replicate runs to make    

Nqe = 400 # quasi-extinction threshold

maxcap = 100000  #simulates a carrying capacity for adult stage

prob.fail= .6 #probability of choosing the fail matrix

#---- END OF INPUTS ---------------------------
Ns = matrix(0,maxyr,Reps) # set up a matrix for the pop sizes to fill
stages = matrix(0,4,200,byrow=TRUE) #set up a matrix for the stages to fill
percmatrix = matrix(0,4,200,byrow=TRUE)
n<-c(1,2)

for (jj in 1:Reps) {  
  prob.mean<-(1-prob.fail)
  N0 = startN
  stages[,jj]<-startN
  percmatrix[,1]<-(startN/sum(startN))
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
    if (N0[1,1] >= maxcap)  {N0[1,1]=maxcap}  #enforcing the maximum cap on adults
    stages[,(ii+1)]<-N0
    percmatrix[,(ii+1)]<-((N0)/(sum(N0)))
    
    Ns[(ii+1),jj]<-sum(N0)  #this grows the population one year
    
    #enforcing the quasi-extinction threshold:
    if (Ns[(ii+1),jj] <= Nqe) {N0=0*N0} 
    
  } # end of ii loop
} # end of jj loop

#perparing a matrix to use in estimating extinction risk:
Ns2=Ns 
Ns2[Ns2 >0] = 1 #set all values of Ns that are greater than one to 
alive = apply(Ns2,1,sum)
dead = 100*(1-alive/Reps)


allyrs = c(1:maxyr)
windows()

plot(allyrs,dead,type = "l",xlab="Filling cycles",ylab="Extinction CDF")

windows()
matplot(allyrs,Ns, type = "l",xlab="Filling cycles",ylab="Nt",main="Population size (arithmetic scale)")

barplot(stages,main="Population over time",xlab="Filling cycles",ylab="Population size",col=rainbow(4))
names.arg<-c("adults","cyst 1","cyst 2","cyst 3")
legend("topleft",names.arg,cex=0.35,fill=rainbow(4))

#barplot(percmatrix,main="Percentage of population in 4 life stages",xlab="Filling cycles",ylab="Population proportions",col=rainbow(4))
#names.arg<-c("adults","cyst 1","cyst 2","cyst 3")
#legend("topleft",names.arg,cex=0.35,fill=rainbow(4))

#windows()
#matplot(allyrs,log(Ns), type = "l",xlab="Year",ylab="log(Nt)",main="Log scale")

#l=length(Ns)
#lambdas<-((Ns[2:l])/(Ns[1:(l-1)]))
#lambdas
#geomean<-(prod(lambdas))^(1/99)
#geomean
#mean(log(lambdas))

#plot(Ns,xlab="years",type="l",col="1")
#lines(Ns,type="l",col="8")

#--------------ELASTICITIES----------------------------
mean.mx<-matrix(c(6.56,0.03,0.01,0.004,62.4,0,0,0,0,0.44,0,0,0,0,0.49,0.49),4,4,byrow=TRUE)
eigen(mean.mx)  #6.8397

#adult-adult
mean.mx<-matrix(c(6.232,0.03,0.01,0.004,62.4,0,0,0,0,0.44,0,0,0,0,0.49,0.49),4,4,byrow=TRUE)
eigen(mean.mx)  #6.5255
(6.840-6.5255)/(6.840)  #0.04598
0.04598/0.05  #0.9196

#cyst1-adult
mean.mx<-matrix(c(6.232,0.0285,0.01,0.004,62.4,0,0,0,0,0.44,0,0,0,0,0.49,0.49),4,4,byrow=TRUE)
eigen(mean.mx)  #6.5118
(6.840-6.5118)/(6.840)  #0.04798
0.04798/0.05  #0.9596

#cyst2-adult
mean.mx<-matrix(c(6.232,0.03,0.0095,0.004,62.4,0,0,0,0,0.44,0,0,0,0,0.49,0.49),4,4,byrow=TRUE)
eigen(mean.mx)  #6.5252
(6.840-6.5252)/(6.840)  #0.04602

#cyst3-adult
mean.mx<-matrix(c(6.232,0.03,0.01,(0.004*.95),62.4,0,0,0,0,0.44,0,0,0,0,0.49,0.49),4,4,byrow=TRUE)
eigen(mean.mx)  #6.5255
(6.840-6.5255)/(6.840)  #0.04598

#adult-cyst1
mean.mx<-matrix(c(6.232,0.03,0.01,0.004,(.95*62.4),0,0,0,0,0.44,0,0,0,0,0.49,0.49),4,4,byrow=TRUE)
eigen(mean.mx)  #6.5115
(6.840-6.5115)/(6.840)  #0.04802

#-----------------------------------

mean.mx<-matrix(c(6.56,0.0285,0.01,0.004,62.4,0,0,0,0,0.44,0,0,0,0,0.49,0.49),4,4,byrow=TRUE)
eigen(mean.mx)  #6.8397

#adult-adult
mean.mx<-matrix(c((78*.19*.42),0.03,0.01,0.004,(78*.81),0,0,0,0,0.44,0,0,0,0,0.49,0.49),4,4,byrow=TRUE)
eigen(mean.mx)   #6.5217
(6.840-6.5217)/(6.840)  #0.0465
0.0465/0.05 #0.93

#cyst1-adult
mean.mx<-matrix(c(6.56,(.5*.114*.42),0.01,0.004,62.4,0,0,0,0,(.5*(1-.114)),0,0,0,0,0.49,0.49),4,4,byrow=TRUE)
eigen(mean.mx)  #6.786
(6.840-6.786)/(6.840)  #0.00789
0.00789/0.05 #0.1578

#cyst2-adult
mean.mx<-matrix(c(6.56,0.03,(.5*.0285*.42),0.004,62.4,0,0,0,0,0.44,0,0,0,0,(1-.0285),0.49),4,4,byrow=TRUE)
eigen(mean.mx)  #6.838
(6.840-6.838)/(6.840)  #0.000292
0.000292/0.05 #0.00584

#cyst3-adult
mean.mx<-matrix(c(6.56,0.03,0.01,(.5*.019*.42),62.4,0,0,0,0,0.44,0,0,0,0,0.49,(.5*(1-.019))),4,4,byrow=TRUE)
eigen(mean.mx)  #6.83765
(6.840-6.83765)/(6.840) #0.0003436
0.0003436/0.05  #0.006872

#adult-cyst1
#mean.mx<-matrix(c(6.56,0.03,0.01,0.004,(78*.76),0,0,0,0,0.44,0,0,0,0,0.49,0.49),4,4,byrow=TRUE)
mean.mx<-matrix(c((78*.24*.42),0.03,0.01,0.004,(78*.76),0,0,0,0,0.44,0,0,0,0,0.49,0.49),4,4,byrow=TRUE)
eigen(mean.mx)  #8.086
#(6.840-6.826)/(6.840) #0.00204
(6.840-8.086)/(6.840) #0.182
0.00204/0.05  #0.0408
#0.0408/0.05  #0.816
0.182/0.05  #3.64

#cyst1-cyst2
mean.mx<-matrix(c(6.56,(.5*(1-.836)*.42),0.01,0.004,62.4,0,0,0,0,(.5*.836),0,0,0,0,0.49,0.49),4,4,byrow=TRUE)
eigen(mean.mx)  #6.878
(6.840-6.878)/(6.840) #0.0055556
0.0055556/0.05  #0.1111

#cyst2-cyst3
mean.mx<-matrix(c(6.56,0.03,(.5*(1-.922)*.42),0.004,62.4,0,0,0,0,0.44,0,0,0,0,(.5*.922),0.49),4,4,byrow=TRUE)
eigen(mean.mx)  #6.8433
(6.840-6.8433)/(6.840) #0.000483
0.000483/0.05  #0.00966

#cyst3-cyst3+
mean.mx<-matrix(c(6.56,0.03,0.01,(.5*(1-.931)*.42),62.4,0,0,0,0,0.44,0,0,0,0,0.49,(.5*.931)),4,4,byrow=TRUE)
eigen(mean.mx) #6.8402
(6.840-6.8402)/(6.840) #-0.00002924
0.00002924/0.05  #0.0005848

#------------------------------------
fail.mx<-matrix(c(0,0,0,0,0,0,0,0,0,0.44,0,0,0,0,0.49,0.49),4,4,byrow=TRUE)
eigen(fail.mx)  #0.49

#cyst1-cyst2
fail.mx<-matrix(c(0,0,0,0,0,0,0,0,0,(.5*.836),0,0,0,0,0.49,0.49),4,4,byrow=TRUE)
eigen(fail.mx)  #0.49
(.49-.49)/0.05  #0

#cyst2-cyst3
fail.mx<-matrix(c(0,0,0,0,0,0,0,0,0,0.44,0,0,0,0,(.5*.9215),0.49),4,4,byrow=TRUE)
eigen(fail.mx)  #0.49
(.49-.49)/0.05  #0

#cyst3-cyst3+
fail.mx<-matrix(c(0,0,0,0,0,0,0,0,0,0.44,0,0,0,0,0.49,(.5*.931)),4,4,byrow=TRUE)
eigen(fail.mx)  #0.4655
(.49-.4655)/0.49  #0.05
0.05/0.05  #1

#------------------------------------------------
mean.mx<-matrix(c(6.56,0.03,0.01,0.004,62.4,0,0,0,0,0.44,0,0,0,0,0.49,0.49),4,4,byrow=TRUE)
fail.mx<-matrix(c(0,0,0,0,0,0,0,0,0,0.44,0,0,0,0,0.49,0.49),4,4,byrow=TRUE)

ematrix<-matrix(nrow=3,ncol=3) #makes an empty matrix
ematrix<-mean.mx #stores the mean matrix in the ematrix
lams=NULL
hatch0<-seq(0.05,1,by=0.01)
for(i in hatch0) {
  ematrix[1,1]<-i*78*.42
  ematrix[2,1]<-(1-i)*78
  ev<-eigen(ematrix)
  lams<-c(lams,ev$values[1]) 
}
lams<-as.matrix(lams)
hatch0<-as.matrix(hatch0)
plot(hatch0,lams,xlab="Probabilities for Vital Rates",ylab="lambda",type="l",col="red")
cols=c("red","navy","black","green","dodgerblue","tan2")
legend("topleft",cex=.5,legend=c("Hatch c0","Surv nauplii","Surv cysts","Hatch c1","Hatch c2","Hatch c3"),text.col=cols)
#--------------------------------------

ematrix<-matrix(nrow=3,ncol=3) #makes an empty matrix
ematrix<-mean.mx #stores the mean matrix in the ematrix
lams=NULL
nau<-seq(0.05,1,by=0.01)
for(i in nau) {
  ematrix[1,1]<-78*.2*i
  ematrix[1,2]<-.5*.12*i
  ematrix[1,3]<-.5*.03*i
  ematrix[1,4]<-.5*.02*i
  ev<-eigen(ematrix)
  lams<-c(lams,ev$values[1]) 
}
lams<-as.matrix(lams)
nau<-as.matrix(nau)
lines(nau,lams,type="l",col="navy")

#----------------------------------------------------------------

#ematrix<-matrix(nrow=3,ncol=3) #makes an empty matrix
#ematrix<-mean.mx #stores the mean matrix in the ematrix
#lams=NULL
#survc1<-seq(0.05,1,by=0.01)
#for(i in survc1) {
#  ematrix[1,2]<-.12*.42*i
#  ematrix[3,2]<-.88*i
#  ev<-eigen(ematrix)
#  lams<-c(lams,ev$values[1]) 
#}
#lams<-as.matrix(lams)
#survc1<-as.matrix(survc1)
#lines(survc1,lams,type="l",col="4")
#plot(survc1,lams,type="l",col="4")

#------------------------------------
ematrix<-matrix(nrow=3,ncol=3) #makes an empty matrix
ematrix<-mean.mx #stores the mean matrix in the ematrix
lams=NULL
survcs<-seq(0.05,1,by=0.01)
for(i in survcs) {
  ematrix[1,2]<-.12*.42*i
  ematrix[1,3]<-.03*.42*i
  ematrix[1,4]<-.02*.42*i
  ematrix[3,2]<-.88*i
  ematrix[4,3]<-.97*i
  ematrix[4,4]<-.98*i
  ev<-eigen(ematrix)
  lams<-c(lams,ev$values[1]) 
}
lams<-as.matrix(lams)
survcs<-as.matrix(survcs)
lines(survcs,lams,type="l",col="black")

#------------------------------

ematrix<-matrix(nrow=3,ncol=3) #makes an empty matrix
ematrix<-mean.mx #stores the mean matrix in the ematrix
lams=NULL
hatch1<-seq(0.05,1,by=0.01)
for(i in hatch1) {
  ematrix[1,2]<-.5*.42*i
  ematrix[2,1]<-(1-i)*.5
  ev<-eigen(ematrix)
  lams<-c(lams,ev$values[1]) 
}
lams<-as.matrix(lams)
hatch1<-as.matrix(hatch1)
lines(hatch1,lams,type="l",col="green")
#slope is slightly negative

#-----------------------------------------------------------

ematrix<-matrix(nrow=3,ncol=3) #makes an empty matrix
ematrix<-mean.mx #stores the mean matrix in the ematrix
lams=NULL
hatch2<-seq(0.05,1,by=0.01)
for(i in hatch2) {
  ematrix[1,3]<-.5*.42*i
  ematrix[4,3]<-(1-i)*.5
  ev<-eigen(ematrix)
  lams<-c(lams,ev$values[1]) 
}
lams<-as.matrix(lams)
hatch2<-as.matrix(hatch2)
lines(hatch2,lams,type="l",col="dodgerblue")

#--------------------------------------------------

ematrix<-matrix(nrow=3,ncol=3) #makes an empty matrix
ematrix<-mean.mx #stores the mean matrix in the ematrix
lams=NULL
hatch3<-seq(0.05,1,by=0.01)
for(i in hatch3) {
  ematrix[1,3]<-.5*.42*i
  ematrix[4,3]<-(1-i)*.5
  ev<-eigen(ematrix)
  lams<-c(lams,ev$values[1]) 
}
lams<-as.matrix(lams)
hatch3<-as.matrix(hatch3)
lines(hatch3,lams,type="l",col="tan2")

#===========================
mean.mx<-matrix(c(6.56,0.03,0.01,0.004,62.4,0,0,0,0,0.44,0,0,0,0,0.49,0.49),4,4,byrow=TRUE)
fail.mx<-matrix(c(0,0,0,0,0,0,0,0,0,0.44,0,0,0,0,0.49,0.49),4,4,byrow=TRUE)

ematrix<-matrix(nrow=3,ncol=3) #makes an empty matrix
ematrix<-fail.mx #stores the mean matrix in the ematrix
lams=NULL
survc1<-seq(0.05,1,by=0.01)
for(i in survc1) {
  ematrix[3,2]<-.5*(1-i)
  ev<-eigen(ematrix)
  lams<-c(lams,ev$values[1]) 
}
lams<-as.matrix(lams)
survc1<-as.matrix(survc1)
plot(survc1,lams,ylim=range(0,0.6),xlab="Probabilities for Vital Rates (Fail matrix)",ylab="lambda",type="l",col="red")
cols=c("red","blue","green")
legend("topleft",cex=.5,legend=c("Hatch c1","Hatch c2","Hatch c3"),text.col=cols)
#--------------------------------------
ematrix<-matrix(nrow=3,ncol=3) #makes an empty matrix
ematrix<-fail.mx #stores the mean matrix in the ematrix
lams=NULL
survc2<-seq(0.05,1,by=0.01)
for(i in survc2) {
  ematrix[4,3]<-.5*(1-i)
  ev<-eigen(ematrix)
  lams<-c(lams,ev$values[1]) 
}
lams<-as.matrix(lams)
survc2<-as.matrix(survc2)
lines(survc2,lams,type="l",col="blue")
#------------
ematrix<-matrix(nrow=3,ncol=3) #makes an empty matrix
ematrix<-fail.mx #stores the mean matrix in the ematrix
lams=NULL
survc3<-seq(0.05,1,by=0.01)
for(i in survc3) {
  ematrix[4,4]<-.5*(1-i)
  ev<-eigen(ematrix)
  lams<-c(lams,ev$values[1]) 
}
lams<-as.matrix(lams)
survc3<-as.matrix(survc3)
lines(survc3,lams,type="l",col="green")
#-------------------------------------------------
