const fighterName = 'Jayden Kamikage';
const resources = 'HP 350  •  MP 150';
const attributes = 'ATK 30  •  DEF 30  •  ARC 30  •  SPD 30';
const moves = [
  'X-Slash',
  'Radiant Light',
  'Crescent Fang',
  'Luminescent Shadow',
];

class TurnTest {
  bool joined = false;
  int turn = 1;
  int revision = 0;
  String lastMove = '';

  bool select(int player, String move, int expectedRevision) {
    if (!joined ||
        turn != player ||
        revision != expectedRevision ||
        !moves.contains(move)) {
      return false;
    }
    lastMove = 'Player $player selected $move.';
    turn = 3 - player;
    revision++;
    return true;
  }

  String status(int player) {
    if (!joined) return 'Waiting for Player 2 to join…';
    final prompt = turn == player ? 'Your turn.' : "Player $turn’s turn…";
    return lastMove.isEmpty ? prompt : '$lastMove $prompt';
  }
}
