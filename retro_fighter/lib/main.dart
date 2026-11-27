import 'package:material_ui/material_ui.dart';

import 'test_host_stub.dart' if (dart.library.io) 'test_host_io.dart';
import 'turn_test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'One Hope: Retro Fighter';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: const Color(0xFF007FFF),
          primary: const Color(0xFF0066CC),
          onPrimary: Colors.white,
        ),
      ),
      home: const MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedMove = 'Choose a move';
  TestHost? _host;
  bool _starting = false;
  String? _error;

  Future<void> _startTest() async {
    setState(() {
      _starting = true;
      _error = null;
    });
    try {
      final host = await TestHost.start(() {
        if (mounted) setState(() {});
      });
      if (!mounted) {
        await host.close();
        return;
      }
      setState(() => _host = host);
    } catch (error) {
      if (mounted) {
        setState(() => _error = 'Could not host the test. Check Wi-Fi. $error');
      }
    } finally {
      if (mounted) setState(() => _starting = false);
    }
  }

  void _stopTest() {
    _host?.close();
    setState(() {
      _host = null;
      _selectedMove = 'Choose a move';
    });
  }

  @override
  void dispose() {
    _host?.close();
    super.dispose();
  }

  void _selectMove(String move) {
    setState(() {
      final game = _host?.game;
      if (game == null) {
        _selectedMove = move;
      } else {
        game.select(1, move, game.revision);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final host = _host;
    final active = host == null || (host.game.joined && host.game.turn == 1);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                fighterName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Text(resources),
              const Text(attributes),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final move in moves)
                    FilledButton(
                      onPressed: active ? () => _selectMove(move) : null,
                      child: Text(move),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(host?.game.status(1) ?? _selectedMove),
              if (host != null) ...[
                const SizedBox(height: 16),
                const Text(
                  'Player 1 · On the same Wi-Fi, open this address on Player 2’s phone:',
                ),
                for (final url in host.urls) SelectableText(url),
                TextButton(
                  onPressed: _stopTest,
                  child: const Text('End turn test'),
                ),
              ] else if (canHost)
                TextButton(
                  onPressed: _starting ? null : _startTest,
                  child: const Text('Host two-phone turn test'),
                ),
              if (_error != null) Text(_error!),
            ],
          ),
        ),
      ),
    );
  }
}
