import 'package:flutter/material.dart';

const String studentName = 'Komang Indrajaya Darmawiguna';
const String studentId = '2455011001';

class Tahap11AdaptiveNavigationPage extends StatefulWidget {
  const Tahap11AdaptiveNavigationPage({super.key});

  @override
  State<Tahap11AdaptiveNavigationPage> createState() =>
      _Tahap11AdaptiveNavigationPageState();
}

class _Tahap11AdaptiveNavigationPageState
    extends State<Tahap11AdaptiveNavigationPage> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    CoursesScreen(),
    ProfileScreen(),
  ];

  void onDestinationSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget buildNavigationBar() {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.school_outlined),
          selectedIcon: Icon(Icons.school),
          label: 'Courses',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  Widget buildNavigationRail() {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      labelType: NavigationRailLabelType.all,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: Text('Home'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.school_outlined),
          selectedIcon: Icon(Icons.school),
          label: Text('Courses'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: Text('Profile'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Scaffold(
            appBar: AppBar(title: const Text('Tahap 11 - Adaptive Navigation')),
            body: pages[selectedIndex],
            bottomNavigationBar: buildNavigationBar(),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Tahap 11 - Adaptive Navigation')),
          body: Row(
            children: [
              buildNavigationRail(),
              const VerticalDivider(width: 1),
              Expanded(child: pages[selectedIndex]),
            ],
          ),
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home, size: 80),
            const SizedBox(height: 20),
            const Text(
              'Home',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              studentName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(studentId, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  final List<Map<String, String>> courses = const [
    {'code': 'MOB01', 'title': 'Git & GitHub', 'status': 'Done'},
    {'code': 'MOB02', 'title': 'Dart Fundamentals', 'status': 'Done'},
    {'code': 'MOB03', 'title': 'Flutter UI Fundamentals', 'status': 'Active'},
    {'code': 'MOB04', 'title': 'Navigation', 'status': 'Planned'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(child: Text(course['code']!.substring(3))),
            title: Text(
              course['title']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${course['code']} • ${course['status']}'),
          ),
        );
      },
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 55, child: Icon(Icons.person, size: 60)),
            const SizedBox(height: 24),
            const Text(
              studentName,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(studentId, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            const Text(
              'Software Engineering / TRPL',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
