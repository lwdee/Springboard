# Book Recommendation Engine with Simple & Collaborative Filtering

## Introduction

A good book can transport you into another world or give you deep insight into the one around you. Hundreds of thousands of books are published in the US each year, more than any one person can read. With so many books available, how can you find one you’ll like (or better yet, love)? In my experience, the best recommendations come from people who know me well (friends) or people who know books well (professional booksellers). When there isn’t time to visit a local bookstore, book reviews can be found online. One of the largest platforms for the book-loving community is GoodReads.com. Members can keep track of what they’ve read, leave reviews and ratings, and make lists of books they want to read. In this project, I will explore GoodReads user’s ratings to examine trends and build several recommendation models to create a general or customized list of books for readers to enjoy.

## Table of Contents
* **Datasets**: CVS files of **Raw** and **Cleaned** data
* **Book_Recommender_Wrangling**: Jupyter Notebook of initial data exploration and cleaning steps.
* **Book_Recommender_EDA**: Jupyter Notebook containing Exploratory Data Analysis with visualizations and a summary of insights.
* **Simple_Recommender_with_Genres**: Jupyter Notebook containing a Simple Recommendation Engine which filters by book genre.
* **Book_Recommender_Collaborative**: Jupyter Notebook containing a Collaborative Filtering Recommendation Engine.
* **milestone_report**: Jupyter Notebook containing a summary of the project and EDA findings.
* **Capstone2_Book_Recommender_Final_Report**: PDF of the full project report.
* **Book_Recommender_Slide_Deck**: Presentation slides.   

## Executive Summary of Findings:
* The average rating per book is **4.00219**. 
* Most books in this dataset (~90%) have been rated between 10,000 and 100,000 times, with a **mean of 59,687 ratings per book**.
* Overall, the numerical metadata we have in this dataset (such as the date a book was published, number of ratings, or the number of editions) doesn't tell us much about how highly it will be rated. This implies there are other factors, such as the quality of writting, that have more impact on ratings.
* Of the numeric variables, the presence of 2-star ratings (even more than the presence of 1-star ratings) seem to be an indicator that a book will have a lower overall rating.
* **Young adult series are popular** -- think The Hunger Games, Harry Potter, Twilight, Divergent, and the Hobbit. Specifically, the first book in this type of series receive the most ratings. 
* The first book of the **Twilight** series was rated by nearly 400,000 GoodReads users. It's the 3rd most rated book on this dataset. However, you have to go all the way down the list to the 46th most rated book ("Eat, Pray, Love") before find one that's rated lower than Twilight's 3.57 average. This prompts the question, why have so many people read it if it wasn't liked by the majority of them?
* **Calvin and Hobbes** and **Harry Potter** top the charts for most beloved books.
* Looking at books with a high variance in ratings, it isn't surprising to find that **religion and sexuality are controversial subjects.** The list of the top 15 books we don't agree on include **Fifty Shades of Grey, Twilight, The Book of Mormon, The Qur'an,** and **The Holy Bible.** 
* **When ratings were averaged per user, only 20% of users had an average less than 3.5 stars.** This could suggest a couple things: Goodreads users like reading and have a positive bias towards books in general; or people are more likely to take the time to rate something they like.
* **80% of users only vary their ratings by 1 point.** For example, a user might always give books 4-star or 5-star ratings. Another might only give out 1-star ratings. 
* Some people only give out 5-star ratings, some only give 1-star ratings, but **no user in this data set gave only 2-star ratings.**
* The top 3 most used tags are "to-read", "favorites", and "owned".
* The most popular genres by volume are **Fantasy, Romance, Mystery and Young Adult**, each were tagged on 3,600-4,300 books (recall that there are 10,000 books total in the dataset).
* Genres that have a positive correlation with book ratings are: 'childrens' 'christian' 'fantasy' 'graphic-novels' 'paranormal'. On the other end, 'chick-lit' and 'novels' tend to receive lower ratings.

## Book Recommender Systems:

* **Simple recommender by genre:** Keyword-based book recommender module to filter by genre. A list of common and representative genres was compiled. Based on how frequently each was tagged, a genre percentage was calculated for each book (ex. 0.6 fantasy, 0.4 mystery).  For the recommender, the books are filtered by genre first, then ranked by its weighted average rating which takes into account the overall popularity. The top-k books from the list are returned as the top-k recommendations.
* **Collaborative filtering recommender:** With user x books rating matrix, a collaborative filtering recommender module was built. The dataset has a total of 53,424 users, 10,000 books, and 5,976,479 ratings. In terms of the user x book matrix, the matrix is very sparse (1.12% non-empty). Therefore, matrix factorization using ALS (alternative least square) will be used to complete the matrix and generate recommendations.

## Links to Code
Exploratory Data Analysis: https://github.com/lwdee/Springboard/blob/master/Book_Recommendations/Book_Recommender_EDA.ipynb  

Collaborative filtering recommender: https://github.com/lwdee/Springboard/blob/master/Book_Recommendations/Book_Recommender_Collaborative.ipynb  
Additional, temporary link: https://www.dropbox.com/s/ncsbyty4omopaga/Book_Recommender_Collaborative.ipynb%20copy?dl=0

Simple Recommender by Genre: https://github.com/lwdee/Springboard/blob/master/Book_Recommendations/Simple_Recommender_with_Genres.ipynb  


## Acknowledgements:

The data used for this project originally comes from the GoodReads.com website. It was collected and made available by Zygmunt Zając on GitHub (https://github.com/zygmuntz/goodbooks-10k).

Many thanks go to the excellent staff and curriculum at Springboard, especially to my mentor Max Sop.
