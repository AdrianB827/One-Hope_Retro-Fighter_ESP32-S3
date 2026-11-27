import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:retro_fighter/test_host_io.dart';

void main() {
  test(
    'two players alternate; duplicate, stale and third-player requests fail',
    () async {
      final host = await TestHost.start(() {});
      addTearDown(host.close);
      final base = Uri.parse(host.urls.first).replace(host: '127.0.0.1');
      final client = HttpClient();
      addTearDown(() => client.close(force: true));
      Cookie? player;
      Future<HttpClientResponse> request(
        String method,
        String path, {
        bool guest = true,
      }) async {
        final req = await client.openUrl(method, base.resolve(path));
        req.headers.set('X-Turn-Test', '1');
        if (guest && player != null) req.cookies.add(player);
        return req.close();
      }

      Future<int> post(String path, {bool guest = true}) async {
        final res = await request('POST', path, guest: guest);
        await res.drain<void>();
        return res.statusCode;
      }

      expect(host.game.select(1, 'X-Slash', 0), isFalse);
      final join = await request('POST', '/join');
      expect(join.statusCode, 200);
      player = join.cookies.single;
      await join.drain<void>();
      expect(await post('/join', guest: false), 409);
      expect(await post('/move?move=X-Slash&revision=0'), 409);
      expect(host.game.select(1, 'X-Slash', 0), isTrue);
      expect(host.game.select(1, 'X-Slash', 1), isFalse);
      final state = await request('GET', '/state');
      final data = jsonDecode(await utf8.decoder.bind(state).join());
      expect(data['status'], 'Player 1 selected X-Slash. Your turn.');
      expect(await post('/move?move=Unknown&revision=1'), 409);
      expect(await post('/move?move=Crescent%20Fang&revision=1'), 200);
      expect(
        host.game.status(1),
        'Player 2 selected Crescent Fang. Your turn.',
      );
      expect(host.game.select(1, 'Radiant Light', 2), isTrue);
      expect(await post('/move?move=Crescent%20Fang&revision=1'), 409);
      expect(host.game.revision, 3);
    },
  );
}
