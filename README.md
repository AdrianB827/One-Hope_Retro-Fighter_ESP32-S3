# One Hope: Retro Fighter

A local, two-player pixel-art RPG featuring five fighters from Adrian’s *One Hope* stories. The goal is to set an ESP32-S3 cartridge between two friends, let each pick a fighter on an Android phone, and play a full match without internet access. The DS 3870 final project also includes a playable web version.

**Project status · November 27, 2026.** The first Flutter prototype passed a two-phone turn test with the G50 Plus hosting and an iPhone joining through Safari. Both players can select Jayden’s moves and see whose turn comes next. HP and MP stay fixed during this test. The next milestone is one turn resolved by the ESP32. The final submission is due **December 8, 2026**. [Run the two-phone test](retro_fighter/README.md#two-phone-turn-test).

## Project documents

- [Statement of Work](docs/Statement-of-Work.md) covers team assignments, milestones, and acceptance tests.
- [ESP32 Project Information](docs/ESP32-Project-Information.md) contains the full game specifications, including [Section 16 on hardware identification](docs/ESP32-Project-Information.md#16-hardware-identification).

## How a match works

1. Two players join the same match and each select one fighter. On Android they connect to the cartridge. In the proposed standalone web version they join a room in their browsers.
2. On their turn, a player picks one of four moves. The game checks the turn and the move’s cost, resolves the action, and sends both players the new HP, MP, and turn.
3. Both screens show what happened. During cartridge play, the onboard RGB LED can light up in the active fighter’s color.
4. When one fighter runs out of HP, the two players see the corresponding victory and defeat screens.

## Battle screen

The planned Android and browser battle screens use the same horizontal layout. Player 1 stands on the left and Player 2 on the right. The fighters face each other across a grassy field, with the moon centered between them in a starry sky. The upper-left and upper-right corners show the corresponding fighter’s full name, HP, and MP.

The bottom panel changes with the turn:

- **On your turn**, it shows all four moves. Under each move’s name, show the stat it scales with (such as ATK or ARC), its MP or HP cost, and any special effect. For example, Zora’s proposed *Backstab* could read “5% chance to instantly defeat the opponent.” That chance is a balance proposal for playtesting.
- **On your opponent’s turn**, the panel shows only “Player 2’s Turn...” on Player 1’s screen or “Player 1’s Turn...” on Player 2’s screen.

### Sprites and hit timing

Each fighter stays in their own zone throughout a move. The match host resolves the action independently of sprite contact. For example, when Jayden lands X-Slash, he swings from his side of the field. At the impact frame, the opponent switches to their damage pose and a brief visual effect marks the hit. Each fighter has one damage sprite to reuse across incoming attacks.

Adrian will draw limited-frame sprite sheets for all five fighters, with distinct key poses for each of the 20 abilities. Codex will implement the transitions between those poses using timed sprite swaps, movement within the fighter’s zone, color changes, and temporary overlays. Every move should play with placeholder art and a fallback animation from the first prototype, so individual sequences can be swapped in as their art is finished.

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

1. **Install the Flutter extension in VS Code.** Press `Ctrl+Shift+X`, search for **Flutter**, and click **Install**. This also installs the Dart extension.
2. **Download the SDK and open the shared app.** If prompted for the Flutter SDK, choose **Download SDK**, select a folder outside this repository, click **Clone Flutter**, then **Add SDK to PATH**. The SDK includes Dart. Open the existing `retro_fighter` folder in VS Code and run `flutter pub get` in its terminal.
3. **Check the installation.** Restart VS Code, open a fresh terminal, and run `flutter doctor`. Look for a checkmark next to Flutter. The Android toolchain may still need the next step.
4. **Set up Android Studio for the class phone.** After installation, complete the setup wizard and use **SDK Manager** to install the Android SDK and **Android SDK Command-line Tools**. Run `flutter doctor --android-licenses`, review the prompts, then run `flutter doctor` again. Enable USB debugging on the phone, connect it with a USB data cable, authorize the computer, and check that it appears under `flutter devices`. [Download Android Studio](https://developer.android.com/studio)

From the `retro_fighter` folder, run `flutter run -d DEVICE_ID` using the Android phone ID from `flutter devices`. Tap **Host two-phone turn test** to invite a browser on the same Wi-Fi. Run `flutter test` from the same folder to check move selection and turn handling.

## Repository layout and team branches

| Folder | Contents |
| --- | --- |
| `retro_fighter/` | Shared Flutter client and tests. Fighter portraits, sprites, and animation sheets will go under `retro_fighter/assets/fighters/<fighter>/`. |
| `docs/` | Project specifications and SOW. Add character profiles under `docs/character-roster/` and the combat rules in `docs/combat.md` as they are written. |
| `game-data/` | Planned shared data. Use `fighters/` for fighter stats and moves, and `combat/` for rules data and example turn inputs and results. |
| `firmware/esp32/` | Planned C++ firmware for the cartridge. |
| `server/` | Planned Node.js match host and protocol tests. |

Start each feature from the tested prototype on `main`. Add planned folders with their first files. Open a pull request when the assigned behavior can be demonstrated.

| Owner | Branch | First demonstration |
| --- | --- | --- |
| Adrian | `feature/esp32-two-player-turn` | The board accepts one valid move and both phones agree whose turn is next. |
| Mina | `feature/battle-layout` | The battle screen shows both fighters and switches the move panel to a waiting message on the opponent’s turn. |
| Nicholas | `feature/web-match-host` | Two clients join a Node.js room and exchange a turn using the agreed messages. |

To start your assignment, run `git fetch origin`, then `git switch` followed by your branch name. Create later roster, animation, and combat branches when their work begins.

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
