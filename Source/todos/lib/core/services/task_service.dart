///

import 'dart:async';

import '../repositories/repositories.dart';
import '../models/models.dart';

import 'service.dart';

class TaskService extends Service {
  final TaskRepository _repository = TaskRepository();

  /// MARK: - Constructors
  TaskService();

  /// MARK: - Local methods

  /// MARK: - Public methods
  Future<List<Task>> fetchTasks() async {
    return _repository.fetchTasks();
  }

  Future<List<Task>> fetchUndoneTasks() async {
    return _repository.fetchUndoneTasks();
  }

  Future<List<Task>> fetchDoneTasks() async {
    return _repository.fetchDoneTasks();
  }

  Future<Task?> insertTask(Task task) async {
    return _repository.insertTask(task);
  }

  Future<bool> doneTask(Task task) async {
    task.done();

    return _repository.updateTask(task);
  }

  Future<bool> undoneTask(Task task) async {
    task.undone();

    return _repository.updateTask(task);
  }

  Future<bool> deleteTask(Task task) async {
    return _repository.deleteTask(task);
  }
}
