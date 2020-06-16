##### Minimal Reproducible Analysis Example
##### 1 - simulate experimental data


set.seed(1993)

# Define dimensions
Nt <- 3 # Nb treatment
Nb <- 3 # Nb farms (blocks)
Ns <- 10 # Nb fields (individual points)
N <-  Ns * Nt * Nb # Total nb observations

# Dummy variables
treat <- rep(rep(1:Nt, each = Ns), Nb)
blk <-  rep(1:Nb, each = Ns * Nb)

# Parameters
trt <- c(9, 11, 13) # mean treatment
sigmablk <- 0.5 # block variance
sigmaeps <- 0.75 # residual variance

eta <- rnorm(Nb)
bld <- sigmablk * eta

# Note that this is ugly
# R code with strong C accent
yhat <- vector("numeric", length = N)
for (i in 1:N){
  yhat[i] <- trt[treat[i]] + bld[blk[i]]
}

y <- rnorm(N, yhat, sigmaeps)

d <- data.frame(y, treat, blk)



d$y <- round(d$y, digits = 1) * 10

d[sample(N, size = 4), "y"] <- c("*", "-99", ".", "/")


d$ID <- 1:nrow(d)

d <-  dplyr::select(d, ID, blk, treat, y)


d$blk <- dplyr::case_when(d$blk == 1 ~ "de Jong",
                          d$blk == 2 ~ "de Kerk",
                          d$blk == 3 ~ "van de Boer")

id_to_lower <- sample(N, 2)
d$blk[id_to_lower] <- tolower(d$blk[id_to_lower])

d$treat <- dplyr::case_when(d$treat == 1 ~ "SuperDash",
                     d$treat == 2 ~ "Miracle",
                     d$treat == 3 ~ "Efficientie")


names(d)[grep("y", names(d))] <- "Opbrengst Mais"
names(d)[grep("treat", names(d))] <- "Type Meststof"
names(d)[grep("blk", names(d))] <- "Boederij"



write_csv(d,
          path = "./data/raw/Meststof proef WUR.csv")
