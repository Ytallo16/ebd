import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({super.key});

  @override
  State<LessonsScreen> createState() => LessonsScreenState();
}

class LessonsScreenState extends State<LessonsScreen> {
  // Dados mockados de lições
  final List<Map<String, dynamic>> _lessons = [
    {
      'number': 12,
      'dayOfWeek': 'Domingo',
      'date': '05/01/2026',
      'present': 35,
      'absent': 5,
    },
    {
      'number': 11,
      'dayOfWeek': 'Domingo',
      'date': '29/12/2025',
      'present': 38,
      'absent': 2,
    },
    {
      'number': 10,
      'dayOfWeek': 'Domingo',
      'date': '22/12/2025',
      'present': 32,
      'absent': 8,
    },
    {
      'number': 9,
      'dayOfWeek': 'Domingo',
      'date': '15/12/2025',
      'present': 37,
      'absent': 3,
    },
    {
      'number': 8,
      'dayOfWeek': 'Domingo',
      'date': '08/12/2025',
      'present': 36,
      'absent': 4,
    },
    {
      'number': 7,
      'dayOfWeek': 'Domingo',
      'date': '01/12/2025',
      'present': 33,
      'absent': 7,
    },
  ];

  double _calculateAttendancePercentage(int present, int absent) {
    final total = present + absent;
    if (total == 0) return 0;
    return (present / total) * 100;
  }

  void _showAddLessonModal() {
    int selectedNumber = 1;
    DateTime? selectedDate;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 20,
          ),
          child: StatefulBuilder(
            builder: (ctx, setModalState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Nova Lição',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.confirmation_number, color: Colors.grey),
                      const SizedBox(width: 12),
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () => setModalState(() {
                          if (selectedNumber > 1) selectedNumber--;
                        }),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Text(
                          selectedNumber.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () => setModalState(() {
                          if (selectedNumber < 13) selectedNumber++;
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.calendar_today),
                    title: Text(
                      selectedDate == null
                          ? 'Selecionar data'
                          : '${selectedDate!.day.toString().padLeft(2, '0')}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.year}',
                    ),
                    onTap: () async {
                      final now = DateTime.now();
                      final picked = await showDatePicker(
                        context: ctx,
                        initialDate: now,
                        firstDate: DateTime(now.year - 5),
                        lastDate: DateTime(now.year + 5),
                      );
                      if (picked != null) {
                        setModalState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (selectedDate == null) {
                        Navigator.of(ctx).pop();
                        return;
                      }
                      setState(() {
                        _lessons.insert(0, {
                          'number': selectedNumber,
                          'dayOfWeek': 'Data',
                          'date':
                              '${selectedDate!.day.toString().padLeft(2, '0')}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.year}',
                          'present': 0,
                          'absent': 0,
                        });
                      });
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Adicionar'),
                  ),
                  const SizedBox(height: 12),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void openAddLesson() {
    _showAddLessonModal();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _lessons.length,
        itemBuilder: (context, index) {
          final lesson = _lessons[index];
          final percentage = _calculateAttendancePercentage(
            lesson['present'],
            lesson['absent'],
          );

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título e Data
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lição ${lesson['number']}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0B4C86),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: percentage >= 80
                              ? Colors.green.shade100
                              : Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${percentage.toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: percentage >= 80
                                ? Colors.green.shade800
                                : Colors.orange.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${lesson['dayOfWeek']} - ${lesson['date']}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 12),

                  // Métricas
                  Row(
                    children: [
                      _buildMetric(
                        Icons.check_circle,
                        '${lesson['present']} Presentes',
                        Colors.green,
                      ),
                      const SizedBox(width: 16),
                      _buildMetric(
                        Icons.cancel,
                        '${lesson['absent']} Ausentes',
                        Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMetric(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
      ],
    );
  }
}
