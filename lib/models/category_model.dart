class CategoryModel{
  int? cat_id;
  String title;
  String img_path;

  CategoryModel({this.cat_id, required this.title, required this.img_path});


  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      cat_id: map['cat_id'],
      title: map['title'],
      img_path: map['img_path']
    );
  }

  Map<String, dynamic> toMap() => {
    'title' : title,
    'img_path' : img_path
  };
}