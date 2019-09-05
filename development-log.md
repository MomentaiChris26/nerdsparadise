# Development Log

## Status update emails.

### First email sent to educators on 03 September 2019

Contents of email:

Hey guys!

Chris Tri here! Just wanted to give you an update on how the app is progressing.
There's quite a lot of things I managed to get done today. But I'll list the significant changes and implementations I did.

- Implemented the add game feature where the user inputs the game data which gets stored into an instance and into
a global variable. Biggest issue I had was using tty-prompt. The multi-select feature in tty-prompt is buggy and
allowed the user to bypass input the genre of game. I removed the multi-select feature and instead push for a single
select feature instead where the user can only select one genre rather than multiple.

- I've also completed the implementation of the list all feature where the user can list all the games they've entered into the database into a nice table format. Table uses the gem terminal-table which generated a nice table layout.

The difficult thing about trying to use this gem was converting the class instances into an array so that terminal-table could format it correctly. This took a while to figure out but its finally running! I've done some manual testing and it seems to work correctly.

My goal tomorrow is to implement the edit and delete games features which will take a while since its dealing with
editing the instances inside the class. Once that's done I'll implement the search feature where users can search for their games by title, genre or completion status.

One optional feature I'll hope to get implemented is the ability to randomly pick a game for the user to play. As well as the ability to put a time stamp on the game when they toggle it from incomplete to complete.

Hope that wasn't too long of a read!

Thanks!,

Christopher Tri

[sent email 03/09/2019 - PDF copy](assets/chris-tri-T1A2-6-status-update-03-09-2019.pdf)


### Second email sent to educators on 04 September 2019

Hey Harrison/Rachael,

Just wanted to update you on my app progress!
So I'm up to testing and cleaning up my code.
Few things I've done today, which was:

- Implement the delete and edit features for the app which allowed the user to delete or edit games in their database.

- Updated the search feature which now gives the ability for users to search for games using specific criteria (e.g. by genre or name, etc).

- Also managed to implement the ability to pick a random game to play! Unfortunately, I didn't get time to implement the time stamp, but I don't think be putting that feature in since it seems like there's a few bugs I want to sort out before deployment.

For tomorrow, I'll mainly be finalizing and cleaning the code. I'll also be doing some of the automated
testing. @Harrison Malone I'll definitely need your help on that one! I'm still not that confident in doing it or what I need to do for it.

I'd imagine I'd be finished with the code by Thursday afternoon, which I'll work on my documentation for it.

Thanks!

Regards,

Christopher Tri

[sent email 04/09/2019 - PDF copy](assets/chris-tri-T1A2-6-status-update-04-09-2019.pdf)