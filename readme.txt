downwell-like
https://johnschwarz.itch.io/drop

CONTROLS

A and D to move left and right 
Comma (,) to jump/shoot

SYNOPSYS     

Overrun by radioactive waste, mankind constructed a titanium tube to store it. They dumped scores and scores of the bubbling goo into the tube, and sealed it forever... until one day it mysteriously popped open. You were sent to investigate.

GAME

  Roaches crawl back and forth - their carapaces deflect bullets - you must stomp on them.
 Spores are released by Plants and Frogs. You can bounce off the top of them.
  Drones fly around and bump into things. You can bounce off them or shoot them.
 Plants shoot spores. You can bounce off them or shoot them.
  Frogs shoot spores too. They do not take damage from bouncing because they're too rubbery.
 Collect coins and powerups, for multi-shot, more ammo, heals, bounce control, and wall control.
  There is a boss at the bottom of the well too.  Once you defeat the boss, the game is over and will reset.

ABOUT
This is a game I made in Godot, based off the famous Downwell game.
I was reading about the creation of Downwell, and the designer Ojiro Fumoto said he used a txt file to prodecurally make the levels.
Inspired by the idea, I set out to make a level generator like that. 
It's pretty simple and flexible in it's design. 

=
|xxxxxxxFxxxxxxx|
|xx...........xx|
|xxx.........xxx|
|xxxx*.....*xxxx|
|xxxxx.....xxxxx|

Here is an example of a chunk.
The map is broken up into 5X17 chunks like this.
Each character is associated with a different scene, that's a 16x16 tile with some functionality to it.

The spawning system is primarily 2 scripts:
The first one is the MapDecider.gd scriipt. 
It has a Grid class that holds a 2D array of each chunk, split at the line break. 
A function takes in the .txt filepath and returns a dictionary of each chunk, split at the "=", with an int as the key, and the chunk as the value. 
There are a few utility functions for things like returning a chunk from a specific index, or chunks within a range, or a random chunk.
Then I use a signal (connected through the Master.gd script) to tell the MapSpawner.gd script what scene-tile to spawn, and where.
I feed a function the character and then use a simple match case to spawn the appropriate scene-tile:

--------

I have a simple combo system in this game as well. With each successful mid-air attack (which includes bouncing off an enemy), one point is added to your combo counter. Once you land, the combo counter is resolved, compared to a few tiers of difficulty, and then you're rewarded with bonus points. 

--------

There is also a simple upgrade system. 
I have an Upgrade Resource that uses an enum of upgrade typesm with a texture and some strings for its name and description. 
These upgrades are spawned on the map through the map spawning system, and when the player overlaps with an upgrade, it's applied to the playermover.gd script, through use of a simple match statement.


TAKE AWAYS      

The map creation system is pretty cool, but a common technique. It's pretty tough to visualize what the chunk will feel like from the .txt file alone. I would use this system again.
I like the combo system a lot, and find it fun for gameplay. I used a combo system in Word Wizard too. I will try to use them on every project! haha
The upgrade system is simple but effective. It feels good to upgrade, and the improvements are very noticable. 
