### 2024-09-23 - 6.5hr: Headline of what work was done like "Got the player character working."
* Found a tutuorial at https://gamedev.com/123/abc" which showed me how to create a
  topdown character in godot. (two spaces to continue bullet)
* Ran into issue with XYZ, so used ChatGPT to figure it out by doing ABC
* TODO: I still need to get the projectile working.
* I completed [XYZ](some-link-to-ticket) 

### 11-24-24 3hr: Levels
* added more levels, adjusted player movement
* Made player hitbox smaller to account for no cyote time during headhitters

### 11-23-24 3hr: Camera down, checkpoint system, Killzones
* Stuggled to make area 2d work (collision mask problems)
* Made a checkpoint system, and killzone simply teleports you to there
* made a trigger that moves the camera down when hit. 
* Added Lazer spikes killzone


### 11-19-24: 3hr: added more map, made camera controls simulate "rooms"
* Todo: collision camera down,build out levels, checkpoint system
* Added triggers if the player leaves the camera range. Node will jump to that place, making it appear like there are "Rooms"
* Still need to figure out down triggers. Cannot get area2d to work correctly.


### 11-10-24: 1hr: Tileset adjustmet, explosion feedback, extended player movement
* Fixed tileset bugs
* Adjusted player movement to new sprites
* attempted to make node to show dash
* Added Background Music


### 11-19-24 4hr: Tilesets and node attempt
* Worked for the past 10 days, didnt get all the specifics
* more level. More failed nodes, failed checkpoint system. Pushing to itch

### 11-09-24 2hr: Sprites and level rework
* Added new tiletset
* Todo: randomize tiles, make tilemap set? for easy building


### 10-29-24 2hr: Sounds, Sprite updates
* Added new jump sound, new dash sound
* Added new sprite set.


### 10-27-24: 5hr: Final mechanic adjustments
* Added visual layer for slowdown: Simply a hidden canvas item. Its kinda bad https://forum.godotengine.org/t/help-with-managing-visibility-in-code/69472/12
* Added timer to end slowdown
* added second dash!
* Made dash length longer
* Decided to remove directional dash
* Added slower falling
* Slowdown Happens faster
* Adjusted little jump
* Acceleration magnitude lowered. 
* Added more practice platforms


### 10-20-24 2hr: Slowdown & Effects
* Added Slowdown. Trigger on controller, or Z on keyboard
* Added sounds for slowdown
* Slowdown increaces over small timeframe, leaving player frozen until dash/slowdown is done again (Main mechanic)

### 10-19-24 2.5hr: Character acceleration Revamp
* Limited dashes per floor touch to 1
* Adjusted character acceleration
* Added Varible Jump Height
* Used Tutorial https://www.youtube.com/watch?v=4m34vwvrFVE&t=273s for varible jump height. I dont like it that much


### 10-13-24 2hr: Character revamp and playtesting out of class
* Restarted charcter script from scratch and made dash
* added curve to dash. (Small upwards velocity boost)
* Added dash sound effect from pre-owned library
* Got 3 playtesters

### 10-8-24 1.5hr: Dash, movement, in class work
* Continued to work on dashing and movement
* Added more areas
* Did not get a chance, had to do playtesting


### 10-1-24 2hr: project decor and building out areas
* Day 2 of working
* Added project to itch.io
* added death, considering new scenes for each new room.
* added more platforms
* Added spike sprites
* Extended start area and BG decor (Chains)
* Attempted to make sprites hitboxes. Did not finish


### 9-24-24 3hr: Initalize project
* Made a trello board
* Made a github repo
* Made project, character, and controller support
* Using  platformer youtube tutorial as a refresher: https://www.youtube.com/watch?v=LOhfqjmasi0&t=1376s
* Added Tilemap and tilesets
* Attempted to do celeste style room camera controls