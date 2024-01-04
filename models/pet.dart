import 'dart:convert';

class Pet {
  String id;
  String adoptedBy;
  String name;
  String type;
  String base64image;
  int age;

  Pet({
    required this.id,
    required this.adoptedBy,
    required this.name,
    required this.type,
    required this.base64image,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'adopted_by': adoptedBy,
      'name': name,
      'type': type,
      'base64image': base64image,
      'age': age,
    };
  }

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map['id'] as String,
      adoptedBy: map['adopted_by'] as String,
      name: map['name'] as String,
      type: map['type'] as String,
      base64image: map['base64image'] as String,
      age: map['age']?.toInt() as int,
    );
  }
  String toJson() => json.encode(toMap());

  factory Pet.fromJson(String source) =>
      Pet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pet(id: $id, adoptedBy: $adoptedBy, name: $name, type: $type, base64image: $base64image, age: $age)';
  }
}
