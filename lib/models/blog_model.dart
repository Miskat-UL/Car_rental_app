final String tableName = 'blogs';

class BlogFields {
  static final List<String> values = [id, title, body, image, location,category];
  static const String id = '_id';
  static const String title = 'title';
  static const String body = 'body';
  static const String location = 'location';
  static const String image = 'image';
  static const String category = 'category';
  // static const String isAvailable = 'isAvailable';
  // static const String userEmail = 'userEmail';
  //static const String userId = 'userId';
}

class Blogs {
  final int? id;
  String title;
  String location;
  String body;
  String image;
  String category;
  Blogs({
    this.id,
    required this.title,
    required this.location,
    required this.image,
    required this.body,
    required this.category,
  });
  // factory Blogs.fromJson(Map<String, dynamic> json) {
  //   return Blogs(
  //     name: json['name'],
  //     model: json['model'],
  //     image: json['image'],
  //     details: json['details'],
  //   );
  // }
  static Blogs fromJson(Map<String, dynamic> json) {
    return Blogs(
      id: json[BlogFields.id] as int?,
      title: json[BlogFields.title] as String,
      body: json[BlogFields.body] as String,
      image: json[BlogFields.image] as String,
      location: json[BlogFields.location] as String,
      category: json[BlogFields.category] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      BlogFields.id: id,
      BlogFields.title: title,
      BlogFields.body: body,
      BlogFields.image: image,
      BlogFields.location: location,
      BlogFields.category: category,
    };
  }

  Blogs copy({
    int? id,
    String? title,
    String? body,
    String? image,
    String? location,
    String? category,
  }) {
    return Blogs(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      image: image ?? this.image,
      location: location ?? this.location,
      category: location ?? this.category,
    );
  }
}
