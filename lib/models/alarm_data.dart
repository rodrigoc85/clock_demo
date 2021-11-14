///
/// AlarmData:
/// It keeps the raw data of an alarm, and implements some transformations to
/// other formats.
///
class AlarmData {
  String id;
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

  AlarmData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        hours = json['hours'],
        minutes = json['minutes'],
        repeats = json['repeats'],
        enabled = json['enabled'];

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'hours': this.hours,
        'minutes': this.minutes,
        'repeats': this.repeats,
        'enabled': this.enabled,
      };
}
