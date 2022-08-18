class Blog {
  late int id;
  late String title;
  late String? body;
  late String? photoName;
 
  Blog({required this.id, required this.photoName, required this.body, required this.title});
 
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'photo_name': photoName,
      'title': title,
      'body': body,
    };
    return map;
  }
 
  Blog.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    photoName = map['photo_name'];
    title = map['title'];
    body = map['body'];
  }
}