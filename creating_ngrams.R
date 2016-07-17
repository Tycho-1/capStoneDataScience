library(quanteda)

##### Using all words

con <- file("en_US.twitter.txt", "r") 
dataTwitter <- readLines(con)
close(con)

con <- file("en_US.blogs.txt", "r") 
dataBlogs <- readLines(con)
close(con)

con <- file("en_US.news.txt", "r") 
dataNews <- read.table(con,sep="\n",quote = "", header=F,stringsAsFactors = F)
close(con)

testTwitter <- sample(dataTwitter,5e4)
testNews <- sample(dataNews[,1],5e4)
testBlogs <- sample(dataBlogs,5e4)
test <- cbind(testNews,testBlogs,testTwitter)
rm(dataNews,dataBlogs,testBlogs,testNews,dataTwitter)

unigram<-tokenize(toLower(test), removePunct = TRUE, removeNumbers = TRUE, 
                  removeSymbols = TRUE, removeTwitter = TRUE, removeHyphens = TRUE, concatenator = " ",ngrams = 1)
unigram<-dfm(unigram,ignoredFeatures= c("â","s","t"))
unigram<-sort(colSums(unigram),decreasing = TRUE)

bigram<-tokenize(toLower(test), removePunct = TRUE, removeNumbers = TRUE,
                 removeSymbols = TRUE, removeTwitter = TRUE, removeHyphens = TRUE, concatenator = " ",ngrams = 2)
bigram<-dfm(bigram,ignoredFeatures=c("â","s","t"))
bigram<-sort(colSums(bigram),decreasing = TRUE)

trigram<-tokenize(toLower(test), removePunct = TRUE, removeNumbers = TRUE,
                  removeSymbols = TRUE, removeTwitter = TRUE, removeHyphens = TRUE, concatenator = " ",ngrams = 3)
trigram<-dfm(trigram,ignoredFeatures=c("â","s","t"))
trigram<-sort(colSums(trigram),decreasing = TRUE)

fourgram<-tokenize(toLower(test), removePunct = TRUE, removeNumbers = TRUE, 
                   removeSymbols = TRUE, removeTwitter = TRUE, removeHyphens = TRUE, concatenator = " ",ngrams = 4)
fourgram<-dfm(fourgram, ignoredFeatures=c("â","s","t"))
fourgram<-sort(colSums(fourgram),decreasing = TRUE)

unigram<-data.frame(names(unigram),unigram,stringsAsFactors = F)
bigram<-data.frame(names(bigram),bigram,stringsAsFactors = F)
trigram<-data.frame(names(trigram),trigram,stringsAsFactors = F)
fourgram <- data.frame(names(fourgram),fourgram,stringsAsFactors = F)

unigram <-unigram[unigram[,2]>1,]
bigram <-bigram[bigram[,2]>1,]
trigram <- trigram[trigram[,2]>1,]
fourgram<- fourgram[fourgram[,2]>1,]


#### Without stopwords

con <- file("en_US.twitter.txt", "r") 
dataTwitter <- readLines(con)
close(con)

con <- file("en_US.blogs.txt", "r") 
dataBlogs <- readLines(con)
close(con)

con <- file("en_US.news.txt", "r") 
dataNews <- read.table(con,sep="\n",quote = "", header=F,stringsAsFactors = F)
close(con)

testTwitter <- sample(dataTwitter,5e4)
testNews <- sample(dataNews[,1],5e4)
testBlogs <- sample(dataBlogs,5e4)
test <- cbind(testNews,testBlogs,testTwitter)
rm(dataNews,dataBlogs,testBlogs,testNews,dataTwitter)

unigram<-tokenize(toLower(test), removePunct = TRUE, removeNumbers = TRUE, 
                  removeSymbols = TRUE, removeTwitter = TRUE, removeHyphens = TRUE, concatenator = " ",ngrams = 1)
unigram<-dfm(unigram,ignoredFeatures= c(stopwords(),"â","s","t"))
unigram<-sort(colSums(unigram),decreasing = TRUE)

bigram<-tokenize(toLower(test), removePunct = TRUE, removeNumbers = TRUE,
                 removeSymbols = TRUE, removeTwitter = TRUE, removeHyphens = TRUE, concatenator = " ",ngrams = 2)
bigram<-dfm(bigram,ignoredFeatures=c(stopwords(),"â","s","t"))
bigram<-sort(colSums(bigram),decreasing = TRUE)

trigram<-tokenize(toLower(test), removePunct = TRUE, removeNumbers = TRUE,
                  removeSymbols = TRUE, removeTwitter = TRUE, removeHyphens = TRUE, concatenator = " ",ngrams = 3)
trigram<-dfm(trigram,ignoredFeatures= c(stopwords(),"â","s","t"))
trigram<-sort(colSums(trigram),decreasing = TRUE)

fourgram<-tokenize(toLower(test), removePunct = TRUE, removeNumbers = TRUE, 
                   removeSymbols = TRUE, removeTwitter = TRUE, removeHyphens = TRUE, concatenator = " ",ngrams = 4)
fourgram<-dfm(fourgram, ignoredFeatures=c(stopwords(),"â","s","t"))
fourgram<-sort(colSums(fourgram),decreasing = TRUE)

unigram<-data.frame(names(unigram),unigram,stringsAsFactors = F)
bigram<-data.frame(names(bigram),bigram,stringsAsFactors = F)
trigram<-data.frame(names(trigram),trigram,stringsAsFactors = F)
fourgram <- data.frame(names(fourgram),fourgram,stringsAsFactors = F)

unigram <-unigram[unigram[,2]>1,]
bigram <-bigram[bigram[,2]>1,]
trigram <- trigram[trigram[,2]>1,]
fourgram<- fourgram[fourgram[,2]>1,]


#### Saving ngrams
saveRDS(unigram,"unigram.RDS")
saveRDS(bigram,"bigram.RDS")
saveRDS(trigram,"trigram.RDS")
saveRDS(fourgram,"fourgram.RDS")

#### Reading ngrams
unigram <- readRDS("unigram.RDS")
bigram <- readRDS("bigram.RDS")
trigram <- readRDS("trigram.RDS")
fourgram <- readRDS("fourgram.RDS")

unigramAllWords <- readRDS("unigramAllWords.RDS")
bigramAllWords <- readRDS("bigramAllWords.RDS")
trigramAllWords <- readRDS("trigramAllWords.RDS")
fourgramAllWords <- readRDS("fourgramAllWords.RDS")
