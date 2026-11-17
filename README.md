# One-Hope_Retro-Fighter_ESP32-S3
DS 3870 Final Project

General Idea so far:
- Retro Pixel-art style Turn-based Fighting Game (Ex. Pokémon & Street Fighter mashup)
- Contains a Main Menu, Character Selection, Turn-Based Battle, & Victory/Loss Screen
- Single-Player game against a CPU that will randomly select moves and adjust its strategy as the battle goes on
- 5-character roster with class archetypes, 4 moves per character, & character-specific LED colors
- Each character has the following six stats: HP, MP, ATK, DEF, ARC, SPD

Technical Ideas so far:
- The Android mobile application serves as the controller to interact with the UI, select menu options, and view character's moves
- The ESP32-S3 LED will receive commands from the phone to change colors/patterns for a character's turn, damage taken, low health, and a victory/loss
- The Web application will run the game engine to play in browser
- (Still figuring out coding Tech Stack)
