# NERD'S PARADISE


## Statement of Purpose and Scope

The purpose of nerd's paradise is to solves the problem of keeping track of all the games inside a user’s video game collection. 

The reason why I'm developing this application, is because as a game collector myself, I have a large game collection and keeping track of all of them can be frustrating, especially if I've already played them. This application will fix that by giving the user the ability to store their game collection into a local database where they can retrieve or modify the data.

The application achieves this by storing data into an instances using ruby classes then storing them into a global array. The data can be manipulated from the global array by accessing the with methods. The data is stored into a csv when the user exits the program. When the user re-opens the application, the program will retrieve that data from the the local csv.

One major issue was storing the data into a local csv file. If the csv file is deleted or moved to a different location, the application can't retrieve the data and will instead create a new file inside the local drive. There is a begin and rescue on this to avoid the application from crashing if the file was to be deleted or moved. However, users would lose their database if this was to occur. At the current version, there hasn't been a fix to solve this issue. However, it’s possible that future updates to the application will solve this.

The local database is a csv file that is located within the same file as the files.


### Target Audience
Nerd's paradise is designed for video gamers collectors of videos. 

The audience interacts with the application through menus. The menu is easy to follow and the user can do what they want to achieve by selecting the relevant menu item.

## Features

### Select a game to play 

Randomly selects a video game with an incompleted status in their database and returns the game name for the user to pick and play.

This feature utilises a conditional structure to determine if a game in the global array has an incomplete status. It then gets stored into a local array inside the method where a sample method selects a random game at random and prints the name on to the terminal. 

A possible error that could occur is when there are no games with a incomplete status or when there are no games in the database. To handle this error, a method is called to print a message to the user when there is no games in the database or if there all the games are completed.

### Add game

Allows user to enter the details of their video game to be saved into the database.

This feature utilises inputs from the user using tty-prompt gem. Their inputs are stored into a local variable which will be used to store an instance. The initialize method in the class is called and uses the local variables as arguments to store the instance. The instance is then pushed into a global array where the data can be manipulated.

Additionally, if the user enters a game into the database that already exists, a conditional statement runs and exits the add game feature back to main menu. It also prompts the user that the game already exists in their database.

An error that was handled was if the user enters something that could not be accepted by the the instance (e.g. boolean values for completed). This accomplished by creating select menus using tty-prompt, giving users options choose from rather than entering their own, except for the game title.


### Search games

Presents various options for the user to search their database, including the ability to view all their games, or search based on specific criteria. 

The search feature uses conditional statements and methods to retrieve the game from the database. 

The first item in the sub menu is list all games, which iterates through the global array, stores the data into local array and then printed into a readable format using the terminal table gem. 

The second item in the sub menu is search by attribute. This was achieved by iterating through the global array, and returning a list of the games title into a local array. A prompt menu allows the user to select the game they want to edit and then returns the index of the chosen game in the global array. Finally, the user selects the attribute they want to edit, which replaces the attribute of the matched index. 

One error that occurred was if there was no matching results which caused the application to break. This was handled by by implementing a method that contained a conditional statement that determined if no results were found, returned a message to the user and looped them back to the main menu.

### Edit game

Allows the user to select a game to edit the attribute of the game, which will update in the database. 

This feature is similar to the searched game feature, which utilised a similar method of iterations, and loops to return all the games from the database for the user to choose and edit. To allow the user to make edits to the database, local variables were used to store user inputs on attributes that the user wanted. This also used indexes in the global array to ensure the right data was changed.

The possible error that could have occurred was if the user entered an argument that was not correct (e.g. entering a string when it should be a boolean). To handle this, the options were set out in a predetermined menu that allowed a user to select the option rather than having them manually enter it.


### Delete game 

Gives the ability for the user to delete a stored game in the database.

This feature used similar iterations, and conditional statements to determine the game the user wanted to delete. It stores all games into a local array where the user can select the game they want to delete. This returns an index of where the game sits in the global array and deletes that index. 

In order to avoid the user from trying to search for a game that may not exist in the database, a method was used, where the title of the games were retrieved and presented in a menu where the user selects the game they want to delete.

## Dependencies

The Ruby gems 'tty-prompt', 'tty-spinner', 'terminal-table', 'colorize' and 'tty-font' ' are required to run Nerd's paradise

Minimum system requirements: Mac, Windows or Linux

## Instruction for install

Download source code and save to preferred directory

In terminal, install the pre-required dependencies with the following code:
````
$ bash build.sh
````

To initialise program:
````
$ ruby app.rb
````
From the main menu, make a section:

![main menu](assets/chris-tri-T1A2-4-main-menu.jpg)

## Task Management

Priorities and tasks were managed using a trello board. It allowed me to itemise, breakdown tasks to be systematically completed to meet minimum viable product. 

![trello board screenshot](assets/chris-tri-T1A2-14-project-mgnt-program.jpg)

## Flow Chart

Below is a flowchart detailing the processes and its related control flows.

![control flow chart](assets/chris-tri-T1A2-5-control-flow-diagram.jpeg)


## User Interaction and Experience

Once the user installs the required dependencies, they can run the application using the following in terminal:

Firstly,they will go to the dist folder using the following command in terminal where the application is located:
````
cd dist
````
To run the application, in your terminal, type:
````
$ ruby app.rb
````
The main menu should appear.

![main menu](assets/chris-tri-T1A2-4-main-menu.jpg)

## Using the application

The user can move up and down the available options in the menu using the up/down arrow keys. To select the option, press enter.

### 1 - Select a game to play
This option prints a random game that has a status incomplete to terminal for the user to pick and play.

To handle the error where there is no games in the database or all games are marked completed, it prints a message to the user notifying them of that issue. 

### 2 - Adding a game
This option allows the user to enter a new game into the database. 
1. Select the 'Add game' option

2. The user will recieve a prompt asking to confirm they want to add a game.

3. Enter the name of your game.

3. Genre, Platform and Completion Status have similar menu layouts. This will be a menu that can be navigated using the up/down arrow keys. Select using the Enter key.

To ensure that errors relating to entering data, the program presents the user with pre-determined options, hence avoiding the possibility that the user enters data that could break the application.

### 3 - Search games
This option will allows the user to search and return the list of games using a selected criteria.

![search menu](assets/chris-tri-T1A2-4-searched-menu.JPG)

1. To display all games in the database, select the 'list all games'. Games will print onto the terminal. 

2. If the user want to search for specfic games in your database or list by attributes, select they can use the 'search by attribute' feature.

They'll be presented with the following options: 

![search attribute menu](assets/chris-tri-T1A2-4-search-by-attribute.JPG)

If you choose to search by Title, they'll be presented with a screen where they'll need to enter the name of the game you're looking for. 

The other options in the search by attribute menu is guided by prompts. Use the up/down arrow keys to navigate and the enter key to select the option.

If the game exists in the in the database, it will print to your screen. If the game(s) doesn't exist in your database it will return 'no results found!'

### 4 - Edit game
This option allows you edit an attribute of your game in the database. 

1. Select a game the user want to edit. 
2. Select the attribute the user wants to edit.
3. They'll be prompted to confirm if they want to save the changes. 
4. It will notify them that the game's attribute has been changed successfully. 

### 5 - Delete game
This option allows the user to delete a game from your database.

1. Select the game the user want to delete
2. They'll be prompted to confirm if they want to delete the file. 
3. If yes is selected, the game will be deleted.

## Adding a new game or Displaying all games outside of the program.

This feature allows a user to add a game or display all games in the database outside the program.

1. To display all games outside the program enter the following in terminal:

````
$ ruby app.rb display
````

2. If they want to add a game to the database outside the program, enter the following in terminal:

````
$ruby app.rb add <name of game>
````


# Implementation Plan

There are 5 features in the application that can be utilise by the user. The implementation process for each are as followed and were implemented based on priority.

The features that were added are:

1. Add game
2. Search game
3. Edit game
4. Delete game
5. Search for a game (to play)

Below details a thorough walkthrough for the implementation for each feature.

### Add game
'Add game' is the most important feature in the system as it allowed the user to enter in the game data into the database. 

The 'add game' feature utilises multiple complex methods that takes the user's input, stores into a local variable and pushes those variables into an instance. Finally the instance is stored into a global array where the other methods and modules can access and manipulate the data.

below is the checklist for the implementation of add game feature. 

![add game checklist](assets/chris-tri-T1A2-6-add-game-feature-checklist.JPG)

### Search game
'Search game' feature was the most complex feature as it was a standalone menu.

This menu was broken up into the following sub-features:

1. List all games: allows the user to print all the individual games in the database onto the terminal. This would use the .each method which iterates through each stored instance in the global array, stored it again into a temporary array. This temporary array is then used by the gem 'terminal-table' which formats it into a readable format.

2. Search by attribute: Allows the user search by attribute and returns all results that match that attribute. To accomplish this, .each method will iterate through each of the instances, and when it finds a match, stores it into a temporary array, which then gets printed out by the end of the method. 

![search game checklist](assets/chris-tri-T1A2-6-search-game-feature-checklist.JPG)


### Edit game
'Edit game' feature allows the user to search through their database and gives the ability to edit a chosen attribute. 

The chosen attribute will then be changed in the instance and then updated in the global array.

The edit game feature uses elements from the search game feature. It will first list all the games in the database by name, and allows the user to pick it to edit. 

Once the user picks one of the games, it will present the user with a choice for which attribute to edit. This will be accomplished by iterating through the global array, matching the name of the game and editing the chosen attribute. The attribute is updated and re-stored into the global array.

![edit game checklist](assets/chris-tri-T1A2-6-edit-game-feature-checklist.JPG)

### Delete game
'delete game' feature allows the user to delete a game from their database. 

This will be accomplished by accessing the global array containing all the games in the database. Then to delete the game, the user is presented a list of games using the name, and the user selects the game they want to delete. The input is then translated into an index of the global array and the program will delete that stored data relating to that index. 

There will also need to be a prompt that warns the user that the data is going to be deleted. This is accomplished using tty-prompt.

![delete game checklist](assets/chris-tri-T1A2-6-delete-game-feature-checklist.JPG)

### Search for a game
'Search for a game' feature allows the user to select an incomplete game and print it to the terminal. 

This is accomplished by extracting the games from the global array with the attribute "incomplete", storing them into a temporary array and using the .sample method to select the game. Finally, it will print the chosen game into the terminal. 

![search for a  game checklist](assets/chris-tri-T1A2-6-select-a-game-feature.JPG)


# Help

This section wil explain how to install the necessary dependencies and how to use the application itself.

## Installing necessary dependencies
To ensure your machine has the necessary dependencies to run the application, you'll need to run the build.sh in your terminal. Use the following command in terminal to install the necessary dependencies. 

````
$ bash build.sh
````

## Minimum requirements
PC, MAC or Linux system. 
System terminal to run and install the application. 
Ruby 2.5.1

## Running the application
Firstly, go to the dist folder using the following command in terminal where the application is located:
````
cd dist
````

To run the application, in your terminal, type:
````
$ ruby app.rb
````
If the application runs correctly, you'll see the following screen appear on your terminal.

![main menu](assets/chris-tri-T1A2-4-main-menu.jpg)

### Select a game to play 
Randomly selects a video game with an incompleted status in their database and returns the game name for the user to pick and play.

### Add game
Allows user to enter the details of their video game to be saved into the database.

### Search game
'Search game' feature was the most complex feature as it was a standalone menu.
### Edit game
Allows the user to select a game to edit the attribute of the game, which will update in the database.
 
### Delete game 
Gives the ability for the user to delete a stored game in the database.

