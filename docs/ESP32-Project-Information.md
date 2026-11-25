# One Hope: Retro Fighter

**Master Project Specifications**

- Course: DS 3870 – Final Project
- Final Deadline: December 8, 2026
- Team Size: Me, Mina, & Nicholas
- Project Status: Planning and early development

## 1. Project Overview

One Hope: Retro Fighter is a portable, local multiplayer, turn-based RPG fighting game inspired by the simplicity of handheld gaming during the Game Boy Advance and Nintendo DS eras.

The objective is to recreate the experience of playing fun, competitive games with friends anywhere, without the need for complicated online services.

The game will feature five playable characters, each with distinctive statistics, abilities, and combat archetypes.

Two players will connect their Android smartphones to a portable ESP32-S3 device housed inside a custom 3D-printed cartridge. They will then battle against one another using their smartphones as controllers and displays.

The game will incorporate retro pixel-art graphics and an RGB LED on the ESP32 that responds to different characters and combat actions.

**Core project philosophy:**

- Portable and accessible local multiplayer.
- Two-player competitive gameplay.
- No internet connection required during matches.
- No advertisements or microtransactions.
- Simple gameplay with strategic depth.
- Retro handheld-console aesthetics.
- Essential integration of ESP32 hardware.

**Our Idea pitch:**

With our application, we aim to bring back the simplicity and joy that we used to associate with gaming; when you could just sit on a couch or at the dinner table with a friend and spends hours playing games with each other. No ads, no microtransactions, just simple fun. Our game will bring back the portable, friendly competition we’ve lost since the GBA and DS eras.

## 2. Project Hardware

### ESP32-S3 Microcontroller

The primary hardware component is an ESP32-S3 development board with an onboard NeoPixel-compatible RGB LED.

The ESP32 must play an essential role in the game rather than merely serving as a decorative accessory.

**Intended responsibilities:**

- Establish or manage the local wireless multiplayer connection.
- Communicate with two Android devices.
- Receive player commands.
- Coordinate turn-based combat.
- Maintain synchronized match information.
- Trigger RGB LED effects corresponding to gameplay events.

Proposed implementation: Use the ESP32 as the authoritative multiplayer game host, responsible for processing turns and maintaining the official battle state.

This architecture is strongly preferred but should be validated during technical planning.

### 3D-Printed Cartridge

The ESP32 will be enclosed in a portable, custom-designed 3D-printed cartridge.

The instructor has agreed to print the enclosure using a design submitted by the team.

**Design objectives:**

- Small enough to carry conveniently.
- Protects the ESP32 board.
- Allows access to required connections.
- Makes the onboard RGB LED visible.
- Visually evokes a classic portable game cartridge.

The exact dimensions, enclosure geometry, and powering method have not yet been finalized.

An external USB power source or small power bank may be used for the prototype.

## 3. Technology Stack

**The project will use the following technologies:**

| Component | Technology |
| --- | --- |
| ESP32 Firmware | C++ |
| Software / Web Development | Node.js + JavaScript |
| Android Mobile Application | Dart + Flutter |
| Hardware | ESP32-S3 |
| Cartridge Enclosure | 3D Printing |

### ESP32 Firmware — C++

C++ will be used to program the ESP32, including wireless communication, game coordination, and RGB LED controls.

### Software — Node.js + JavaScript

Node.js and JavaScript will be used for the software portion of the project.

Their exact runtime role in the final portable architecture still requires clarification. Potential responsibilities include developing and testing combat mechanics, organizing character data, and supporting web-based software components.

The final implementation must not require a laptop-based server during matches if standalone portable gameplay is to be achieved.

### Android Application — Dart + Flutter

The mobile application will serve as the player's primary interface.

**It should provide:**

- Main menu.
- Character selection.
- Character statistics.
- Multiplayer connection interface.
- Battle screen.
- Four selectable attacks or abilities.
- HP and MP indicators.
- Combat feedback and animations.
- Victory and defeat screens.

Both players will use their own Android devices.

## 4. Multiplayer System

Game Mode: Local multiplayer, 1 versus 1.

There will be no computer-controlled opponent in the planned final version.

The game is intended to support two players connecting to the same portable ESP32 cartridge.

### Intended Connection Process

1. Player 1 powers on the ESP32 cartridge.
2. The ESP32 establishes a local wireless network.
3. Player 1 connects their Android device.
4. Player 2 connects their Android device.
5. Both players open the mobile application.
6. The players join the same multiplayer session.
7. Both players select a character.
8. The battle begins.
9. The ESP32 coordinates player actions and synchronizes the game state.
10. The game ends when one player defeats the other.

The professor originally suggested using Bluetooth and a Wi-Fi hotspot to facilitate connections and application access.

Technical decision pending: Determine whether Bluetooth Low Energy is necessary for discovery or onboarding. A simpler Wi-Fi-only connection is acceptable as an initial prototype if it meets course requirements.

Application distribution pending: Determine whether the app must be downloadable from the cartridge or can be installed on the phones before gameplay.

### Essential Multiplayer Requirements

- Support exactly two active players in a match.
- Maintain a synchronized game state.
- Prevent invalid player actions.
- Prevent either client from independently determining combat outcomes.
- Process actions consistently.
- Detect when a match is complete.
- Provide basic handling for disconnections.

## 5. Gameplay Overview

Genre: Turn-based RPG fighting game.

Players: Two human players.

Playable Characters: Five.

Available Moves: Four per character.

Total Planned Moves: Twenty.

Players select fighters and engage in one-on-one battles. Each character has different advantages, disadvantages, and abilities.

Combat will use HP, MP, and four numerical combat attributes.

The game should balance accessibility with strategic decision-making.

### Turn-Based Combat

**The planned gameplay loop is:**

1. Determine which player acts first.
2. The active player selects one of four abilities.
3. Validate the move and its resource cost.
4. Calculate the resulting damage or effect.
5. Update the fighters' HP, MP, and other applicable states.
6. Display the result on both devices.
7. Trigger any associated ESP32 LED effect.
8. Proceed to the next turn.
9. Continue until a victory condition is reached.

Proposed rule: SPD determines which character acts first, but does not automatically grant additional turns.

Exact turn-order rules, status effects, resource recovery, and combat formulas remain unfinished.

## 6. Character Statistics

**Each fighter has six statistics:**

| Stat | Function |
| --- | --- |
| HP | Health Points; determines survivability |
| MP | Magic Points; resource for attacks and abilities |
| ATK | Physical attack capability |
| DEF | Defensive capability |
| ARC | Magical or Arcana attack capability |
| SPD | Speed and turn-order capability |

### Stat Limits

ATK, DEF, ARC, and SPD have a maximum value of 50.

HP and MP follow separate numerical scales and are not restricted to 50.

### Character Selection Display

The four combat attributes will be displayed using five-segment horizontal bars.

Each full segment represents 10 stat points.

**For example:**

- 10 = One full segment.
- 20 = Two full segments.
- 30 = Three full segments.
- 40 = Four full segments.
- 50 = Five full segments.

Character statistics must be stored in an easily editable configuration or data structure in increments of 10.

## 7. Playable Character Roster

### Character 1 — Jayden Kamikage

- Class: Hero
- RGB Color: White
- Playstyle: Balanced

Appearance: Black hair, Black eyes, Black armor w/ black cape, a dark left hand sword, a light right hand sword, & a silver cross necklace

**Statistics:**

- HP: 350
- MP: 150
- ATK: 30
- DEF: 30
- ARC: 30
- SPD: 30

**Abilities:**

1. X-Slash
2. Radiant Light
3. Crescent Fang
4. Luminescent Shadow

Jayden is the balanced fighter and serves as the reference point for the remaining characters.

His abilities combine dual-wielding swordsmanship with light/dark magic techniques.

### Character 2 — Lysander Goldwyn

- Class: Warrior
- RGB Color: Gold
- Playstyle: High durability and strong physical combat

Appearance: Golden Blonde hair, Gold Eyes, Gold armor w/ red cape, & Two-handed Claymore

**Statistics:**

- HP: 400
- MP: 100
- ATK: 30
- DEF: 50
- ARC: 20
- SPD: 10

Stat Identity: Highest DEF and lowest SPD.

**Abilities:**

1. Undecided
2. Golden Vow
3. Undecided
4. Stormbringer

Lysander is a heavily defensive warrior with low mobility.

### Character 3 — Sophia Fuyuki

- Class: Sorceress
- RGB Color: Light Blue
- Playstyle: Magical combat specialist

Appearance: Snow White hair, Icy blue eyes, white & light blue dress, Light blue grimoire with a white snowflake insignia

**Statistics:**

- HP: 270
- MP: 200
- ATK: 10
- DEF: 20
- ARC: 50
- SPD: 30

Stat Identity: Highest ARC and lowest ATK.

**Abilities:**

1. Frozen Tomb
2. Undecided
3. Undecided
4. Shattered Dreams

Sophia specializes in Arcana-based spell abilities. She has the highest MP pool in the roster.

### Character 4 — Zora Dreamer

- Class: Rogue
- RGB Color: Red
- Playstyle: Fast, agile, technical combat

Appearance: Brown hair, Red eyes, Light-skinned tone, Red sweater, Black baldric with gold circular ring, White jacket with black fur hood, Black fingerless gloves, black shorts, grey boots, Black reverse grip dagger

**Statistics:**

- HP: 250
- MP: 160
- ATK: 40
- DEF: 20
- ARC: 10
- SPD: 50

Stat Identity: Highest SPD and lowest ARC.

**Abilities:**

1. Undecided
2. Undecided
3. Undecided
4. Vengeance

Zora specializes in speed-oriented combat, knife fighting, and martial arts.

She replaces Azura Evergarden from an earlier version of the project.

### Character 5 — Damon Wolfbane

- Class: Warlord
- RGB Color: Purple
- Playstyle: High-risk, high-damage glass cannon

Appearance: Purple hair, Purple eyes, Large Greatsword on his back, purple coat with white fur & silver accessories, purple beard,

**Statistics:**

- HP: 230
- MP: 90
- ATK: 50
- DEF: 10
- ARC: 40
- SPD: 30

Stat Identity: Highest ATK and lowest DEF.

**Abilities:**

1. Undecided
2. Undecided — Planned HP-consuming ability
3. Undecided
4. Twilight Moon

Damon has the lowest HP and MP values in the roster.

His playstyle involves powerful attacks with significant vulnerabilities.

An MP-restoring ability has also been proposed, but its exact implementation has not yet been finalized.

Note: Version 1 base stats are subject to change further along in development.

## 8. Combat Mechanics — Unfinished

**The following systems still require design and balancing:**

- Remaining numerical character statistics.
- ATK-based versus ARC-based attacks.
- Individual move damage values.
- MP consumption for each ability.
- HP consumption for applicable techniques.
- Damage calculation formula.
- Defensive scaling.
- Turn-order rules.
- Buffs and debuffs, if included.
- Resource restoration.
- Additional character-specific mechanics.
- Move animations and visual effects.

Not every attack currently labeled ATK in the original design document is intended to be physical.

Some abilities will use ARC instead.

Important implementation instruction: Do not treat unfinished values or mechanics as finalized decisions.

Use explicitly labeled, configurable development placeholders until the finalized balancing information is provided.

## 9. Visual Design

The game will use a retro pixel-art aesthetic inspired by classic 16-bit RPGs and handheld-console games.

### Primary Background

**The established visual concept includes:**

- Deep navy-blue nighttime sky.
- Bright stars.
- Large luminous full moon.
- Field of white flowers.
- Water.
- Horizontal pixel-art scenery.
- Fantasy-inspired visual atmosphere.

### User Interface

The interface should resemble a classic retro RPG.

**Preferred features include:**

- Pixel-art menus.
- Ornate blue-and-silver interface elements.
- Character portraits or sprites.
- Clearly displayed HP and MP.
- Five-segment stat bars.
- Readable combat text.
- Highlighted menu selections.
- Character-specific colors.

Existing concept images provide aesthetic references, not finalized character artwork.

Character designs should not be inferred from these mockups without approval.

## 10. ESP32 RGB Lighting System

The ESP32's onboard RGB LED is an intentional gameplay feature.

The LED should react to different actions during multiplayer matches.

### Character Colors

| Character | RGB Color |
| --- | --- |
| Jayden | White |
| Lysander | Gold |
| Sophia | Light Blue |
| Zora | Red |
| Damon | Purple |

### Proposed Lighting Events

- Connection established.
- Player joined.
- Match starting.
- Character selected.
- Player turn begins.
- Normal attack performed.
- Arcana-based technique performed.
- Damage received.
- Victory.
- Defeat.

Lighting patterns such as pulses, flashes, and repeated blinks may be assigned to these events.

The exact LED patterns are not finalized.

The LED system should remain secondary to core multiplayer functionality.

## 11. Statement of Work Requirements

Before beginning full-scale implementation, prepare a professional Statement of Work covering:

1. Project objectives and rationale.
2. Scope of work.
3. Deliverables.
4. Hardware and software architecture.
5. Functional requirements.
6. Nonfunctional requirements.
7. Multiplayer networking.
8. ESP32 firmware responsibilities.
9. Mobile application responsibilities.
10. Node.js/JavaScript responsibilities.
11. Team responsibilities.
12. Development milestones.
13. Integration and testing strategy.
14. Technical risks and mitigations.
15. Acceptance criteria.
16. Project deadline.

The project has three team members, but individual development responsibilities have not been formally finalized.

## 12. Development Priorities

Development should prioritize technical functionality over aesthetic refinement.

### Priority 1 — Hardware and Connectivity

- Successfully program the ESP32-S3.
- Establish a local Wi-Fi connection.
- Connect two Android phones.
- Verify reliable communication between the devices.

### Priority 2 — Multiplayer Communication

- Create the multiplayer lobby.
- Identify Player 1 and Player 2.
- Exchange basic commands.
- Maintain synchronized game information.

### Priority 3 — Functional Combat

- Implement a basic turn-based battle.
- Display HP and MP.
- Process valid attacks.
- Calculate damage.
- Update both players' screens.
- Determine a winner.

### Priority 4 — Complete Character System

- Implement the five fighters.
- Add configurable statistics.
- Add four abilities per character.
- Support ATK and ARC-based attacks.
- Add relevant resource costs and effects.

### Priority 5 — Visuals and Hardware Polish

- Build the retro interface.
- Add character portraits or sprites.
- Integrate the RGB lighting patterns.
- Complete the cartridge enclosure.
- Improve combat feedback and presentation.

## 13. Minimum Viable Product

The minimum viable product must demonstrate the ESP32's essential role in local multiplayer.

**A successful MVP should allow:**

1. An ESP32-S3 to power on and host the local game connection.
2. Two Android phones to connect.
3. Two players to join the same match.
4. Both players to select a fighter.
5. Players to execute valid turn-based attacks.
6. The ESP32 to process and synchronize the match.
7. Both phones to display updated HP and match information.
8. A winner to be determined.
9. An RGB LED effect to respond to a gameplay action.

The MVP may initially use temporary character data and simplified battle visuals.

## 14. Project Constraints

- Final submission deadline: December 8, 2026.
- Three-person student development team.
- ESP32-S3 hardware must be essential to the system.
- Two-player local multiplayer is required.
- A portable cartridge is part of the project concept.
- The Android application will be developed in Dart/Flutter.
- C++ will be used for ESP32 firmware.
- Node.js/JavaScript will be used for the software component.
- The game should function without external internet access during battles.
- Visual polish must not delay the essential multiplayer prototype.

## 15. Instructions for Codex

Use this document as the primary specification for One Hope: Retro Fighter.

Begin by producing a professional Statement of Work and identifying any unresolved technical questions.

**Clearly distinguish:**

- Confirmed requirements.
- Proposed implementation decisions.
- Unfinished character-balancing information.
- Optional features.
- Risks or technical limitations.

Do not invent finalized character statistics, ability values, or unapproved mechanics.

Design the software so that character statistics, abilities, and RGB lighting configurations can be modified without restructuring the entire application.

Prioritize a functioning two-player ESP32-based multiplayer system.

The most important requirement is that the ESP32 must be genuinely necessary for gameplay, not simply an optional lighting controller.

The final deliverable should be a portable multiplayer experience that captures the charm and simplicity of classic handheld gaming.

## 16. Hardware identification

### ESP32-S3 development board

The carrier is marked ESP32-S3 on the back. The metal shield reads S3-N16R8, WIFI+BT, and 2.4G 802.11/b/g/n. In Espressif’s naming scheme, N16R8 indicates 16 MB of flash storage and 8 MB of PSRAM (working memory). The carrier manufacturer, board revision, and onboard LED pin remain unconfirmed. [Espressif ESP32-S3 ordering information](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32s3/esp32-s3-devkitc-1/user_guide_v1.1.html#ordering-information).

Two USB-C sockets sit along the bottom edge, marked COM and USB on the reverse. The front has RST and BOOT buttons and a square LED marked RGB. The cartridge design should leave the power connection accessible and this LED visible so players can see the active fighter’s color.

### OSOYOO Sensor RGB Module

The separate board carries the OSOYOO Sensor RGB Module label, a single multicolor LED, and a four-pin connector. With the LED above the connector and the component side facing you, the pins read from left to right as shown below. The back lists the pins in reverse order when viewed from that side.

| GND | B | G | R |
| --- | --- | --- | --- |
| Ground | Blue channel | Green channel | Red channel |

This module can serve as an optional second light for the cartridge. The prototype uses the ESP32 board’s onboard LED for its required battle cue. GPIO assignments for the external module will depend on the carrier pinout. [OSOYOO RGB module reference](https://osoyoo.com/manual/2021005400.pdf).
