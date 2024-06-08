import 'package:intl/intl.dart';

class DateTimeHelper {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm').format(dateTime);
  }

  static String formatDurationFromInt(int durationInMinutes) {
    Duration duration = Duration(minutes: durationInMinutes);
    int hours = duration.inHours;
    int remainingMinutes = duration.inMinutes.remainder(60);
    int remainingSeconds = duration.inSeconds.remainder(60);

    String hoursString = hours.toString().padLeft(2, '0');
    String minutesString = remainingMinutes.toString().padLeft(2, '0');
    String secondsString = remainingSeconds.toString().padLeft(2, '0');

    return '$hoursString:$minutesString:$secondsString';
  }


  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    if (hours == "00") {
      return "$minutes:$seconds";
    } else if (minutes == "00") {
      return "$hours:$seconds";
    } else if (seconds == "00") {
      return "$hours:$minutes";
    } else if (hours == "00" && minutes == "00") {
      return seconds;
    } else if (hours == "00" && seconds == "00") {
      return minutes;
    } else if (minutes == "00" && seconds == "00") {
      return hours;
    } else if (hours == "00" && minutes == "00" && seconds == "00") {
      return "00:00:00";
    } else {
      return "$hours:$minutes:$seconds";
    }
  }
}
