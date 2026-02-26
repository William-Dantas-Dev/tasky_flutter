import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/summary_card.dart';
import '../widgets/segmented_toggle.dart';
import '../widgets/task_list_selection.dart';
import '../../tasks/models/task_model.dart';
import '../../tasks/providers/tasks_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;

  // 🔥 Liga/desliga mocks aqui
  final bool _useMockData = true;

  List<TaskModel> _mockTasks() {
    return [
      TaskModel(
        id: '1',
        name: 'Treinar musculação',
        frequency: TaskFrequency.daily,
        priority: TaskPriority.high,
        time: DateTime.now(),
        isDone: false,
      ),
      TaskModel(
        id: '2',
        name: 'Estudar Flutter',
        frequency: TaskFrequency.weekly,
        priority: TaskPriority.medium,
        weekDays: [1, 3, 5],
        time: DateTime.now(),
        isDone: true,
      ),
      TaskModel(
        id: '3',
        name: 'Ler 10 páginas',
        frequency: TaskFrequency.daily,
        priority: TaskPriority.low,
        isDone: false,
      ),
      TaskModel(
        id: '4',
        name: 'Cardio 30min',
        frequency: TaskFrequency.weekly,
        priority: TaskPriority.high,
        weekDays: [2, 4],
        time: DateTime.now(),
        isDone: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(tasksProvider);

    return SafeArea(
      child: tasksAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Erro ao carregar tarefas: $e',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (providerTasks) {
          final tasks = _useMockData ? _mockTasks() : providerTasks;

          final filteredTasks = tasks.where((task) {
            if (_selectedIndex == 0) {
              return task.frequency == TaskFrequency.daily;
            }
            return task.frequency == TaskFrequency.weekly;
          }).toList();

          final totalTasks = tasks.length;
          final doneTasks = tasks.where((t) => t.isDone).length;
          final progress = totalTasks == 0 ? 0.0 : (doneTasks / totalTasks);

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomAppBar(
                        greeting: 'Bom dia, William 👋',
                        subtitle: 'Segunda-feira, 12 de Outubro',
                      ),
                      const SizedBox(height: 16),
                      SummaryCard(
                        progress: progress,
                        totalTasks: totalTasks,
                        doneTasks: doneTasks,
                      ),
                      const SizedBox(height: 16),
                      SegmentedToggle(
                        index: _selectedIndex,
                        onChanged: (value) {
                          setState(() => _selectedIndex = value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              TasksSliverSection(tasks: filteredTasks),
            ],
          );
        },
      ),
    );
  }
}
