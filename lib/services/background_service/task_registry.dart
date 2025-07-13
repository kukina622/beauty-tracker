import 'package:beauty_tracker/services/background_service/task_keys.dart';

class TaskRegistry {
  factory TaskRegistry() => _instance;
  TaskRegistry._internal();
  static final TaskRegistry _instance = TaskRegistry._internal();

  final Map<String, Future<bool> Function(Map<String, dynamic>?)> _taskHandlers = {};

  void registerTaskHandler(
    TaskKeys taskKey,
    Future<bool> Function(Map<String, dynamic>?) handler,
  ) {
    _taskHandlers[taskKey.key] = handler;
  }

  Future<bool> Function(Map<String, dynamic>?)? getHandler(String taskKey) {
    return _taskHandlers[taskKey];
  }
}
