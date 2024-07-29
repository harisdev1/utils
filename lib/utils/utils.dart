String getDurationString(DateTime start, DateTime end) {
  final duration = end.difference(start);
  final hours = duration.inHours;
  final minutes = duration.inMinutes % 60;

  if (hours > 0 && minutes > 0) {
    return '$hours Hours $minutes Minutes';
  } else if (hours > 0) {
    return '$hours Hours';
  } else if (minutes > 0) {
    return '$minutes Minutes';
  } else {
    return '0 Minutes';
  }
}
