import '../../product_module.dart';

class CategoryModel {
  final String name;

  const CategoryModel({required this.name});

  factory CategoryModel.fromJson(String json) {
    return CategoryModel(name: json);
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }

  CategoryEntity toEntity() {
    return CategoryEntity(name: name);
  }
}
