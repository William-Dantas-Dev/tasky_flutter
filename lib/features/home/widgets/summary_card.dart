import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final double progress;
  final int totalTasks;
  final int doneTasks;

  const SummaryCard({
    super.key,
    required this.progress,
    required this.totalTasks,
    required this.doneTasks,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Resumo do Dia',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1D2330),
                  ),
                ),
              ),
              Text(
                '$percent%',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF5B6CFF),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                '$totalTasks tarefas totais',
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6D7485),
                ),
              ),
              const Spacer(),
              Text(
                '$doneTasks concluídas',
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6D7485),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _ProgressBar(value: progress),
          const SizedBox(height: 10),
          const Text(
            'Ótimo ritmo! Você está quase lá.',
            style: TextStyle(
              fontSize: 12.5,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              color: Color(0xFF9AA1B2),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double value;
  const _ProgressBar({required this.value});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: SizedBox(
        height: 10,
        child: Stack(
          children: [
            Container(color: const Color(0xFFE9ECF5)),
            FractionallySizedBox(
              widthFactor: value.clamp(0, 1),
              child: Container(color: const Color(0xFF5B6CFF)),
            ),
          ],
        ),
      ),
    );
  }
}