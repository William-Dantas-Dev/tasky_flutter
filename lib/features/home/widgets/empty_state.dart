import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final VoidCallback onAdd;

  const EmptyState({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      alignment: Alignment.center,
      child: Column(
        children: [
          const Icon(Icons.inbox_rounded, size: 44, color: Color(0xFFB2B8C6)),
          const SizedBox(height: 10),
          const Text(
            'Nenhuma tarefa por aqui',
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1D2330),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Toque no + para adicionar sua primeira tarefa.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF9AA1B2),
            ),
          ),
        ],
      ),
    );
  }
}
