part of '../data_type_extensions.dart';

extension on Jiffy {
  DateTime get dateTimeInUtc {
    return toUtc().dateTime;
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String get formattedTime {
    final dt = DateTime(0, 1, 1, hour, minute);
    return Jiffy.parseFromDateTime(dt).format(pattern: 'h:mm a');
  }

  String get formattedTimeTrain {
    final dt = DateTime(0, 1, 1, hour, minute);
    return Jiffy.parseFromDateTime(dt).format(pattern: 'HH:mm');
  }
}

extension DateTimeExtension on DateTime {
  DateTime get toLocalTime {
    return toLocal();
  }

  Jiffy get jiffyTime {
    return Jiffy.parseFromDateTime(toLocalTime);
  }

  DateTime get toStartOfDay {
    final date = jiffyTime.startOf(Unit.day).dateTimeInUtc;

    return date;
  }

  DateTime get toStartOfMonth {
    final date = jiffyTime.startOf(Unit.month).dateTimeInUtc;

    return date;
  }

  DateTime get toStartOfNextMonth {
    final date = jiffyTime.add(months: 1).startOf(Unit.month).dateTimeInUtc;
    return date;
  }

  DateTime get toEndOfDay {
    final date = jiffyTime.endOf(Unit.day).dateTimeInUtc;
    return date;
  }

  bool get isTodayDate {
    final now = DateTime.now();

    final isSameDate = isSame(now, Unit.day);

    return isSameDate;
  }

  bool isSame(DateTime date, [Unit units = Unit.millisecond]) {
    final isSame = this.isSame(date.toLocalTime, units);

    return isSame;
  }

  String get formattedDate {
    return formattedDateAsDateMonYear;
  }

  String get formattedDateAsDateMonYear {
    final formattedDate = jiffyTime.format(pattern: 'dd MMM yyyy');

    return formattedDate;
  }

  String get formattedDateTime {
    final formattedDate = jiffyTime.format(pattern: 'MMM dd yyyy hh:mm:ss a');

    return formattedDate;
  }

  String get formattedDateAsWeek {
    final formatted = jiffyTime.format(pattern: 'EEE');

    return formatted;
  }

  String get formattedDateAsMonYear {
    final formattedDate = jiffyTime.format(pattern: 'MMM yyyy');

    return formattedDate;
  }

  String get formattedDateAsMonthDateYear {
    final formattedDate = jiffyTime.format(pattern: 'MMMM d, yyyy');

    return formattedDate;
  }

  String get formattedDateAsDateMonth {
    final formattedDate = jiffyTime.format(pattern: 'd MMM');

    return formattedDate;
  }

  String get formattedDateAsYearMonthDate {
    final formattedDate = jiffyTime.format(pattern: 'yyyy-MM-dd');

    return formattedDate;
  }

  String get overFormattedDate {
    if (isTodayDate) {
      return 'Today';
    } else {
      return formattedDate;
    }
  }

  String get formattedTime {
    final formattedTime = jiffyTime.format(pattern: 'h:mm a');

    return formattedTime;
  }

  bool get isAfterNow {
    final now = DateTime.now();

    return toLocalTime.isAfter(now);
  }

  bool get isBeforeNow {
    final now = DateTime.now();

    return toLocalTime.isBefore(now);
  }

  DateTime subtractInDate({
    Duration duration = Duration.zero,
    int years = 0,
    int months = 0,
    int weeks = 0,
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliseconds = 0,
    int microseconds = 0,
  }) {
    final newDateTime = jiffyTime
        .subtract(
          years: years,
          months: months,
          weeks: weeks,
          days: days,
          hours: hours,
          minutes: minutes,
          seconds: seconds,
          milliseconds: milliseconds,
          microseconds: microseconds,
        )
        .dateTime;

    return newDateTime;
  }

  DateTime addInDate({
    Duration duration = Duration.zero,
    int years = 0,
    int months = 0,
    int weeks = 0,
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliseconds = 0,
    int microseconds = 0,
  }) {
    final newDateTime = jiffyTime
        .add(
          years: years,
          months: months,
          weeks: weeks,
          days: days,
          hours: hours,
          minutes: minutes,
          seconds: seconds,
          milliseconds: milliseconds,
          microseconds: microseconds,
        )
        .dateTime;

    return newDateTime;
  }

  num diff(
    DateTime passedDate, [
    Unit units = Unit.millisecond,
    bool asFloat = false,
  ]) {
    final diff = passedDate.jiffyTime.diff(
      jiffyTime,
      unit: units,
      asFloat: asFloat,
    );
    return diff;
  }

  TimeOfDay get timeOfDay {
    final timeOfDay = TimeOfDay.fromDateTime(this);

    return timeOfDay;
  }

  DateTime toTimeOfDay(TimeOfDay time) {
    final date = toStartOfDay.addInDate(hours: time.hour, minutes: time.minute);
    return date;
  }

  String formattedTimeOfDayAsTime(TimeOfDay time) {
    final dt = DateTime(0, 1, 1, time.hour, time.minute);
    String formatted = dt.formattedTime;
    return formatted;
  }

  String get formattedDateAsDateMonthYear {
    final formattedDate = jiffyTime.format(pattern: 'dd/MM/yyyy');

    return formattedDate;
  }
}
