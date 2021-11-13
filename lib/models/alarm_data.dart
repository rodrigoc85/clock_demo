class AlarmData {
  String id; // = "${DateTime.now().millisecondsSinceEpoch}";
  int hours;
  int minutes;
  bool repeats;
  bool enabled;

  AlarmData({
    required this.id,
    required this.hours,
    required this.minutes,
    required this.repeats,
    required this.enabled,
  });

  update(AlarmData newData) {
    this.id = newData.id;
    this.hours = newData.hours;
    this.minutes = newData.minutes;
    this.repeats = newData.repeats;
    this.enabled = newData.enabled;
  }

  AlarmData copy() {
    return AlarmData(
        id: this.id,
        hours: this.hours,
        minutes: this.minutes,
        repeats: this.repeats,
        enabled: this.enabled);
  }
}
