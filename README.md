######## ##     ## ######## 
   ##    ##     ## ##       
   ##    ##     ## ##       
   ##    ######### ######   
   ##    ##     ## ##       
   ##    ##     ## ##       
   ##    ##     ## ######## 

########  ##     ##    ###    ##    ## ########  #######  ##     ## ######## 
##     ## ##     ##   ## ##   ###   ##    ##    ##     ## ###   ### ##       
##     ## ##     ##  ##   ##  ####  ##    ##    ##     ## #### #### ##       
########  ######### ##     ## ## ## ##    ##    ##     ## ## ### ## ######   
##        ##     ## ######### ##  ####    ##    ##     ## ##     ## ##       
##        ##     ## ##     ## ##   ###    ##    ##     ## ##     ## ##       
##        ##     ## ##     ## ##    ##    ##     #######  ##     ## ######## 

____________________________________________________________________________________________________________________________________________________________________

Author: Laura Mary Clarke
Email: 09.l.clarke.09@gmail.com
Edx: __L-Clarke__
GitHub: L-C-game
Copyright (c) 2020 Laura Mary Clarke
Phantome and all related media are the intellectual property of Laura Mary Clarke
____________________________________________________________________________________________________________________________________________________________________
- Description -
My final project submission is called 'The Phantome', it is a top-down ARPG in a similar vein to 'The legend of Zelda'. 

The game features; a dungeon with three interconnected rooms, simple combat, multiple types of interactable objects, multiple enemy types with simple AI 
and 'GAMEBOY' style graphics and resolution.

The game opens into the title menu which has 3 different options: 'Play', 'Controls' and 'Quit'.
Selecting 'Controls' displays a screen which lists the controls used in the game. 
Selecting 'Play' takes the player to the story screen, helping to give context to the player's quest, the player can then transition to the game by pressing enter.
The player can traverse through a map with 3 interconnected, distinct rooms:
It is possible to travel between each of the rooms and the map remembers which enemies have been killed and if chests/doors are open.
+ The first room is the entrance to the dungeon with one locked and one open door.
+ The North locked door leads to the final room.
+ The south locked door is permanently locked and is there for context, it just represents how the character entered the dungeon.
+ The open door leads to a room with monsters and a locked chest.

- The player must defeat the different monsters in the treasure room,
   the enemies have a 1/3 chance to drop hearts for the player to refill their health by 2 health each.
- If the player's health falls to zero the game pushes the gameover state and the player can then choose to retry or quit, 
   retrying takes them to the title screen.
- Vanquishing the enemies causes the chest in the room to open, spawning a key.
- The key can be picked up by the player, appearing in the player's inventory.
- Colliding with the final room door causes it to open and the key disappears from the inventory.
- Colliding with the phantome then completes the game causing a transition from the playstate to the winstate.
- The winstate screen displays some follow up story and allows the player to return to the title screen or quit the game.

- Complexity - 
The game uses multiple states, these include the game states: Title, Controls, Story, Play, Game Over and Win.
The entity states: Entity Idle, Entity Move
The player states: Player Idle, Player Walk, Player attack
The entity and player related states use state machines that are set up in play state, while the game states use the state stack, this allowed more flexibility when 
transitioning states.
The entity states contain basic movement and the AI logic, while the player states contain more specific logic relating to the player's abilities. 
For example user controlled movement and attacks. The hitbox of the sword is set up and controlled by the hitbox class, 
this allows the option of enemies also wielding weapons with variable hitboxes (depending on direction).
The game takes advantage of data oriented design, particularly with the room and entity definitions. This allows for easy editing of the game,
more or different entities can be added to rooms as can doors. The entities can be given different properties such as differing health. 
Game objects such as chests or keys can also easily be added to different rooms (as can the phantome). 
Most of the games logic is contained in the room class, this not only represents the room graphically but also instantiates the walls and their collision, 
as well as room specific items such as entities and game objects.  
Game objects are given classes as they have very different functionality, this allows the chest to spawn the key which in turn allows the player to open the locked door 
upon colliding with it, then the phantome causes the game to change to the winstate.
The room logic also allows the character to move between the rooms and any changes the player has made, e.g. killing enemies, opening chests or doors will be maintained
between rooms. The room logic also handles all player and enemy health loss and healing upon picking up hearts.
The play state instantiates the player, handles player door collision and renders the UI. The playstate handles this logic as the player and their related collision 
and UI are room independent.

- Distinctiveness - 
While the game shares some gameplay similarities with the zelda project all of the logic was built from the ground up, the rooms are distinct from one another and keep
in memory the changes that the player makes to them. The player can fight using a sword and unlock doors when picking up the key. The enemies have a simple AI 
The sprites were created by myself to give the game a more unified retro feel to the overall game. The game has a full start to finish experience, simple combat and 
interaction are implemented so the player can explore the world. Story, art and music are used to help give context and create atmosphere. 
The game also allows for player exploration, the player can explore the map as they wish and try to interact  with different objects. 

- Sprites - 
All sprites and pixel art other than the tileset were created by myself using Aseprite

- Sound effects - 
All sound effects were created by myself using Bfxr
____________________________________________________________________________________________________________________________________________________________________
Credits

- Libraries -
anim8, used to animate the game
bump, used to handle collisions
Enrique García Cota: kikito - https://github.com/kikito , http://kiki.to/

class, used to allow for object oriented programming in lua
Matthias Richter: vrld - https://github.com/vrld

push, used to set resolution
Ulysse Ramage: Ulydev - https://github.com/Ulydev

knife,
airstruck - https://github.com/airstruck

Util, used to cut out the tiles of the tileset
Colten Ogden https://github.com/coltonoscopy

- Fonts -
Alagard font, used for title
Hewett Tsoi - https://www.dafont.com/profile.php?user=698002

Zelda DX font, used for the story screen
Brian Kent: Ænigma - https://www.dafont.com/aenigma.d188

Earthbound Beginnings font, used for any menu options and the control screen
myname5749 - https://www.dafont.com/profile.php?user=1016482

- Tileset -
Game Boy simple RPG tileset, edited to include a darker floor and bomb wall(unused)
sonDanielson - https://sondanielson.itch.io

- Music - 
8-bit Theme - Intensity, used as the main menu theme and the game over theme
8-bit Forest theme, used as the game over theme
Ted Kerr 2018: Wolfgang https://opengameart.org/users/wolfgang 

Dark Rooms and Scary Things, used as the gameplay theme
isaiah658 - https://opengameart.org/users/isaiah658

8Bit Adventure, used on the win screen
Manuel Bolaños Gómez: CodeManu - https://opengameart.org/users/codemanu

____________________________________________________________________________________________________________________________________________________________

Special Thanks

To all the above, thank you for graciously providing such excellent assets and rescources for open use.
Thank you to David J. Malan, Colton Ogden, Brian Yu and Doug Lloyd for providing and maintaining this course,
I have greatly enjoyed the course and have been able to learn so much in such a short time. 
