///

import 'dart:convert';

import '../database/database.dart';
import '../../extensions/extensions.dart';

class Task {
  int id;
  String title;
  bool isDone;
  DateTime creationTime;
  DateTime updateTime;
  DateTime? endTime;

  /// MARK: - Getter/Setter
  int get creationTimeInterval => this.creationTime.toUtc().millisecondsSinceEpoch;

  int get updateTimeInterval => this.updateTime.toUtc().millisecondsSinceEpoch;

  int get endTimeInterval => (this.endTime != null) ? this.endTime!.toUtc().millisecondsSinceEpoch : -1;

  String get timeString => (this.endTime != null) ? this.endTime!.timeString() : '';

  String get description => this.toJsonString();

  /// Constructors
  Task({
    this.id = -1,
    required this.title,
    this.isDone = false,
    required this.creationTime,
    required this.updateTime,
    this.endTime,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        title: json['title'],
        isDone: json['isDone'],
        creationTime: json['creationTime'],
        updateTime: json['updateTime'],
        endTime: json['endTime'],
      );

  factory Task.fromDBJson(Map<String, dynamic> json) => Task(
        id: json[TableTask.columnID],
        title: json[TableTask.columnTitle],
        isDone: json[TableTask.columnFlag] == 1,
        creationTime: DateTime.fromMillisecondsSinceEpoch(json[TableTask.columnCreationTime]),
        updateTime: DateTime.fromMillisecondsSinceEpoch(json[TableTask.columnUpdateTime]),
        endTime:
            (json[TableTask.columnEndTime] != -1) ? DateTime.fromMillisecondsSinceEpoch(json[TableTask.columnEndTime]) : null,
      );

  /// MARK: - override methods
  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

  @override
  bool operator ==(dynamic other) {
    return (other is Task) && (this.id == other.id);
  }

  /// MARK: - public methods
  Map<String, dynamic> toJson() => {
        'id': this.id,
        'title': this.title,
        'isDone': this.isDone,
        'creationTime': this.creationTime,
        'updateTime': this.updateTime,
        'endTime': this.endTime,
      };

  String toJsonString() => json.encode(this.toJson());

  Map<String, dynamic> toDBJson([bool updateTimeToNow = false]) {
    if (updateTimeToNow) this.updateTime = DateTime.now();

    return {
      TableTask.columnTitle: '${this.title}',
      TableTask.columnFlag: this.isDone ? 1 : 0,
      TableTask.columnCreationTime: this.creationTimeInterval,
      TableTask.columnUpdateTime: this.updateTimeInterval,
      TableTask.columnEndTime: this.endTimeInterval,
    };
  }

  String toDBJsonString() => json.encode(this.toDBJson());

  void done() {
    this.isDone = true;
  }

  void undone() {
    this.isDone = false;
  }
}
