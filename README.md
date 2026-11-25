# One Hope: Retro Fighter

A local, two-player pixel-art RPG featuring five fighters from Adrian’s *One Hope* stories. The goal is to set an ESP32-S3 cartridge between two friends, let each pick a fighter on an Android phone, and play a full match without internet access. The DS 3870 final project also includes a playable web version.

**Project status · November 25, 2026.** This repository contains the project plan. The firmware, clients, and playable builds are still to come. The final submission is due **December 8, 2026**.

## Project documents

- [Statement of Work](docs/Statement-of-Work.md) covers team assignments, milestones, and acceptance tests.
- [ESP32 Project Information](docs/ESP32-Project-Information.md) contains the full game specifications, including [Section 16 on hardware identification](docs/ESP32-Project-Information.md#16-hardware-identification).

## How a match works

1. Two players join the same match and each select one fighter. On Android they connect to the cartridge. In the proposed standalone web version they join a room in their browsers.
2. On their turn, a player picks one of four moves. The game checks the turn and the move’s cost, resolves the action, and sends both players the new HP, MP, and turn.
3. Both screens show what happened. During cartridge play, the onboard RGB LED can light up in the active fighter’s color.
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

## Android and web architecture

| Proposed play mode | Client | Where the match runs |
| --- | --- | --- |
| Android cartridge game | Flutter/Dart on two phones | Both phones join the ESP32’s local Wi-Fi. C++ firmware validates moves and sends the result to both players. The portable match runs without internet or a laptop server. |
| Standalone web game | The same Flutter/Dart screens in two browsers | A JavaScript server running on Node.js hosts the room and resolves turns while the cartridge is powered off. The server can run on a classroom laptop for a local demo or online for remote players. |

**Course clarification.** The current Statement of Work tests browser play against the board. Adrian will confirm whether the instructor expects the web demo to work with the cartridge powered off and whether Flutter Web with a Node.js server satisfies the web requirement. Android installation and Wi-Fi-only onboarding also need confirmation.

**Build one turn in parallel.** Mina can build a single Flutter interface for both platforms while Adrian and Nicholas develop the two hosts. Share the roster, move IDs, and message format. Start with X-Slash and record the starting HP/MP, the move, and the expected ending state. Run that example against both hosts before expanding to 20 moves. Higher SPD deciding the opening turn remains a proposal, and the tie rule is open.

## Getting started with Flutter on Windows

Install the Flutter SDK (which includes Dart) and Android Studio’s Android SDK tools. Enable USB debugging on the class phone, connect it with a USB data cable, and authorize the computer. In a new terminal, run `flutter doctor --android-licenses`, `flutter doctor`, and `flutter devices`. [Flutter installation](https://docs.flutter.dev/install/manual) · [Android setup](https://docs.flutter.dev/platform-integration/android/setup)

For the first client setup, run `flutter create --platforms=android,web retro_fighter` once from the repository root and share that project in Git. From `retro_fighter`, run `flutter run -d chrome`, then quit with `q` and run `flutter run -d DEVICE_ID` using the phone ID from `flutter devices`. The first exercise is the same fighter screen on both devices with four move buttons and sample HP/MP. This step works before the board is ready.

## Team and first milestone

| Proposed owner | First assignment |
| --- | --- |
| Adrian · Project lead, game design, and firmware | Own the roster, moves, artwork direction, and balance. Learn the Flutter connection flow and run all physical board tests through November 30. |
| Mina · Android and web interface | Build fighter selection and the four-move battle screen against sample match data. He can test on the phone and in Chrome while Adrian has the board. Use the moonlit blue-and-silver menu concept for the UI. |
| Nicholas · Multiplayer sessions and validation | Define join, move, state, and disconnect messages. Get two players into one Node.js room and give Mina a sample turn result. This host can support standalone web play if approved. |

### Proposed hardware handoffs

- **Monday, November 30:** Adrian brings the board and a USB data cable. Arrange two Android phones and test one move with the same result on both screens. Adrian keeps the board for firmware or Wi-Fi fixes. If only the Android connection needs work, Mina takes it until Wednesday.
- **Wednesday, December 2:** Play a full Android match on the cartridge. If the instructor approves standalone web play, power down the cartridge and finish a second match in two browsers.
- **Saturday, December 5** is an optional hardware troubleshooting session. **Monday, December 7** is the final rehearsal on the demo phones and power source before Tuesday’s submission.

### Cartridge power

Use USB power from a computer during development. For a portable demo, the proposed setup is an external USB power bank with a cable opening in the enclosure and a window for the onboard RGB LED. Test the bank and cable through a full match before finalizing the print. The onboard LED draws power from the board. The separate OSOYOO RGB module is optional and can share the cartridge’s power source once the team verifies its electrical requirements and pin assignments.
