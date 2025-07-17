import 'package:beauty_tracker/services/background_service/task_key.dart';
import 'package:beauty_tracker/services/expiry_notification_service/expiry_notification_handler.dart';

typedef TaskHandler = Future<bool> Function(Map<String, dynamic>?);

class TaskRegistry {
  TaskRegistry._();

  static final Map<TaskKey, TaskHandler> _taskHandlers = {
    TaskKey.expireNotifications: ExpiryNotificationHandler.handle,
  };

  static TaskHandler? getHandler(TaskKey? taskKey) {
    if (taskKey == null) {
      return null;
    }
    return _taskHandlers[taskKey];
  }
}
