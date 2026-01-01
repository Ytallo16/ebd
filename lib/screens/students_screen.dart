import 'package:flutter/material.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  // Dados mockados de alunos
  static final List<Map<String, String>> _mockStudents = [
    {'name': 'Ana Silva', 'class': 'Jovens'},
    {'name': 'Carlos Oliveira', 'class': 'Adultos'},
    {'name': 'Maria Santos', 'class': 'Senhoras'},
    {'name': 'Pedro Costa', 'class': 'Adolescentes'},
    {'name': 'Juliana Souza', 'class': 'Jovens'},
    {'name': 'Roberto Alves', 'class': 'Adultos'},
    {'name': 'Fernanda Lima', 'class': 'Senhoras'},
    {'name': 'Lucas Pereira', 'class': 'Juniores'},
    {'name': 'Beatriz Rocha', 'class': 'Adolescentes'},
    {'name': 'Gabriel Martins', 'class': 'Jovens'},
    {'name': 'Amanda Ferreira', 'class': 'Primários'},
    {'name': 'Ricardo Gomes', 'class': 'Adultos'},
    {'name': 'Patrícia Dias', 'class': 'Senhoras'},
    {'name': 'Thiago Araújo', 'class': 'Jovens'},
    {'name': 'Larissa Cardoso', 'class': 'Adolescentes'},
    {'name': 'Felipe Ribeiro', 'class': 'Juniores'},
    {'name': 'Camila Barbosa', 'class': 'Adultos'},
    {'name': 'Bruno Mendes', 'class': 'Jovens'},
  ];

  Color _getColorFromName(String name) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.cyan,
    ];
    return colors[name.hashCode % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _mockStudents.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final student = _mockStudents[index];
        final color = _getColorFromName(student['name']!);

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 4,
          ),
          leading: CircleAvatar(
            backgroundColor: color,
            child: Text(
              student['name']![0].toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            student['name']!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              student['class']!,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: Colors.grey,
          ),
        );
      },
    );
  }
}
