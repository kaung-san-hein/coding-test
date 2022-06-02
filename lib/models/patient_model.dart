const String tablePatient = 'patients';

class PatientField {
  static final List<String> values = [
    id, name, sex, age, referDate, township, address, referFrom, referTo, signAndSymptom,
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String sex = 'sex';
  static const String age = 'age';
  static const String referDate = 'refer_date';
  static const String township = 'township';
  static const String address = 'address';
  static const String referFrom = 'refer_from';
  static const String referTo = 'refer_to';
  static const String signAndSymptom = 'sign_and_symptom';
}

class Patient {
  final int? id;
  final String name;
  final String sex;
  final int age;
  final DateTime referDate;
  final String township;
  final String address;
  final String referFrom;
  final String referTo;
  final String signAndSymptom;

  const Patient({
    this.id,
    required this.name,
    required this.sex,
    required this.age,
    required this.referDate,
    required this.township,
    required this.address,
    required this.referFrom,
    required this.referTo,
    required this.signAndSymptom,
  });

  Patient copy({
    int? id,
    String? name,
    String? sex,
    int? age,
    DateTime? referDate,
    String? township,
    String? address,
    String? referFrom,
    String? referTo,
    String? signAndSymptom,
  }) =>
      Patient(
        id: id ?? this.id,
        name: name ?? this.name,
        sex: sex ?? this.sex,
        age: age ?? this.age,
        referDate: referDate ?? this.referDate,
        township: township ?? this.township,
        address: address ?? this.address,
        referFrom: referFrom ?? this.referFrom,
        referTo: referTo ?? this.referTo,
        signAndSymptom: signAndSymptom ?? this.signAndSymptom,
      );

  static Patient fromJson(Map<String, Object?> json) => Patient(
    id: json[PatientField.id] as int?,
    name: json[PatientField.name] as String,
    sex: json[PatientField.sex] as String,
    age: json[PatientField.age] as int,
    referDate: DateTime.parse(json[PatientField.referDate] as String),
    township: json[PatientField.township] as String,
    address: json[PatientField.address] as String,
    referFrom: json[PatientField.referFrom] as String,
    referTo: json[PatientField.referTo] as String,
    signAndSymptom: json[PatientField.signAndSymptom] as String,
  );

  Map<String, Object?> toJson() => {
    PatientField.id: id,
    PatientField.name: name,
    PatientField.sex: sex,
    PatientField.age: age,
    PatientField.referDate: referDate.toIso8601String(),
    PatientField.township: township,
    PatientField.address: address,
    PatientField.referFrom: referFrom,
    PatientField.referTo: referTo,
    PatientField.signAndSymptom: signAndSymptom,
  };
}
