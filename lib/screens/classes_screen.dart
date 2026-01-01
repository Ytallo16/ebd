import 'package:flutter/material.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({super.key});

  // Dados mockados de turmas
  static final List<Map<String, dynamic>> _mockClasses = [
    {'name': 'Jovens', 'studentCount': 42},
    {'name': 'Senhoras', 'studentCount': 28},
    {'name': 'Adolescentes', 'studentCount': 35},
    {'name': 'Juniores', 'studentCount': 24},
    {'name': 'Primários', 'studentCount': 18},
    {'name': 'Berçário', 'studentCount': 12},
    {'name': 'Adultos', 'studentCount': 55},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _mockClasses.length,
        itemBuilder: (context, index) {
          final classItem = _mockClasses[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF0B4C86), Color(0xFF1976D2)],
                  ),
                ),
                child: Center(
                  child: Text(
                    classItem['name'][0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              title: Text(
                classItem['name'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '${classItem['studentCount']} Alunos',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}
