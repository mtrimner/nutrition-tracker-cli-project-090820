# NutritionDataLookUp

Welcome to this Nutrition Data Lookup program. This project was developed as our for Flatiron School software engineering bootcamp. It allows users to search for foods using natural language. It will then produce an autofilled list of common foods, brand name foods, and restaurant items. This is done using the Nutritionix API through the CLI.

# Installation

Clone this repo to your local computer.

You can see an easy step, by step, tutorial here: https://www.earthdatascience.org/workshops/intro-version-control-git/basic-git-commands/

Then, install the following gems:

```
gem install pry
```
```
gem install json
```

# How To Run The Program

After you have cloned and opened the repo on our computer, enter ```ruby bin/run.rb``` in your terminal.

You will see a prompt to search for a food. 

You can be as specific or board as you want. Whether you type "chicken" or "I ate a Big Mac from McDonalds", the program should find what you are looking for. 

Two lists will appear. One for common foods and one for branded products and restaurant items.

The Common Foods list works best for generic items like chicken, steak, pork, etc.

The Branded Foods list works best if you ate a specific product or had a meal at a well known restaurant.

Once you select a number corresponding with the food you wanted, you will see a breakdown of the calories, carbs, total fat, and protein per serving. 