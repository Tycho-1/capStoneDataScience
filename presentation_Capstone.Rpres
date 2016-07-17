Presentation for the Capstone Project in Data Science 
========================================================
author: Using natural language processing for predicting next word in a phrase or a sentence
date: 17 July 2016

An overview and basic idea
========================================================

The goal of this app is to synthesize the information of a database of sample texts (i.e. messages from Twitter, from blog posts, and news posts), and come with a suggestion for the next suitable word a user could type in. Some limitation could be pointed out:

- The accuracy of the prediction is text sensitive. The more the text is like the training sets of data the better the suggestion.
- Issues about the size of the files should be addressed and a suitable trade-off found. E.g. discarding less frequent ngrams in order to improve speed.
- Important to find a method for predicting unseen combination of words, though this author could not have the time to do that

Describing the data and how it is used
=======================================================
The data used for this app is supplied by SwiftKey and could be found here: [Dataset SwiftKey](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip) . It consists of three different sources of data, in order to have different variety of word combinations. Some 'cleaning' and adjusting of the data has been performed, i.e.
- Removing punctuation, numbers, symbols, hyphens, Twitter signs, and the so called 'stopwords'.
- A sample of 50000 lines of each of the three datasets has been taken. Otherwise the data is too large for building an app.
- Then the data is aggregated into unigrams, bigrams, trigrams and fourgrams. These bags of words are then sorted by their frequencies, in order to determine which are the most important combinations of phrases.



The algorithm suggesting the next word
========================================================
The basic idea is the Markov Assumption. It states that the next word is mostly determined by the previous one, two or three(or more) words, instead of the whole sentence. So this app simply looks for matches, first in the fourgrams, if it does not find any looks at trigrams, and so on until unigram, at which point the prediction is poor. 
- Again, a curtailing of the ngrams has been performed (to the arbitrary number of 50000 for each gram). 
- Using higher number of ngrams significantly slows the app
- It is beneficial as well, since the rarely seen ngrams are less likely to be used
- A significant drawback of the app is the lack of implementation of guessing algorithm for unseen ngrams


The app and more
========================================================
The app could be found in this [link](https://tycho.shinyapps.io/CapstoneProject/) . Some special features:
- Gives the user the choice to use a dataset with or without 'stopwords'. Shows the differencies between including and excluding the those words.
- Gives the user the choice of how many suggestions to display

The code for the app could be fund [here](https://github.com/Tycho-1/capStoneDataScience).

Some useful links to the **absolutely amazing** materials of 

[the website of prof. Dan Jurafsky](http://web.stanford.edu/~jurafsky/)

Specifically the slides of the course Natural Language Processing could be found [here](http://web.stanford.edu/~jurafsky/NLPCourseraSlides.html).
