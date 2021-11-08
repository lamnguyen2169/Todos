/// https://api.dart.dev/stable/2.13.4/dart-core/DateTime-class.html
/// https://nsdateformatter.com

import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  /// MARK: - Getter/Setter
  bool get isYesterday {
    final DateTime yesterday = DateTimeExtensions.yesterday();

    if ((this.year == yesterday.year) && (this.month == yesterday.month) && (this.day == yesterday.day)) {
      return true;
    }

    return false;
  }

  bool get isToday {
    final DateTime today = DateTime.now();

    if ((this.year == today.year) && (this.month == today.month) && (this.day == today.day)) {
      return true;
    }

    return false;
  }

  bool get isTomorrow {
    final DateTime tomorrow = DateTimeExtensions.tomorrow();

    if ((this.year == tomorrow.year) && (this.month == tomorrow.month) && (this.day == tomorrow.day)) {
      return true;
    }

    return false;
  }

  bool get isCurrentMonth {
    final DateTime today = DateTime.now();

    if ((this.year == today.year) && (this.month == today.month)) {
      return true;
    }

    return false;
  }

  bool get isCurrentYear {
    final DateTime today = DateTime.now();

    if (this.year == today.year) {
      return true;
    }

    return false;
  }

  /// MARK: - Public methods
  static DateTime yesterday() {
    final DateTime today = DateTime.now().dateByClearTime();

    return today.add(Duration(seconds: -86400));
  }

  static DateTime tomorrow() {
    final DateTime today = DateTime.now().dateByClearTime();

    return today.add(Duration(seconds: 86400));
  }

  DateTime dateByClearTime() {
    return DateTime(this.year, this.month, this.day);
  }

  int daysFromDate(DateTime? date) {
    if (date is DateTime) {
      return this.difference(date).inDays;
    }

    return this.difference(DateTime.fromMillisecondsSinceEpoch(0)).inDays;
  }

  int hoursFromDate(DateTime? date) {
    if (date is DateTime) {
      return this.difference(date).inHours;
    }

    return this.difference(DateTime.fromMillisecondsSinceEpoch(0)).inHours;
  }

  int minutesFromDate(DateTime? date) {
    if (date is DateTime) {
      return this.difference(date).inMinutes;
    }

    return this.difference(DateTime.fromMillisecondsSinceEpoch(0)).inMinutes;
  }

  int secondsFromDate(DateTime? date) {
    if (date is DateTime) {
      return this.difference(date).inSeconds;
    }

    return this.difference(DateTime.fromMillisecondsSinceEpoch(0)).inSeconds;
  }

  String string(String format) {
    return DateFormat(format).format(this);
  }

  String timeString([String? customFormat]) {
    String format = (customFormat != null) ? customFormat : 'E, MMM dd, yyyy';

    if (customFormat == null) {
      if (this.isCurrentYear) {
        if (this.isToday) {
          format = 'hh:mm a';
        } else {
          format = 'E, MMM dd';
        }
      }
    }

    return this.string(format);
  }
}
