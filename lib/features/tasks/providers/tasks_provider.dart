import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

const _tasksKey = 'tasks_list_v1';

final tasksProvider = AsyncNotifierProvider<TasksNotifier, List<TaskModel>>(
  TasksNotifier.new,
);

class TasksNotifier extends AsyncNotifier<List<TaskModel>> {
  @override
  Future<List<TaskModel>> build() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_tasksKey);

    if (raw == null) return [];

    final decoded = jsonDecode(raw) as List;
    return decoded
        .map((e) => TaskModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> _save(List<TaskModel> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _tasksKey,
      jsonEncode(list.map((t) => t.toMap()).toList()),
    );
  }

  Future<void> addTask(TaskModel task) async {
    final current = await future; // pega a lista atual (carregada)
    final next = [...current, task];
    state = AsyncValue.data(next);
    await _save(next);
  }

  Future<void> toggleDone(String id) async {
    final current = await future;
    final next = [
      for (final t in current)
        if (t.id == id) t.toggleDone() else t,
    ];
    state = AsyncValue.data(next);
    await _save(next);
  }

  Future<void> removeTask(String id) async {
    final current = await future;
    final next = current.where((t) => t.id != id).toList();
    state = AsyncValue.data(next);
    await _save(next);
  }
}
