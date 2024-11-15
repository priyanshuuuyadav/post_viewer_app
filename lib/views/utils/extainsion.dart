extension SecondsToTimeFormat on int {
  String toMinSec() {
    int minutes = this ~/ 60; // Integer division to get minutes
    int seconds = this % 60;  // Remainder is the seconds

    // Format minutes and seconds to always show two digits
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} m';
  }
}