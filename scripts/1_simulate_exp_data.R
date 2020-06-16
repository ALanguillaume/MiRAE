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

# Note that this is ugly, this is speaking R code with a strong C accent
# My apologies to the reader, my simulations skills are a bit rusted
yhat <- vector("numeric", length = N)
for (i in 1:N){
  yhat[i] <- trt[treat[i]] + bld[blk[i]]
}

# Simulate response
y <- rnorm(N, yhat, sigmaeps)

# Gather variables in a data.frame
d <- data.frame(y, treat, blk)

# Add unique row ID
d$ID <- 1:nrow(d)


d$y <- round(d$y, digits = 1) * 10

# Add random missing value place holders
d[sample(N, size = 4), "y"] <- c("*", "-99", ".", "/")

# Put columns in correct order
d <-  dplyr::select(d, ID, blk, treat, y)

# Give the block Dutch farm names
d$blk <- dplyr::case_when(d$blk == 1 ~ "de Jong",
                          d$blk == 2 ~ "de Kerk",
                          d$blk == 3 ~ "van de Boer")

# Randomly uncapitalized farm names (artificial typos)
id_to_lower <- sample(N, 2)
d$blk[id_to_lower] <- tolower(d$blk[id_to_lower])

# Give fertilizer proper names
d$treat <- dplyr::case_when(d$treat == 1 ~ "SuperDash",
                            d$treat == 2 ~ "Miracle",
                            d$treat == 3 ~ "Efficiëntie")
# This Efficiëntie will cause an encoding issue we will
# solve upon cleaning the data

# Dutch variable names
names(d)[grep("y", names(d))] <- "Opbrengst Mais"
names(d)[grep("treat", names(d))] <- "Type Meststof"
names(d)[grep("blk", names(d))] <- "Boederij"


write.csv(d,
          row.names = FALSE,
          file = "./data/raw/Meststof proef WUR.csv",
          fileEncoding = "UTF-8")
