# One Hope: Retro Fighter — Statement of Work

DS 3870 / FINAL PROJECT

**Team review draft** November 24, 2026 • Final submission due December 8, 2026

Two friends should be able to set a cartridge on the table, pick characters from Adrian’s One Hope stories, and finish a battle on their phones without internet access. The team will deliver that experience on Android and a playable web version that uses the same fighters and rules.

## Scope of the class demonstration

One ESP32-S3 will coordinate one local match for exactly two human players. Each player chooses a fighter and takes turns selecting one of four moves. Both screens show whose turn it is, what the move did, each fighter’s HP and MP, and the final result. The board’s onboard RGB LED gives a visible cue during play.

## Deliverables due December 8

| Deliverable | What the team will hand over |
| --- | --- |
| Firmware and cartridge | C++ firmware, board setup and power instructions, and a print-ready enclosure design. Check the instructor’s print for board fit, USB access, and LED visibility when available. |
| Android and web apps | A Flutter/Dart client for the phones and a playable browser client. Each includes the lobby, fighter selection, battle, and win/loss screens. |
| Five playable fighters | Editable stats and four moves per fighter, for 20 move slots. Include approved appearances, RGB colors, and enough combat feedback to identify what happened. |
| Demo and handoff | Repository source, steps to flash and start the board, Android install and browser launch instructions, and recorded results from the final tests. |

## First playable milestone

Start with a single move and temporary fighter data. Once two clients can see the same turn resolve on the board, build out the roster and finish the match flow. Single-player AI and internet matchmaking are outside this release. Extra RGB hardware and elaborate animations are optional.

## Battle design and system architecture

The five fighters share six stats. HP measures health and MP pays for abilities. The four combat attributes are physical attack (ATK), defense (DEF), arcana (ARC), and speed (SPD). Fighter selection shows each combat attribute on a five-segment bar, with ten points per segment.

| Fighter | HP | MP | Signature strength and tradeoff | LED |
| --- | --- | --- | --- | --- |
| Jayden Kamikage | 350 | 150 | Hero • balanced at 30 in all four attributes | White |
| Lysander Goldwyn | 400 | 100 | Warrior • highest DEF, lowest SPD | Gold |
| Sophia Fuyuki | 270 | 200 | Sorceress • highest ARC, lowest ATK | Light blue |
| Zora Dreamer | 250 | 160 | Rogue • highest SPD, lowest ARC | Red |
| Damon Wolfbane | 230 | 90 | Warlord • highest ATK, lowest DEF | Purple |

### How the systems work together

**ESP32-S3 and C++.** The board must coordinate the match and keep the players in sync. The proposed design makes it the referee. It receives a move choice, checks the player, turn, and resource cost, calculates the effect once, then sends both clients the new state. After an accepted move, the firmware triggers the corresponding LED cue.

**Flutter and Dart.** Each Android phone displays the latest shared state and submits its player’s choice. Each player can read both fighters’ HP and MP, see when to wait, and tell why a move is unavailable.

**JavaScript and Node.js.** The browser client should speak the same match protocol. During development, Nicholas can use Node.js to simulate the board and serve the web files. The team will decide how to deliver those files locally and whether Node.js has any further runtime role. A portable Android match must run without a laptop server.

### Proposals to test

By November 30, Adrian will test a Wi-Fi-only match on the board using Nicholas’s sample turn. Adrian will ask the instructor whether players also need Bluetooth discovery and whether phones may use a preinstalled app or must download it from the cartridge.

Try SPD for the opening move only. For example, Zora would open against Lysander, then the turn would pass to him. Adrian will settle speed ties, physical and arcana damage, defense scaling, move costs and effects, and how players can act when MP runs low. Remaining values stay editable during playtesting.

## Team assignments and milestones

These proposed assignments build on the team’s CRM experience. Adrian owns game design and physical board work through November 30. Mina can build the screens with sample turns from Nicholas while Adrian tests the hardware.

**Adrian / Project lead, game design, and firmware.** Own the five fighters’ appearances, stats, moves, and balance data. Bring up the board, learn the Flutter connection flow with Mina, and implement the chosen match logic and LED cue. Measure the board and send the instructor a cartridge design for printing.

**Mina / Android and web interfaces.** Carry the moonlit, blue-and-silver menu concept through fighter selection, battle, and results. Build both interfaces against Nicholas’s sample messages, then connect them to the board. Own phone readability, browser controls, and the client launch instructions.

**Nicholas / Multiplayer sessions and validation.** Define how a player joins, submits a move, and receives a turn result or disconnect notice. Build the Node.js test host and test cases for invalid actions. With Adrian, verify that the firmware enforces the same rules. Own integration test records.

### Proposed schedule

| Target | Work to demonstrate or hand off |
| --- | --- |
| Nov 24–26 | Adrian flashes the board, measures it, and checks USB power and RGB. Mina builds menu and battle mockups. Nicholas shares sample join, move, and state messages. |
| Nov 27–30 | Adrian runs all board tests and targets one accepted move visible on two clients. Mina and Nicholas test against the simulator. Adrian shares flash steps, a sample turn, and dimensions for the print. |
| Dec 1–3 | Integrate with two Android phones and run a match to victory. Test the browser’s local connection and select a launch method. Adrian supplies provisional values for all 20 move slots. |
| Dec 4–6 | Complete a browser match and playtest all five fighters. Tune costs and damage, verify LED feedback, and check the enclosure if the print is ready. |
| Dec 7 | Rehearse from a powered-off board using the README. Record results, fix demo blockers, and package the firmware and both clients. |
| Dec 8 | Submit the project and demonstrate Android and browser play. |

Adrian will verify access to a second Android phone before the two-phone test. A browser can stand in during early development. The Android demonstration requires two physical phones.

## Acceptance tests and delivery risks

Run these checks with the release candidate. Nicholas records the build, devices, steps, and observed result. Mina verifies both screens, and Adrian verifies the board state, LED behavior, and fighter data.

### Final demonstration checks

| Check | Pass condition |
| --- | --- |
| Portable Android match | From power-on, two Android phones join one match with internet and the laptop server disconnected. Players select fighters and exchange moves. After each move, both phones agree on HP, MP, and whose turn comes next. At knockout, the winner sees victory and the other player sees defeat. |
| Playable web version | Two independent browser sessions open the documented web build, join the same board, select fighters, take turns, and finish a match. Each player can identify the winner. |
| Rejected actions | Try an out-of-turn move, a repeated submission, a move with insufficient MP, and a third player joining a full match. Each is refused without changing either fighter’s HP or MP or advancing the turn. |
| Roster and feedback | Check all five fighters against the roster and exercise each fighter’s four moves at least once. Compare one physical and one arcana move to the approved rules. Observe at least one RGB cue on the board. |
| Interrupted match | Disconnect one player mid-turn. The remaining player sees the interruption and the match stops advancing. Both players can then start a fresh session. |
| Team handoff | A teammate follows the README to start the board and launch both clients. The enclosure design leaves the power connector and onboard LED accessible. |

### Risks and responses

**Browser access or installation fails offline.** Mina and Nicholas will try the intended browser and local address before polishing the interface. Adrian will confirm the Android install method with the instructor. Rehearse both launch paths on the demo devices.

**One board or a delayed print limits access.** Use recorded board messages to keep work moving between hardware sessions. Test on USB power early. Submit the print file promptly and keep the bare board available for the demo if printing slips.

**Balancing consumes integration time.** Use Jayden as the reference fighter. Keep move costs, effects, stats, and LED patterns editable. Adrian reviews scope changes with the team against the December 8 demo before adding optional work.
