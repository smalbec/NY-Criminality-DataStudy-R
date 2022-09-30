

**<span style="text-decoration:underline;">Education: Ramifications on criminality and development observed in New York State</span>**

This project will focus on New York State School Aid, where we will study every county’s educational government subsidy and then refer to its criminal and development rates.

 	

This will be of great interest to New York’s administration as proof for schooling’s importance, as we will try to find a correlation between these factors to see if increasing education finances leads to more prosperous communities.

Our data sources will be provided by the state located in [Open Data NY](https://data.ny.gov/), where we will investigate, extract, model and analyze different data sets, such as:  [New York State School Aid](https://data.ny.gov/Government-Finance/New-York-State-School-Aid-Beginning-School-Year-19/9pb8-dg53/data), [Lottery Aid to Education](https://data.ny.gov/Government-Finance/Lottery-Aid-to-Education-Beginning-2002/9ypc-vjiq/data), [Annual Population Estimates](https://data.ny.gov/Government-Finance/Annual-Population-Estimates-for-New-York-State-and/krt9-ym2k), [Jail Population](https://data.ny.gov/Public-Safety/Jail-Population-By-County-Beginning-1997/nymx-kgkndata), [Average Income](https://data.ny.gov/Government-Finance/Average-Income-and-Tax-Liability-of-Full-Year-Resi/2w9v-ejxd/data) and others. Each dataset has been chosen by their feature of being divided by county, allowing us to select and inspect different areas.

Some of the questions we are trying to answer are: Do counties that receive larger  education budgets also have lesser illicit rates and do all counties get their own fair amount of budget? These questions will be under the presumptions that the rates and aids will be analyzed by its population number and adjusted per capita.

**<span style="text-decoration:underline;">Procedures</span>**

**<span style="text-decoration:underline;">Defining the problem and collecting the data</span>**

We first started this project by researching and identifying something that data could solve, for me, I’ve always wondered about the effects of education on criminality rates. Browsing NY Open Data datasets, we could find the amount of Education Aid each county received annually, while also having multiple other datasets that recorded criminality rates such as crimes reported and jail population. We also added the estimated population of each county for expanding our answering capabilities. We then downloaded and grouped the data.

**<span style="text-decoration:underline;">Data cleaning and preprocessing</span>**

As the data we got was not standardized between each other and had other factors that made them incompatible, we had to clean and normalize it. We removed all N/A values, dropped irrelevant columns, standardized the years by restricting them to 2010-2019 overall standardized all the data so they could be joined together. We also created another dataset that summarized each year into a mean of each features plus a PerCapita measure for Education Aid and Crimes

**<span style="text-decoration:underline;">Exploratory data analysis</span>**

Now that we had the dataset fully cleaned and how we wanted it to be, we started exploring it, like searching for a summary to describe our data, graphing the average of education aid of each county, creating a scatter plot between the aid amount and crimes reported to find a correlation, further looking into it by using a joint plot. We also looked into the trend of criminality through the crimes reported and the jail population and was satisfied to find that it decreased steadily over the year.

**<span style="text-decoration:underline;">Modeling and analysis</span>**

Now that we had a better understanding of our data, we could start exploring it further and try to answer the questions from the start.  We divided the data into train dataset (contains 75% of data) and test dataset (contains 25% of data) and then used the test data to evaluate the outcomes.

We started with the first model, _Logistic Regression Algorithm_, we wanted to see if we could predict what counties would be classified as high crime areas through their statistics about Education Aid. To evaluate the model we used the Receiver Operating Characteristic. 

Once we used the train dataset, the first evaluation of accuracy was not good, at a mediocre 0.57 it tells us that it can barely predict correctly new values through its test set. A good model will have a high AUC, that is as often as possible a high sensitivity and specificity.,and our score of 0.56 is not satisfactory either. We concluded that the model did not fit the data well.

The second model _K Nearest Neighbour algorithm_ , I was more hopeful for due to being very simple and lazy learning that does not assume anything about the underlying data . We first had to normalize the data and to evaluate the model we used accuracy and p-value which tells us about the ‘total probability’ of getting any value to the, when the values are picked randomly from the distribution. 

The algorithm seemed able to somewhat accurately predict high crime areas, having a 77.7 accuracy score, but it was very volatile, depending on certain variables like the set.seed, training/test split and the k (which is the amount of data points that are collected before they are measured against the rest of the data).  

The data model was not very reliable but in certain instances it will work together with the data to predict new values, but the p-value of 0.3 says that it is not statistically significant since its very far from the ideal 0.05.

Finally our last hope was a Linear Discriminant Analysis, it directly gets the probability of an observation for a class (Y=k) for a particular observation (X=x), the LDA algorithm is based on Bayes theorem. It assumes the groups in question have equal covariance which we believed does exist through our EDA. 

This model was evaluated by a confusion matrix. The model ended up performing better than the logistic regression at a 0.59 accuracy score, but not by much and it was weaker than the nearest neighbors.

**<span style="text-decoration:underline;">Building a data product</span>**

Now that we had  models, we kept moving forward and created a data product through R Shiny where it graphed some of our models plots, here you can interact with it by changing either the data set split ratio and see how it affects the prediction or you could change the K neighbors and see how it affects the accuracy of KNN. 

We published it through R own platform called ShinyApps.io a very useful tool that I recommend to anyone. Here are the link to the websites 



* [Website 1](https://smalbec.shinyapps.io/knnn/) 
* [Website 2](https://smalbec.shinyapps.io/logreg/)

**<span style="text-decoration:underline;">Block Diagram</span>**

**<span style="text-decoration:underline;">Outcome</span>**

Once we started modelling the data we realized that our dataset might’ve been too small for the type of analysis we were trying to do. Out of all of the 5 models we tried on our data none of them gave satisfactory results, this could be due to multiple factors but the one we believe might be the main one is the lack of data, at only 56 observations of each New York state county it is not possible to accurately predict new values. These models are data-hungry, and their performance relies heavily on the size of training data available. 

Once a few decades have passed and the data’s been updated accordingly we could start trying to use machine learning to predict new values. Overall I’m satisfied with the work done as it has taught me a great deal on data, from its acquisition to providing a product that shows it in a modified but more useful way.

**<span style="text-decoration:underline;">R Code</span>**

If in the future someone tries to do the same as I did but with better data, here are the instructions to run it.

First you’ll have to download the data from its source, in the data folder there is a README file that shows the links to the datasets, they should be the same as they are updated into the future.

Once you have that, create an R project using the folder as the directory, open processing.r and here you can add/remove/alter your future cleaned dataset as you like, for example if you don't want to restrict the years from 2010-2019 you should do this here. When you run the code it will normalize it and then store it into the processedData folder

Now we can start exploring the data, run the EDA file and there you can see the summaries, plots and graphs that we discussed earlier, you can explore on your own with different parameters or observations.

Next is the modelling phase, you can just run the models file and it will generate the accuracy, confusion matrix, p-values and plots or graphs depending on the models, you can also create your own models or change the values such as K neighbors in KNN to see how it affects the model evaluations.

Finally, to create a data product we used 2 different projects as it makes it easier to use Shiny. You can open each individual project and run the app from the server or UI code, this will create a local website where you can see and interact with some variables from the model. Alternatively you can just go to the websites



* [Website 1](https://smalbec.shinyapps.io/knnn/) 
* [Website 2](https://smalbec.shinyapps.io/logreg/)

Website 1 is the representation of the **<span style="text-decoration:underline;">K Nearest Neighbour algorithm, </span>**where you can interact with the number of k neighbors that are gathered before they are measured against the data, from this you can see how the amount of data points collected affects the model in its accuracy. You should be able to use other datasets as long as you clean it and format it like we did in previous steps

Website 2 is the representation of the logistic Regression Algorithm model**, **where you can interact with the ratio between the train and test datasets, from this you can see how splitting the dataset affects the model in its accuracy and Receiver Operating Characteristic. You should be able to use other datasets as long as you clean it and format it like we did in previous steps.

**<span style="text-decoration:underline;">Troubleshooting the project</span>**

This project presented a lot of challenges as we moved phase to phase, at first it was hard to decide on what topic should I focus on, since there is so much data out there and so many questions it could answer, but it was quickly decided once I started browsing NY Open Datasets. Cleaning the data had some problems, due to the differences between the datasets and being new to R, a lot of syntax had to be learned but I managed to normalize everything.

Once I knew how R worked somewhat, EDA was a lot easier since I knew what I was doing. 

The biggest hurdle in the project came from the modelling, no matter what I tried, models either gave terrible measurements or straight up didn't work, I also didn't know what I was supposed to be modelling, I was stumped for weeks but thanks to Prof Bina and the TA’s I was able to somewhat model my data to a point I was satisfied with the results even if they didnt work that well. The data products seemed a lot easier after going through the modelling phase so I didn’t have many problems there, shiny.io streamlined everything. 

I had to learn a lot to make this project work and I made a lot of mistakes along the way, but I managed to solve everything and ended with a product I’m proud of.

Sources and References:

[Census 2000 and 2010 Population, Towns | State of New York](https://data.ny.gov/Government-Finance/Census-2000-and-2010-Population-Towns/fqf5-9nc2/data)

[Annual Population Estimates for New York State and Counties: Beginning 1970 | State of New York](https://data.ny.gov/Government-Finance/Annual-Population-Estimates-for-New-York-State-and/krt9-ym2k)

[Jail Population By County: Beginning 1997 | State of New York](https://data.ny.gov/Public-Safety/Jail-Population-By-County-Beginning-1997/nymx-kgkn/data)

[Index Crimes by County and Agency: Beginning 1990 | State of New York](https://data.ny.gov/Public-Safety/Index-Crimes-by-County-and-Agency-Beginning-1990/ca8h-8gjq/data)

[Adult Arrests 18 and Older by County: Beginning 1970 | State of New York](https://data.ny.gov/Public-Safety/Adult-Arrests-18-and-Older-by-County-Beginning-197/rikd-mt35)

[New York State School Aid: Beginning School Year 1996-97 | State of New York](https://data.ny.gov/Government-Finance/New-York-State-School-Aid-Beginning-School-Year-19/9pb8-dg53/data)

[New York State School Aid: Two Perspectives - schoolaid2016.pdf](https://www.osc.state.ny.us/files/local-government/publications/pdf/schoolaid2016.pdf)
