gmmparams <- function(result, id) {
    a <- result$parameters$pro[[id]]
    m <- result$parameters$mean[[id]]
    v <- 0
    if(result$modelName == "V"){
        v <- result$parameters$variance$sigmasq[[id]]
    }
    else{
        v <- result$parameters$variance$sigmasq
    }
    return (list(a,m,v))
}

densProb <- function(val, result){
    ret <- 0
    g <- result$G
    c <- cdens(result$modelName, val, parameters=result$parameters)
    for(i in 1:g){
        gmmPs <- gmmparams(result, i)
        p <- c[[i]]
        a <- gmmPs[[1]]
        ret <- ret + a*p
    }
    return(ret)
}

LOG <- TRUE
#LOG <- FALSE
suppressMessages(message(library(mclust)))
args <- commandArgs(trailingOnly = T)
infile <- args[1]
outfile <- args[2]
CLUSTS <- args[3]
data <- read.table(infile,skip=1)
write.table(CLUSTS, outfile, append=T, row.names=F, col.name=F)
N <- ncol(data)
sum <- rowSums(data)
## convert logscale
if(LOG){
    data <- data + 1
    ld <- log(data)
}else ld <- data

probs <- array(1:N+1)
len <- nrow(data)
for(i in 1:N){
    ## train data
    ldTr <- ld[1:len-1,i]
    ## last data
    ldEv <- ld[len,i]
    if(CLUSTS < 1){
        result <- Mclust(ldTr)
    }else{
        result <- Mclust(ldTr, G=CLUSTS)
    }
    ## summary(result,parameters=TRUE)
    probs[i] <- densProb(ldEv, result)
}
probs <- signif(probs, digits=4)
write.table(probs, outfile, row.names=F, col.name=F, eol="\t")
if(N > 1){
    #representative value
    pMin <- min(probs)
    pMean <- mean(probs)
    pMean <- signif(pMean, digits=4)
    pMed <- median(probs)
    pMax <- max(probs)
    write.table(pMin, outfile, append=T, row.names=F, col.name=F, eol="\t")
    write.table(pMean, outfile, append=T, row.names=F, col.name=F, eol="\t")
    write.table(pMed, outfile, append=T, row.names=F, col.name=F, eol="\t")
    write.table(pMax, outfile, append=T, row.names=F, col.name=F, eol="\t")
    #sum
    if(LOG){
        sum <- sum + 1
        ld <- log(sum)
    }else ld <- sum
    ldTr <- ld[1:len-1]
    ldEv <- ld[len]
    if(CLUSTS < 1){
        result <- Mclust(ldTr)
    }else{
        result <- Mclust(ldTr, G=CLUSTS)
    }
    p <- densProb(ldEv, result)
    p <- signif(p, digits=4)
    write.table(p, outfile, append=T, row.names=F, col.name=F)
}
