import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasky_app/features/home/widgets/empty_state.dart';
import 'package:tasky_app/features/home/widgets/task_tile.dart';
import 'package:tasky_app/features/tasks/models/task_model.dart';
import 'package:tasky_app/features/tasks/providers/tasks_provider.dart';

class TasksSliverSection extends ConsumerWidget {
  const TasksSliverSection({super.key, required this.tasks});

  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalTasks = tasks.length;

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
      sliver: totalTasks == 0
          ? SliverToBoxAdapter(
              child: EmptyState(
                onAdd: () {
                  // opcional: abrir modal/criar task
                },
              ),
            )
          : SliverList.separated(
              itemCount: tasks.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final t = tasks[i];
                return TaskTile(
                  key: ValueKey(t.id),
                  model: t,
                  onChanged: (val) {
                    ref.read(tasksProvider.notifier).toggleDone(t.id);
                  },
                );
              },
            ),
    );
  }
}
