import 'package:flutter/material.dart';
import '../../tasks/models/task_model.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatelessWidget {
  final TaskModel model;
  final ValueChanged<bool?> onChanged;

  const TaskTile({super.key, required this.model, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isDone = model.isDone;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 16,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          _RoundCheckbox(value: isDone, onChanged: onChanged),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1D2330),
                    decoration: isDone ? TextDecoration.lineThrough : null,
                    decorationThickness: 2,
                    decorationColor: const Color(
                      0xFF1D2330,
                    ).withValues(alpha: 0.25),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      model.time != null
                          ? DateFormat('dd/MM/yyyy • HH:mm').format(model.time!)
                          : 'Sem horário',
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF9AA1B2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          PriorityBadge(priority: model.priority),
        ],
      ),
    );
  }
}

class _RoundCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const _RoundCheckbox({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final bg = value ? const Color(0xFF5B6CFF) : const Color(0xFFE9ECF5);
    final iconColor = value ? Colors.white : const Color(0xFFB2B8C6);

    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(999),
      child: Container(
        height: 26,
        width: 26,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        child: Icon(Icons.check_rounded, size: 18, color: iconColor),
      ),
    );
  }
}

class PriorityBadge extends StatelessWidget {
  final TaskPriority priority;
  const PriorityBadge({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    late final Color bg;
    late final Color fg;
    late final String text;

    switch (priority) {
      case TaskPriority.high:
        bg = const Color(0xFFFFE3E3);
        fg = const Color(0xFFE53935);
        text = 'ALTA';
        break;
      case TaskPriority.medium:
        bg = const Color(0xFFFFEED8);
        fg = const Color(0xFFFF9800);
        text = 'MÉDIA';
        break;
      case TaskPriority.low:
        bg = const Color(0xFFDEF7EA);
        fg = const Color(0xFF10B981);
        text = 'BAIXA';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 6,
            width: 6,
            decoration: BoxDecoration(color: fg, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w900,
              color: fg,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
