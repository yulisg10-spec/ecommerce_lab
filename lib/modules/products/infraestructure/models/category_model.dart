import '../../product_module.dart';

class CategoryModel {
  final String id;
  final String name;
  final String iconPath;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.iconPath,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      iconPath: json['iconPath'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'name': name, 'iconPath': iconPath};
  }

  CategoryEntity toEntity() {
    return CategoryEntity(id: id, name: name, iconPath: iconPath);
  }
}
