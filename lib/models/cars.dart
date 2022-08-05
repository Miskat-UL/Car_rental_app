final String tableName = 'cars';

class CarFields {
  static final List<String> values = [id, name, model, image, details];
  static const String id = '_id';
  static const String name = 'name';
  static const String model = 'model';
  static const String image = 'image';
  static const String details = 'details';
  // static const String isAvailable = 'isAvailable';
  // static const String userEmail = 'userEmail';
  //static const String userId = 'userId';
}

class Cars {
  final int? id;
  String name;
  String model;
  String image;
  String details;
  Cars({
    this.id,
    required this.name,
    required this.model,
    required this.image,
    required this.details,
  });
  // factory Cars.fromJson(Map<String, dynamic> json) {
  //   return Cars(
  //     name: json['name'],
  //     model: json['model'],
  //     image: json['image'],
  //     details: json['details'],
  //   );
  // }
  static Cars fromJson(Map<String, dynamic> json) {
    return Cars(
      id: json[CarFields.id] as int?,
      name: json[CarFields.name] as String,
      model: json[CarFields.model] as String,
      image: json[CarFields.image] as String,
      details: json[CarFields.details] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      CarFields.id: id,
      CarFields.name: name,
      CarFields.model: model,
      CarFields.image: image,
      CarFields.details: details,
    };
  }

  Cars copy({
    int? id,
    String? name,
    String? model,
    String? image,
    String? details,
  }) {
    return Cars(
      id: id ?? this.id,
      name: name ?? this.name,
      model: model ?? this.model,
      image: image ?? this.image,
      details: details ?? this.details,
    );
  }
}
