import 'package:flutter/material.dart';
import 'lessons_screen.dart';
import 'classes_screen.dart';
import 'students_screen.dart';
import 'dashboard_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    LessonsScreen(),
    ClassesScreen(),
    StudentsScreen(),
    DashboardScreen(),
  ];

  final List<String> _titles = const ['Lições', 'Turmas', 'Alunos', 'Painel'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0B4C86),
        surfaceTintColor: Colors.transparent,
        title: Row(
          children: [
            SizedBox(
              height: 36,
              width: 36,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF0B4C86),
                  ),
                  child: const Center(
                    child: Text(
                      'AD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'EBD',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF0B4C86),
              ),
            ),
          ],
        ),
        elevation: 2,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Turmas'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Cadastros',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Painel'),
        ],
      ),
    );
  }
}
