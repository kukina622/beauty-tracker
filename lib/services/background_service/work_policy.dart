import 'package:workmanager/workmanager.dart';

enum WorkPolicy {
  keep,
  replace,
  append;

  ExistingWorkPolicy toWorkmanagerPolicy() {
    switch (this) {
      case WorkPolicy.keep:
        return ExistingWorkPolicy.keep;
      case WorkPolicy.replace:
        return ExistingWorkPolicy.replace;
      case WorkPolicy.append:
        return ExistingWorkPolicy.append;
    }
  }
}
