# history_service

- [Description](#description)
- [Installation](#installation)
- [Implementation](#implementation)
- [Methods](#methods)

# Description
This library contains 3 simple functionalities that helps you manage any kind of history. (e.g. download history, search history, app logs...).

The way to use this library is creating an instance of [History main class](https://github.com/iruzo/history_service/blob/main/lib/history_service.dart) every time you want to use it and calling the methods. The functionalities will be executed in an isolated thread.

# Installation
In your pubspec.yaml root add:
```yaml
dependencies:
  history_service: ^1.0.1
```
then,
```dart
import 'package:history_service/history_service.dart';
```

# Implementation
```dart
History history = History();
history.add('pathToHistoryFolder', 'dataToStore');
```

# Methods
| Method        | Description                                    | Arguments                                             | Return type                |
|---------------|------------------------------------------------|-------------------------------------------------------|----------------------------|
| Add           | Add entry to history                           | String historyFolderPath, String entry                | ```void```                 |
| Read          | Read history history using arguments as filter | String historyFolderPath, [String date, String entry] | ```Future<List<String>>``` |
| Delete        | Delete history using arguments as filter       | String historyFolderPath, [String date, String entry] | ```void```                 |
