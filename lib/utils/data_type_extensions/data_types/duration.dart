part of '../data_type_extensions.dart';

extension DurationExtension on Duration {
  String get toFormattedTimer {
    final hours = inMinutes
        .remainder(Duration.hoursPerDay)
        .toString()
        .padLeft(2, '0');
    final minutes = inMinutes
        .remainder(Duration.minutesPerHour)
        .toString()
        .padLeft(2, '0');
    final seconds = inSeconds
        .remainder(Duration.secondsPerMinute)
        .toString()
        .padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }
}
