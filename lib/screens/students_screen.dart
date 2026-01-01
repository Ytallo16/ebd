import 'package:flutter/material.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => StudentsScreenState();
}

class StudentsScreenState extends State<StudentsScreen> {
  final List<String> _classOptions = const [
    'Jovens',
    'Senhoras',
    'Adolescentes',
    'Juniores',
    'Primários',
    'Berçário',
    'Adultos',
  ];

  final List<Map<String, dynamic>> _students = [
    {
      'name': 'Ana Silva',
      'class': 'Jovens',
      'gender': 'Feminino',
      'isProfessor': false,
    },
    {
      'name': 'Carlos Oliveira',
      'class': 'Adultos',
      'gender': 'Masculino',
      'isProfessor': true,
    },
    {
      'name': 'Maria Santos',
      'class': 'Senhoras',
      'gender': 'Feminino',
      'isProfessor': false,
    },
    {
      'name': 'Pedro Costa',
      'class': 'Adolescentes',
      'gender': 'Masculino',
      'isProfessor': false,
    },
    {
      'name': 'Juliana Souza',
      'class': 'Jovens',
      'gender': 'Feminino',
      'isProfessor': false,
    },
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

  Future<Map<String, String>?> _showExtraDataModal({
    Map<String, String>? initial,
  }) {
    final birthController = TextEditingController(
      text: initial?['nascimento'] ?? '',
    );
    final phoneController = TextEditingController(
      text: initial?['telefone'] ?? '',
    );
    final emailController = TextEditingController(
      text: initial?['email'] ?? '',
    );
    final enrollController = TextEditingController(
      text: initial?['matricula'] ?? '',
    );
    final guardian1Controller = TextEditingController(
      text: initial?['responsavel1'] ?? '',
    );
    final guardian2Controller = TextEditingController(
      text: initial?['responsavel2'] ?? '',
    );

    Future<void> pickDate(TextEditingController controller) async {
      final now = DateTime.now();
      final picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(1950),
        lastDate: DateTime(now.year + 1),
      );
      if (picked != null) {
        controller.text =
            '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      }
    }

    return showModalBottomSheet<Map<String, String>>(
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dados extras',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: birthController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Nascimento',
                          border: OutlineInputBorder(),
                        ),
                        onTap: () => pickDate(birthController),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: enrollController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Data matrícula',
                          border: OutlineInputBorder(),
                        ),
                        onTap: () => pickDate(enrollController),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: guardian1Controller,
                  decoration: const InputDecoration(
                    labelText: 'Responsável 1',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: guardian2Controller,
                  decoration: const InputDecoration(
                    labelText: 'Responsável 2',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.check),
                    label: const Text('Salvar extras'),
                    onPressed: () {
                      Navigator.pop<Map<String, String>>(context, {
                        'nascimento': birthController.text.trim(),
                        'telefone': phoneController.text.trim(),
                        'email': emailController.text.trim(),
                        'matricula': enrollController.text.trim(),
                        'responsavel1': guardian1Controller.text.trim(),
                        'responsavel2': guardian2Controller.text.trim(),
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddStudentModal() {
    final nameController = TextEditingController();
    String? selectedGender;
    String? selectedClass;
    Map<String, String>? extraData;

    void saveStudent({required bool asProfessor}) {
      final name = nameController.text.trim();
      if (name.isEmpty || selectedClass == null || selectedGender == null) {
        return;
      }
      setState(() {
        _students.insert(0, {
          'name': name,
          'class': selectedClass!,
          'gender': selectedGender!,
          'isProfessor': asProfessor,
          'extras': extraData,
        });
      });
      Navigator.pop(context);
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Novo cadastro',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nome do aluno',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Sexo',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Masculino',
                          child: Text('Masculino'),
                        ),
                        DropdownMenuItem(
                          value: 'Feminino',
                          child: Text('Feminino'),
                        ),
                        DropdownMenuItem(value: 'Outro', child: Text('Outro')),
                      ],
                      value: selectedGender,
                      onChanged: (value) =>
                          setModalState(() => selectedGender = value),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Turma',
                        border: OutlineInputBorder(),
                      ),
                      items: _classOptions
                          .map(
                            (className) => DropdownMenuItem(
                              value: className,
                              child: Text(className),
                            ),
                          )
                          .toList(),
                      value: selectedClass,
                      onChanged: (value) =>
                          setModalState(() => selectedClass = value),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color(0xFF0B4C86),
                            ),
                            icon: const Icon(Icons.admin_panel_settings),
                            label: const Text('Cadastrar como professor'),
                            onPressed: () => saveStudent(asProfessor: true),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                            ),
                            icon: const Icon(Icons.person_add),
                            label: const Text('Cadastrar aluno'),
                            onPressed: () => saveStudent(asProfessor: false),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xFF0B4C86),
                          ),
                          icon: const Icon(Icons.list_alt),
                          label: const Text('Dados extras'),
                          onPressed: () async {
                            final result = await _showExtraDataModal(
                              initial: extraData,
                            );
                            if (result != null) {
                              setModalState(() => extraData = result);
                            }
                          },
                        ),
                        const SizedBox(width: 12),
                        if (extraData != null &&
                            extraData!.values.any((v) => v.isNotEmpty))
                          const Icon(Icons.check_circle, color: Colors.green),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void openAddStudent() {
    _showAddStudentModal();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
        ),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _students.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final student = _students[index];
          final color = _getColorFromName(student['name'] as String);
          final extras = student['extras'] as Map<String, String>?;

          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              leading: CircleAvatar(
                backgroundColor: color,
                child: Text(
                  (student['name'] as String)[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      student['name'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (student['isProfessor'] == true)
                    const Chip(
                      label: Text(
                        'Professor',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Color(0xFF0B4C86),
                      visualDensity: VisualDensity.compact,
                    ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${student['class']} • ${student['gender']}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    if (extras != null &&
                        extras['telefone'] != null &&
                        extras['telefone']!.isNotEmpty)
                      Text(
                        extras['telefone']!,
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                    if (extras != null &&
                        extras['email'] != null &&
                        extras['email']!.isNotEmpty)
                      Text(
                        extras['email']!,
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                  ],
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}
