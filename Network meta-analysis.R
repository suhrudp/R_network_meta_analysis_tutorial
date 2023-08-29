# NETWORK META-ANALYSIS

## **LOAD LIBRARIES**

```{r}
library(netmeta)
library(metafor)
library(metadat)
```

## **ATTACH DATA**

```{r}
df <- read.csv(file.choose())
attach(df)
View(df)
```

## CALCULATE EFFECT SIZE

```{r}
dfes <- escalc(measure = "SMD", n1i = N1, n2i = N2, m1i = M1, m2i = M2, sd1i = SD1, sd2i = SD2, data = df)
View(dfes)
```

## RANDOM EFFECTS META-ANALYSIS

```{r}
ma.mod <- rma(yi, vi, data=dfes)
summary(ma.mod)
forest.rma(ma.mod, slab = Author)
```

## NETWORK META-ANALYSIS

```{r}
dfes$T1 <- as.factor(dfes$T1)
dfes$T2 <- as.factor(dfes$T2)
sei <- sqrt(dfes$vi)
dfes <- cbind(dfes, sei)

nma.mod <- netmeta(data=dfes, TE=yi, seTE=sei, treat1=T1, treat2=T2, studlab = Author, sm = "SMD", small.values = "good", reference.group = "Placebo", all.treatments = TRUE)
summary(nma.mod)
nma.rank <- netrank(nma.mod)
nma.rank
nma.split <- netsplit(nma.mod)
nma.split
nma.pair <- netpairwise(nma.mod)
nma.pair
forest(nma.mod)
forest(nma.pair)
plot(nma.split)
plot(nma.rank)
netgraph(nma.mod)
netheat(nma.mod)
```
