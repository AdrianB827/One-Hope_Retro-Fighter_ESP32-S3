# One Hope: Retro Fighter

A local, two-player pixel-art RPG featuring five fighters from Adrian’s *One Hope* stories. The goal is to set an ESP32-S3 cartridge between two friends, let each pick a fighter on an Android phone, and play a full match without internet access. The DS 3870 final project also includes a playable web version.

**Project status · November 24, 2026.** This repository contains the project plan. The firmware, clients, and playable builds are still to come. The final submission is due **December 8, 2026**.

## Project documents

- **Statement of Work** covers team assignments, milestones, and acceptance tests. [Read on GitHub](docs/Statement-of-Work.md) · [Word copy](docs/Statement-of-Work.docx)
- **Information for My Final Project** contains the full game specifications. [Read on GitHub](docs/Information-for-My-Final-Project.md) · [PDF copy](docs/Information-for-My-Final-Project.pdf) · [Section 16 — hardware identification](docs/Information-for-My-Final-Project.md#16-hardware-identification)

## How a match works

1. Two players connect to the cartridge, join the same match, and each select one fighter.
2. On their turn, a player picks one of four moves. The game checks the turn and the move’s cost, resolves the action, and sends both players the new HP, MP, and turn.
3. Both screens show what happened. The board’s onboard RGB LED reflects the fight, such as lighting up in the active fighter’s color.
4. When one fighter runs out of HP, the two players see the corresponding victory and defeat screens.

## The roster

HP (health), MP (magic points), fighter colors, and signature strengths are established. The table also records the first draft of ATK (physical attack), DEF (defense), ARC (arcana), and SPD (speed) for playtesting. These four attributes use ten-point steps up to 50, shown as five segments in character selection. HP and MP use their own scales.

| Fighter | Class | HP | MP | ATK | DEF | ARC | SPD | LED color |
| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: | --- |
| Jayden Kamikage | Hero | 350 | 150 | 30 | 30 | 30 | 30 | White |
| Lysander Goldwyn | Warrior | 400 | 100 | 30 | **50** | 20 | 10 | Gold |
| Sophia Fuyuki | Sorceress | 270 | 200 | 10 | 20 | **50** | 30 | Light blue |
| Zora Dreamer | Rogue | 250 | 160 | 40 | 20 | 10 | **50** | Red |
| Damon Wolfbane | Warlord | 230 | 90 | **50** | 10 | 40 | 30 | Purple |

Jayden is the balance reference. His four named moves are **X-Slash**, **Radiant Light**, **Crescent Fang**, and **Luminescent Shadow**. Across the roster, the team still needs to settle remaining move names, costs, effects, damage formulas, and final stat tuning.

## What the team is building

| Component | Technology | Planned role |
| --- | --- | --- |
| Portable cartridge | ESP32-S3, C++, onboard RGB LED | Connect two players, coordinate turns, and keep one shared match state. The enclosure design needs to leave USB and the LED accessible. |
| Android app | Flutter and Dart | Give each player a controller and display, from joining a match and choosing a fighter to selecting a move and seeing the result. |
| Web app and development tools | JavaScript and Node.js | Deliver the same playable battle flow in a browser. The proposed first use of Node.js is to serve the web client during development and simulate match messages for testing. |

**Proposed for the first prototype.** Both players join a local Wi-Fi network created by the ESP32. Clients send move choices, and the board validates them, calculates the outcome, and sends the same result to both players. Higher SPD would decide who opens the match. The tie rule is still open.

**Decisions before release.** The team will test whether Wi-Fi alone satisfies onboarding, whether Node.js has any role during a standalone match, and how phones and browsers obtain the software. Portable Android play must work without an internet connection or a laptop server. Exact LED patterns, enclosure dimensions, and portable power are also open.

## Team and first milestone

| Proposed owner | First assignment |
| --- | --- |
| Adrian · Project lead, game design, and firmware | Own the roster, moves, artwork direction, and balance. Learn the Flutter connection flow and run all physical board tests through November 30. |
| Mina · Android and web interface | Build the menu, fighter selection, battle, and result screens against sample match data. Use the moonlit blue-and-silver menu concept to guide the design. |
| Nicholas · Multiplayer sessions and validation | Define join, move, state, and disconnect messages. Build a two-player Node.js test host so both clients can be exercised before hardware integration. |

The first milestone is one move on the real board with the same result visible on both clients. The final demonstration expands that path to a complete Android match and a complete browser match with all five fighters available. The [Statement of Work](docs/Statement-of-Work.md) lists the proposed dates, handoffs, and acceptance checks.
