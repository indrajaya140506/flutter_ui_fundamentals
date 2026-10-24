import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_fundamentals/tahap15_course_explorer.dart';

void main() {
  testWidgets('Course Data Manager tampil dengan navigasi', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CourseExplorerApp());

    expect(find.text('Course Data Manager'), findsOneWidget);
    expect(find.text('Home'), findsWidgets);
    expect(find.text('Courses'), findsWidgets);
    expect(find.text('Favorite'), findsWidgets);
    expect(find.text('Profile'), findsWidgets);
  });
}
