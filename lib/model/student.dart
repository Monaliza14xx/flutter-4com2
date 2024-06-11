class Student {
  final String id;
  late String stdId;
  late String name;
  late String surname;

  Student({
    required this.id,
    required this.stdId,
    required this.name,
    required this.surname,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      stdId: json['std_id'],
      name: json['name'],
      surname: json['surname'],
    );
  }
}
