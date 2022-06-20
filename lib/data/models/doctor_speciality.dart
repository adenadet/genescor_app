class DoctorSpeciality {
  int? id;
  String? name;

  DoctorSpeciality({
    this.id,
    this.name,
  });

  factory DoctorSpeciality.fromJson(Map<String, dynamic> json) {
    return DoctorSpeciality(id: json['id'], name: json['name']);
  }
}
