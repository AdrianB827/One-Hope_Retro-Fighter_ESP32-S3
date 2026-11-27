import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'turn_test.dart';

const canHost = true;

String _token() {
  final random = Random.secure();
  return base64Url.encode(List.generate(12, (_) => random.nextInt(256)));
}

class TestHost {
  TestHost._(this._server, this._changed, this.urls);
  final HttpServer _server;
  final void Function() _changed;
  final List<String> urls;
  final game = TurnTest();
  final _session = _token();

  static Future<TestHost> start(void Function() changed) async {
    final interfaces = await NetworkInterface.list(
      type: InternetAddressType.IPv4,
    );
    final addresses = interfaces.expand((i) => i.addresses).toList();
    if (addresses.isEmpty) {
      throw StateError('Connect this phone to Wi-Fi first.');
    }
    final server = await HttpServer.bind(InternetAddress.anyIPv4, 0);
    final host = TestHost._(server, changed, [
      for (final a in addresses) 'http://${a.address}:${server.port}',
    ]);
    server.listen(host._handle);
    return host;
  }

  Future<void> close() => _server.close(force: true);

  Future<void> _handle(HttpRequest request) async {
    final response = request.response;
    response.headers.set('Cache-Control', 'no-store');
    final path = request.uri.path;
    final guest = request.cookies.any(
      (c) => c.name == 'player' && c.value == _session,
    );
    try {
      if (request.method == 'GET' && path == '/') {
        response.headers.contentType = ContentType.html;
        response.write(_page);
      } else if (request.method == 'POST' &&
          request.headers.value('X-Turn-Test') == '1' &&
          path == '/join') {
        if (game.joined && !guest) {
          response.statusCode = 409;
          response.write('Both player slots are in use.');
        } else {
          game.joined = true;
          response.cookies.add(
            Cookie('player', _session)
              ..httpOnly = true
              ..sameSite = SameSite.strict
              ..path = '/',
          );
          _changed();
        }
      } else if (!guest) {
        response.statusCode = 403;
        response.write('Join as Player 2 first.');
      } else if (request.method == 'GET' && path == '/state') {
        response.headers.contentType = ContentType.json;
        response.write(
          jsonEncode({
            'revision': game.revision,
            'active': game.turn == 2,
            'status': game.status(2),
          }),
        );
      } else if (request.method == 'POST' &&
          request.headers.value('X-Turn-Test') == '1' &&
          path == '/move') {
        final params = request.uri.queryParameters;
        if (!game.select(
          2,
          params['move'] ?? '',
          int.tryParse(params['revision'] ?? '') ?? -1,
        )) {
          response.statusCode = 409;
        } else {
          _changed();
        }
      } else {
        response.statusCode = 404;
      }
    } finally {
      await response.close();
    }
  }
}

final _page =
    '''<!doctype html><html lang="en"><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>One Hope: Retro Fighter</title>
<style>body{font:1rem/1.5 system-ui;background:#f5f9ff;color:#122b49;max-width:32rem;margin:2rem auto;padding:0 1rem}button{font:inherit;margin:.3rem;padding:.6rem 1rem;border:0;border-radius:.6rem;color:white;background:#0066cc}button:disabled{opacity:.5}</style>
<h1>One Hope: Retro Fighter</h1><h2>$fighterName</h2><p>$resources<br>$attributes</p>
<button id="join">Join as Player 2</button><p id="status" role="status"></p><div id="moves" hidden>
${moves.map((m) => '<button disabled data-move="$m">$m</button>').join()}
</div><script>
const join = document.querySelector('#join'), statusText = document.querySelector('#status');
const buttons = [...document.querySelectorAll('[data-move]')];
let revision = 0;
const post = path => fetch(path, {method:'POST', headers:{'X-Turn-Test':'1'}});
function lock() { buttons.forEach(b => b.disabled = true); }
async function state() {
  const res = await fetch('/state', {cache:'no-store'});
  if (!res.ok) throw Error('Session ended. Reopen the address on Player 1’s screen.');
  const s = await res.json();
  revision = s.revision;
  statusText.textContent = s.status;
  buttons.forEach(b => b.disabled = !s.active);
}
let sending = false;
async function poll() {
  try { if (!sending) await state(); }
  catch { lock(); statusText.textContent = 'Connection lost. Check Player 1 and Wi-Fi.'; }
  setTimeout(poll, 700);
}
join.onclick = async () => {
  join.disabled = true;
  try {
    const r = await post('/join');
    if (!r.ok) throw Error(await r.text());
    join.hidden = true; document.querySelector('#moves').hidden = false; poll();
  } catch (e) { statusText.textContent = e.message; join.disabled = false; }
};
buttons.forEach(b => b.onclick = async () => {
  if (sending) return;
  sending = true; lock();
  try { await post('/move?revision='+revision+'&move='+encodeURIComponent(b.dataset.move)); }
  catch { statusText.textContent = 'Connection lost. Checking the turn…'; }
  finally { sending = false; }
});
</script></html>''';
