import 'package:flutter_test/flutter_test.dart';
import 'package:retro_fighter/main.dart';

void main() {
  testWidgets('Jayden can select X-Slash', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Jayden Kamikage'), findsOneWidget);
    expect(find.text('HP 350  •  MP 150'), findsOneWidget);
    expect(find.text('Choose a move'), findsOneWidget);

    expect(
      find.text('ATK 30  •  DEF 30  •  ARC 30  •  SPD 30'),
      findsOneWidget,
    );
    expect(find.text('Radiant Light'), findsOneWidget);
    expect(find.text('Crescent Fang'), findsOneWidget);
    expect(find.text('Luminescent Shadow'), findsOneWidget);
    await tester.tap(find.text('X-Slash'));
    await tester.pump();
    expect(find.text('Choose a move'), findsNothing);
    expect(find.text('X-Slash'), findsNWidgets(2));
  });
}
