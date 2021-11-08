///

class DatabaseSchema {
  /// Database
  static const String name = 'todos.db';

  /// Task
  static const String tableTaskCreate = '''
    CREATE TABLE IF NOT EXISTS ${TableTask.name} (
      ${TableTask.columnID} INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      ${TableTask.columnTitle} TEXT,
      ${TableTask.columnFlag} INTEGER,
      ${TableTask.columnCreationTime} NUMERIC DEFAULT (-1),
      ${TableTask.columnUpdateTime} NUMERIC DEFAULT (-1),
      ${TableTask.columnEndTime} NUMERIC DEFAULT (-1)
    );
  ''';
  static const String tableTaskDrop = '''
    DROP TABLE IF EXISTS ${TableTask.name};
  ''';
}

class TableTask {
  static const String name = 'Task';

  static const String columnID = 'ID';
  static const String columnTitle = 'Title';
  static const String columnFlag = 'Flag';
  static const String columnCreationTime = 'CreationTime';
  static const String columnUpdateTime = 'UpdateTime';
  static const String columnEndTime = 'EndTime';
}
