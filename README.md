# Apple Watch Space Game
Repository for our fourth year Gesture-based UI project

## Intro
This project is a simple proof of concept space shooter game made to be played on an Apple iPone with a paired Apple Watch.  The phone provides the visual side of the game while the Watch acts as the controller for said game.  The Watch records the users arm rotation and transfers this to the Phone to move the player onscreen.

This game was developed for our fourth year Gesture-based UI project.

## Contents
- Research
- Game
- Links

## Research

## Game
As stated above the game requires both an iPhone and Apple Watch to be played.  This is because the game runs as an app on the phone whilst the companion watch app records and sends live data to the phone which is processed and used to control the onscreen avatar.

### iPhone
The app running on the phone is the 'game' part of this project.  It creates the screen in which the gameplay occurs.  The player spawns at thed bottom of the screen whilst enemies spawwn randomly at the top and fall down. The player moves left and right depending on the inputs given.  The players spaceship continuously fires a laser and when they scored a hit the enemy explodes and the score is increased.

### Apple Watch
Meanwhile on the watch app, the wearers arm rotation is recorded as attitude data (pitch) every tenth of a second and this data is sent to the gamed app on the paired iPhone.

## Links / References
Watch connectivity:
- https://www.raywenderlich.com/3358-advanced-watchos/lessons/5
- https://www.natashatherobot.com/watchkit-open-ios-app-from-watch/
- https://developer.apple.com/documentation/watchconnectivity

Sending Data:
- https://stackoverflow.com/questions/33200630/wcsession-sendmessagereplyhandler-error-code-7014-wcerrorcodedeliveryfailed
- https://forums.developer.apple.com/thread/107831
- https://stackoverflow.com/questions/32092243/global-variable-in-appdelegate-in-swift/32092335
- https://stackoverflow.com/questions/42522499/access-variables-from-app-delegate-in-view-controller
