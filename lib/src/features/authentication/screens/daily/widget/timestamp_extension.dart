import 'package:cloud_firestore/cloud_firestore.dart';

extension TimestampExtension on Timestamp {
  bool isSameDate(DateTime other) {
    final date = toDate();
    return date.year == other.year && date.month == other.month && date.day == other.day;
  }
}

extension DateTimeExtension on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}