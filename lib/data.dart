class Data {
  int? id;
  String name;
  String email;

  Data({this.id, required this.name, required this.email});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email};
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      id: map['id'],
      name: map['name'], 
      email: map['email']
    );
  }
}
