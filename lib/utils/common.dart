String convertSessionTime(String sessionTime) {
  int time = int.parse(sessionTime);
  String hour = ((time ~/ 60) % 12).toString();
  String minute = (time % 60).toString().padLeft(2, '0');
  String period = (time ~/ 60) < 12 ? 'AM' : 'PM';

  return '$hour:$minute $period';
}