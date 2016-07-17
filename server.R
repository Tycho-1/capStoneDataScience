library(quanteda)
library(tm)

find_phrase <- function(ngram,phrase){
    ngram[grepl(paste0("^",phrase), ngram[,1]),]
}

take_words<-function(sentence,n){
    sentence_t <-tokenize(as.character(sentence),removePunct = TRUE)
    l<-length(sentence_t[[1]])
    if (l<n) {n=l}
    phrase<- sentence_t[[1]][(l-n+1):l]
    if (n == 5) { phrase = paste(phrase[1],phrase[2],phrase[3],phrase[4],phrase[5])}
    if (n == 4) { phrase = paste(phrase[1],phrase[2],phrase[3],phrase[4])}
    if (n == 3) { phrase = paste(phrase[1],phrase[2],phrase[3])}
    if (n == 2) { phrase = paste(phrase[1],phrase[2])}
    phrase
}

find_suggestion <-function(ngram,phrase){
    ngram[grepl(paste0("^",phrase," "), ngram[,1]),]
}

take_lastWord <- function(phrase){
    listWords<-take_words(phrase,1)
}

final_suggestion <- function(suggestion,m){
    if (nrow(suggestion)<m) { m <- nrow(suggestion)}
    temp<- data.frame(rep(0,m)) 
    names(temp) <- c("suggestion")
    for (i in seq(m)){ temp[i,1] <-take_lastWord(suggestion[i,1]) }
    temp
}

clean_sentence <- function(sentence){
    sentence <- Corpus(VectorSource(sentence))
    sentence <- tm_map(sentence,removeWords,stopwords("english"))
    funs <- list(stripWhitespace,
                 removePunctuation,
                 removeNumbers,
                 content_transformer(tolower))
    sentence <- tm_map(sentence, FUN = tm_reduce, tmFuns = funs)
    sentence[[1]][1]
}

final_find <- function(sentence,uniram,bigram,trigram,fourgram,nr){    
    phrase <- tokenize(take_words(sentence,3))[[1]]
    len <- length(tokenize(take_words(sentence,3))[[1]])
    if ((len == 3) & is.na(phrase)[1] == FALSE) {
        phrase <- take_words(sentence,3)
        suggestion <- find_suggestion(fourgram,phrase)
        if (nrow(suggestion) >0){ result <- final_suggestion(suggestion,nr) }
        else {
            phrase <- take_words(sentence,2)
            suggestion <- find_suggestion(trigram,phrase)
            if (nrow(suggestion) > 0) { result <- final_suggestion(suggestion,nr) }
            else {
                phrase <- take_words(sentence,1)
                suggestion <- find_suggestion(bigram,phrase)
                if (nrow(suggestion) > 0) { result <- final_suggestion(suggestion,nr) }
                else {
                    suggestion <- unigram[,1][1:15]
                    suggestion <- as.data.frame(suggestion)
                    result <- final_suggestion(suggestion,nr)
                    sorry_message <- as.data.frame(rbind(c("Sorry, no matches in ngrams!"),
                                                         c("Unigram prediction:")))
                    names(sorry_message)<- "suggestion"
                    result <- rbind(sorry_message,result)
                }
            }
        }
    }
    
    if ((len == 2) & is.na(phrase)[1] == FALSE){
        phrase <- take_words(sentence,2)
        suggestion <- find_suggestion(trigram,phrase)
        if (nrow(suggestion) > 0) { result <- final_suggestion(suggestion,nr) }
        else {
            phrase <- take_words(sentence,1)
            suggestion <- find_suggestion(bigram,phrase)
            if (nrow(suggestion) > 0) { result <- final_suggestion(suggestion,nr) }
            else {
                suggestion <- unigram[,1][1:15]
                suggestion <- as.data.frame(suggestion)
                result <- final_suggestion(suggestion,nr)
                sorry_message <- as.data.frame(rbind(c("Sorry, no matches in ngrams!"),
                                                     c("Unigram prediction:")))
                names(sorry_message)<- "suggestion"
                result <- rbind(sorry_message,result)
            }
        }
    }
    
    if ((len == 1) & is.na(phrase)[1] == FALSE){
        phrase <- take_words(sentence,1)
        suggestion <- find_suggestion(bigram,phrase)
        if (nrow(suggestion) > 0) { result <- final_suggestion(suggestion,nr) }
        else {
            suggestion <- unigram[1:15,1]
            suggestion <- as.data.frame(suggestion)
            result <- final_suggestion(suggestion,nr)
            sorry_message <- as.data.frame(rbind(c("Sorry, no matches in ngrams!"),
                                                 c("Unigram prediction:")))
            names(sorry_message)<- "suggestion"
            result <- rbind(sorry_message,result)
        }
     }
    
    if ((len == 1) & is.na(phrase)[1] == TRUE){
        suggestion <- c("Please enter a text!")  
        suggestion <- as.data.frame(suggestion)
        result <- suggestion
    }
    result
}

#########
unigram <- readRDS("unigram.RDS")
bigram <- readRDS("bigram.RDS")
trigram <- readRDS("trigram.RDS")
fourgram <- readRDS("fourgram.RDS")
######
unigramAllWords <- readRDS("unigramAllWords.RDS")
bigramAllWords <- readRDS("bigramAllWords.RDS")
trigramAllWords <- readRDS("trigramAllWords.RDS")
fourgramAllWords <- readRDS("fourgramAllWords.RDS")
#########

shinyServer(function(input, output) {

    output$value <- renderPrint({ 
    nr <- input$number
    sentence <- tolower(input$text)  
    if (input$radio == 1){
        final_find(sentence,unigramAllWords,bigramAllWords,trigramAllWords,fourgramAllWords,nr)}
    else if (input$radio == 2){
        sentence <- clean_sentence(input$text)  
        final_find(sentence,uniram,bigram,trigram,fourgram,nr) }
        
    
    #     nr_suggestion <- input$numberSuggestion
#     if (is.na(nr_suggestion)==TRUE ){
#     result <- final_find(sentence)
#     result}
#     else {sentence <- paste(sentence, result[nr_suggestion,1])
#     result <- final_find(sentence)
#     result}
    #nr_suggestion
    
  
    })  
    
})