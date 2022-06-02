const String tableHEActivity = 'he_activity';

class HEActivityField {
  static final List<String> values = [
    id, date, address, volunteer, heAttendeesList, male, female,
  ];

  static const String id = '_id';
  static const String date = 'date';
  static const String address = 'address';
  static const String volunteer = 'volunteer';
  static const String heAttendeesList = 'he_attendees_list';
  static const String male = 'male';
  static const String female = 'female';
}

class HEActivity {
  final int? id;
  final DateTime date;
  final String address;
  final String volunteer;
  final String heAttendeesList;
  final int male;
  final int female;

  const HEActivity({
    this.id,
    required this.date,
    required this.address,
    required this.volunteer,
    required this.heAttendeesList,
    required this.male,
    required this.female,
  });

  HEActivity copy({
    int? id,
    DateTime? date,
    String? address,
    String? volunteer,
    String? heAttendeesList,
    int? male,
    int? female,
  }) =>
      HEActivity(
        id: id ?? this.id,
        date: date ?? this.date,
        address: address ?? this.address,
        volunteer: volunteer ?? this.volunteer,
        heAttendeesList: heAttendeesList ?? this.heAttendeesList,
        male: male ?? this.male,
        female: female ?? this.female,
      );

  static HEActivity fromJson(Map<String, Object?> json) => HEActivity(
    id: json[HEActivityField.id] as int?,
    date: DateTime.parse(json[HEActivityField.date] as String),
    address: json[HEActivityField.address] as String,
    volunteer: json[HEActivityField.volunteer] as String,
    heAttendeesList: json[HEActivityField.heAttendeesList] as String,
    male: json[HEActivityField.male] as int,
    female: json[HEActivityField.female] as int,
  );

  Map<String, Object?> toJson() => {
    HEActivityField.id: id,
    HEActivityField.date: date.toIso8601String(),
    HEActivityField.address: address,
    HEActivityField.volunteer: volunteer,
    HEActivityField.heAttendeesList: heAttendeesList,
    HEActivityField.male: male,
    HEActivityField.female: female,
  };
}
