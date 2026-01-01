import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key});

  @override
  State<ClassesScreen> createState() => ClassesScreenState();
}

class ClassesScreenState extends State<ClassesScreen> {
  final List<Map<String, dynamic>> _classes = [
    {'name': 'Jovens', 'studentCount': 42, 'ageRange': '15-24 anos'},
    {'name': 'Senhoras', 'studentCount': 28, 'ageRange': '25-59 anos'},
    {'name': 'Adolescentes', 'studentCount': 35, 'ageRange': '12-14 anos'},
    {'name': 'Juniores', 'studentCount': 24, 'ageRange': '9-11 anos'},
    {'name': 'Primários', 'studentCount': 18, 'ageRange': '6-8 anos'},
    {'name': 'Berçário', 'studentCount': 12, 'ageRange': '0-5 anos'},
    {'name': 'Adultos', 'studentCount': 55, 'ageRange': '25+ anos'},
  ];

  void _showAddClassModal() {
    final nameController = TextEditingController();
    final minAgeController = TextEditingController();
    final maxAgeController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nova turma',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome da turma',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: minAgeController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: 'Idade (de)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: maxAgeController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: 'Idade (até)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.check),
                  label: const Text('Adicionar'),
                  onPressed: () {
                    final name = nameController.text.trim();
                    final minText = minAgeController.text.trim();
                    final maxText = maxAgeController.text.trim();
                    if (name.isEmpty) return;

                    String ageRange = '';
                    if (minText.isNotEmpty && maxText.isNotEmpty) {
                      ageRange =
                          '${minText.padLeft(0)}–${maxText.padLeft(0)} anos';
                    } else if (minText.isNotEmpty) {
                      ageRange = 'a partir de ${minText} anos';
                    } else if (maxText.isNotEmpty) {
                      ageRange = 'até ${maxText} anos';
                    }

                    setState(() {
                      _classes.insert(0, {
                        'name': name,
                        'studentCount': 0,
                        'ageRange': ageRange,
                      });
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void openAddClass() {
    _showAddClassModal();
  }

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
        itemCount: _classes.length,
        itemBuilder: (context, index) {
          final classItem = _classes[index];

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
                child: Builder(
                  builder: (context) {
                    final ageRange = (classItem['ageRange'] as String?) ?? '';
                    final text = ageRange.isNotEmpty
                        ? '${classItem['studentCount']} Alunos • $ageRange'
                        : '${classItem['studentCount']} Alunos';
                    return Text(
                      text,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    );
                  },
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
