![logo_ironhack_blue 7](https://user-images.githubusercontent.com/23629340/40541063-a07a0a8a-601a-11e8-91b5-2f13e4e6b441.png)

# Lab | Statistics Foundations
In this lab we are going to put into practice what we learned about the foundations of statistics. You won't need to use Python, just your brain and a little bit of *Markdown*. Hovewer, you will need SQL for the Part 3.

## Your task
Today you'll need to complete the challenges described below.

## Deliverables
You need to submit a markdown file with the solution to the following challenges. You can create a new *.md* file or directly edit the *README.md* to include your solutions.
This file should also include the SQL script for the Part 3.

## Challenges
## Part 1
### Challenge 1
Find a and b, if median=42, mean=50 for [20, 34, 34, 12, 56, 110, 49, a, b].

(1) mean = 50 => (20 + 34 + 34 + 12 + 56 + 110 + 49 + a + b) / 9 = 50.  
(1) mean = 50 => a + b = 450 - 315.  
(1) mean = 50 => a = 135 - b. 

(2) median = 42 => (a or b) = 42 (odd number of datapoints)

**>> a = 93 and b = 42 (or a = 42 and b = 93)**


### Challenge 2
A car hit an average speed of v1 = 60 kmph in the first half of the journey, and hit an average speed of v2 = 110 kmph in the second half of the journey. Determine the average speed of the car.

(1) v_avg = (v1 * d1 + v2 * d2) / (d1 + d2)

(2) d1 = d2

(1) and (2) => v_avg = (v1 + v2) / 2

**>> v_avg = 85 kmph**

### Challenge 3
The lifetimes of 400 light-bulbs were found to the nearest hour. The results were recorded as
follows.

Lifetime (hours)

0–199 200–399 400–599 600–799 800–999 1000–1199 1200–1999

Frequency

143     97      64      51      14      14        17

Construct a histogram and cumulative frequency polygon for this dataset. Estimate the percentage
of bulbs with lifetime less than 480 hours.

est = (143 + 97 + 64 * (480 - 400) / (599 - 400) ) / 400.  
est = (240 + 64 * 0.4) / 400. 

**>> est = 66.4%**


### Challenge 4
The time between arrival of 60 patients at an intensive care unit were recorded to the nearest hour.
The data are shown below.

Time (hours)
 
0–19 20–39 40–59 60–79 80–99 100–119 120–139 140–159 160–179

Frequency

16    13    17    4     4      3       1      1       1

Determine the median, mean and standard deviation for this dataset.

Median.  
Class in which the median falls: 40-59.  
median = 40 + ((60 / 2) - (16 + 13)) / 17 * 20.  
**>> median = 41.2**  

Mean.  
(Sum of (mid-points multiplied by frequencies)) divided by total nb of values.  
Mean = (9.5 * 16 + 29.5 * 13 + ... + 169.5 * 1) / 60

**>> mean = 46.5**  

Standard deviation.  
Square root of variance where  
var = sum(n(i) * (m(i) - mean) ^ 2) / (N-1)  

Here var = (16 * (9.5 - 46.5) ^ 2 + ... + 1 * (169.5 - 46.5) ^ 2) / (60 - 1)

**>> standard deviation = 36.8**

## Part 2
### Challenge 1
One player rolls two dices. Describe the measurable space and the random variable for:  
* A. The values that the player obtains:  
**X = (value of first dice, value of second dice)  
Measure space: {(i,j) for i in [1-6] and j in [1-6]}**.  
* B. The sum of the values obtained:  
**Y = value of first dice + value of second dice  
Measurable space: {2, ..., 12}**  
* C. The maximum value obtained after rolling both dices:  
**Z = max(value of first dice, value of second dice)  
Measurable space: {1, ..., 6}**

Describe the following events:  
* Case A: Both values are greater than 5:  
**X in {(5,5), (5,6), (6,5), (6,6)}**  
* Case B: The sum of values is even:  
**Y in {2, 4, 6, 8, 10, 12}**  
* Case C: The maximum is the value of both rolls:  
**X in {(i,i) for i in [1-6]}**  

### Challenge 2
One player picks two cards from a poker deck. Describe the measurable space and the random variable for:  
* A. The number of figures he picks:  
**X = Nb Kings + Nb Queens + Nb Jacks   
Measurable space = {0,1,2}**  
* B. The sum of card values. Consider that the value of figures is 10 and the value of aces is 15:  
**Y = value of first card + value of second card  
Measurable space = {4, ..., 25, 30}**  
* C. The number of hearts or spades he picks:  
**Z = Nb Hearts + Nb Spades   
Measurable space = {0,1,2}**  

Describe the following events:  
* Case A: The number of figures in the cards the player picked is two:  
**X in {2}**  
* Case B: The sum of card values is 17:  
**Y in {17}**  
* Case C: The value of both cards is less than 8:  
**X in {0} & Y in {4, 14}**

### Challenge 3
Two players roll a dice. Describe the measurable space and the random variable for:  
* A. The score of player A.  
**X(A) = value of player A's dice  
Measurable space = {1, ..., 6}**  
* B. The greatest score.  
**Y = max(X(A), X(B))  
Measurable space = {1, ..., 6}**  
* C. The earnings of player A if the game rules state that:  
"The player with the greatest score gets a coin from the other player.".  
**Z(A) = (Y = X(A)) * 1  + (Y = X(B)) * 1
Measurable space = {-1, 0, 1}**  
* D. The earnings of player A if the game rules state that:  
"The player with the greatest score gets as many coins as the difference between the score of player A and player B.".   
**ZZ(A) = (Y = X(A)) * (Y - (X(B)) + (Y = X(B)) * (Y - (X(A))  
Measurable space = {-5, ..., 0, ..., 5}**    

Describe the following events:  
* Case A: The score of player A is 2.  
**X(A) in {2}**  
* Case B: The greatest score is lower or equal than 2.  
**Y in {1, 2}**  
* Case C: Considering the case where the winner gets as many coins as the difference between scores (D), describe:   
  * Player A wins at least 4 coins.  
  **ZZ(A) in {4, 5}**  
  * Player A loses more than 2 coins.  
  **ZZ(A) in {-5, -4, -3}**  
  * Player A neither wins nor loses coins.  
  **ZZ(A) in {0}**    

## Bonus challenges
### Bonus Challenge 1
Three players take balls from a box. Inside that box there are red, blue, green and black balls. The players can take three balls at mosts with the following rules:

* If the ball is blue, they can take another ball.
* If the ball is green, they get one point and they can take another ball.
* If the ball is red, they can’t take another ball.
* If the ball is black, they lose one point and they can’t take another ball.

Describe the measurable space and the random variable for:
* A. Player A wins. Do not consider ties as a win.
* B. Player A and B get the same points.
* C. All players get 0 points.

### Bonus Challenge 2
Consider the situation of bonus challenge 1 but now with four players. Does anything change in your solutions? What are the changes in each case?

### Bonus Challenge 3
One player takes three balls from a box. Inside the box there are 5 balls: two of them are black and the other three are white. 

Describe the measurable space and the random variable for:
* A. The number of white balls if every time we take a ball we keep it.
* B. The number of white balls if every time we take a ball we put it back again into the box.
* C. The number of black balls if every time we take a ball we keep it.
* D. The number of black balls if every time we take a ball we put it back into the box.

| Attempt | #1 | #2 |
| :---: | :---: | :---: |
| Seconds | 301 | 283 |

## Part 3
### Challenge 1

| #student_id | #score |
| :---------: | :----: |
| 1 | 91 |
| 2 | 72 |
| 3 | 98 |
| 4 | 62 |
| 5 | 62 |
| 6 | 95 |
| 7 | 83 |
| 8 | 86 |
| 9 | 56 |
|10 | 97 |
|11 | 58 |
|12 | 71 |
|13 | 87 |
|14 | 83 |
|15 | 98 |


Please find MEAN, SUM, STANDARD DEVIATION, VARIANCE, MIN and MAX.

We assume that the table is called scores and we rounded the below results to 2 decimal digits.

MEAN.  
**SELECT AVG(score) FROM scores; => 79.93**

SUM.  
**SELECT SUM(score) FROM scores; => 1199**

STANDARD DEVIATION.  
**SELECT STD(score) FROM scores; => 14.69**

VARIANCE.  
**SELECT SUM(score) FROM scores; => 215.93**

MIN.  
**SELECT VARIANCE(score) FROM scores; => 56**

MAX.  
**SELECT MAX(score) FROM scores; => 98**


