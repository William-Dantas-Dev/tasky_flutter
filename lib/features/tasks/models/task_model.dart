enum TaskFrequency { daily, weekly }

enum TaskPriority { low, medium, high }

class TaskModel {
  final String id;
  final String name;
  final DateTime? time;
  final TaskFrequency frequency;

  /// 1 = segunda ... 7 = domingo
  /// Usado apenas se frequency == weekly
  final List<int> weekDays;

  final TaskPriority priority;
  final bool isDone;

  const TaskModel({
    required this.id,
    required this.name,
    required this.frequency,
    required this.priority,
    this.time,
    this.weekDays = const [],
    this.isDone = false,
  });

  TaskModel copyWith({
    String? id,
    String? name,
    DateTime? time,
    TaskFrequency? frequency,
    List<int>? weekDays,
    TaskPriority? priority,
    bool? isDone,
  }) {
    return TaskModel(
      id: id ?? this.id,
      name: name ?? this.name,
      time: time ?? this.time,
      frequency: frequency ?? this.frequency,
      weekDays: weekDays ?? this.weekDays,
      priority: priority ?? this.priority,
      isDone: isDone ?? this.isDone,
    );
  }

  TaskModel toggleDone() {
    return copyWith(isDone: !isDone);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'time': time?.toIso8601String(),
      'frequency': frequency.name,
      'weekDays': weekDays,
      'priority': priority.name,
      'isDone': isDone,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      name: map['name'],
      time: map['time'] != null ? DateTime.parse(map['time']) : null,
      frequency: TaskFrequency.values.firstWhere(
        (e) => e.name == map['frequency'],
      ),
      weekDays: (map['weekDays'] as List?)
              ?.map((e) => int.parse(e.toString()))
              .toList() ??
          [],
      priority: TaskPriority.values.firstWhere(
        (e) => e.name == map['priority'],
      ),
      isDone: map['isDone'] ?? false,
    );
  }
}