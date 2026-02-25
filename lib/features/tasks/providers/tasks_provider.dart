import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

const _tasksKey = 'tasks_list_v1';

final tasksProvider = NotifierProvider<TasksNotifier, List<TaskModel>>(
  TasksNotifier.new,
);

class TasksNotifier extends Notifier<List<TaskModel>> {
  @override
  List<TaskModel> build() {
    _load();
    return [];
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_tasksKey);

    if (raw == null) return;

    final decoded = jsonDecode(raw) as List;
    state = decoded
        .map((e) => TaskModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final list = state.map((t) => t.toMap()).toList();
    await prefs.setString(_tasksKey, jsonEncode(list));
  }

  Future<void> addTask(TaskModel task) async {
    state = [...state, task];
    await _save();
  }

  Future<void> toggleDone(String id) async {
    state = [
      for (final t in state)
        if (t.id == id) t.toggleDone() else t,
    ];
    await _save();
  }

  Future<void> removeTask(String id) async {
    state = state.where((t) => t.id != id).toList();
    await _save();
  }
}
