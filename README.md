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
After deciding to use the Apple Watch as the controller we did some research into what other apps and games were already out there that used the device.  We found a couple of different uses for the watch.

Firstly, there are a number of applications that use the watch to display information from their parent app on the phone in an abreviated or convenient way.  Examples of this would be displaying a text message or showing the minutes left on a timer.  Apps such as Facebook Messenger, MultiTimer and the native photos app have companion Watch apps of this manner.

The second usage of Watch apps we found were apps that act as a remote for their parent app such as Spotify and the native Now Playing and camera apps. These examples enable the user to pause, play or skip tracks and take a photo on the paired device.

While these applications of the paired watch and many others are quite useful and fun to use we noticed that there was no example where an app and companion app bundle that worked alongside one another where the watch was used as a controller for a game.

## Documentation
As stated above the game requires both an iPhone and Apple Watch to be played.  This is because the game runs as an app on the phone whilst the companion watch app records and sends live data to the phone which is processed and used to control the onscreen avatar.

### iPhone
The app running on the phone is the 'game' part of this project.  It creates the screen in which the gameplay occurs.  The player spawns at thed bottom of the screen whilst enemies spawwn randomly at the top and fall down. The player moves left and right depending on the inputs given.  The players spaceship continuously fires a laser and when they scored a hit the enemy explodes and the score is increased.

### Apple Watch
Meanwhile on the watch app, the wearers arm rotation is recorded as attitude data (pitch) every tenth of a second and this data is sent to the gamed app on the paired iPhone.

### Code
The main game loop is created in the GameScene.swift file.  This is where the scene is set up, the background starfield emitter, player, enemy spawner, motion manager etc. are added and the timer for auto-fire is initialised.  Seperate functions handle what hapens when there is player movement, spawning enemies, firing, contact and the timing.

In the AppDelegate amongst other things the WCSession is set up.  This is what allows the data transfer between the paired watch and phone and also where a global variable is updated so that the movement data can be accessed in the GameScene.

On the watch app, the Interface.storyboard is set up with a basic label to tell the user how to play.  The InterfaceController is where the CMMotionManager is set up and begins recording environmental data at a set interval of 0.11 seconds.  This number we found was the optimal time as anything quicker would take too much data to send and would clog up the data stream.  The data being sent is the pitch of the watch.  This pitch data is sent as a dictionary over the WCSession every interval of data.

### Conclusions


## Links / References
Gameplay:
- sprites: https://assetstore.unity.com/packages/templates/tutorials/into-the-space-2d-space-shooter-project-20749
- Animations: https://www.brianadvent.com/spritekit-space-game-explosions/

Watch connectivity:
- https://www.raywenderlich.com/3358-advanced-watchos/lessons/5
- https://www.natashatherobot.com/watchkit-open-ios-app-from-watch/
- https://developer.apple.com/documentation/watchconnectivity

Sending Data:
- https://stackoverflow.com/questions/33200630/wcsession-sendmessagereplyhandler-error-code-7014-wcerrorcodedeliveryfailed
- https://forums.developer.apple.com/thread/107831
- https://stackoverflow.com/questions/32092243/global-variable-in-appdelegate-in-swift/32092335
- https://stackoverflow.com/questions/42522499/access-variables-from-app-delegate-in-view-controller

Class Diagram:
- https://github.com/yoshimkd/swift-auto-diagram

Apple Docs:
- https://developer.apple.com/documentation
