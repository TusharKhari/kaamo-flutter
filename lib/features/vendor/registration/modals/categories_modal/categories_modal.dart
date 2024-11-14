import 'subcategory.dart';

class CategoriesModal {
  int? id;
  String? name;
  List<Subcategory>? subcategories;

  CategoriesModal({this.id, this.name, this.subcategories});

  factory CategoriesModal.fromJson(Map<String, dynamic> json) {
    return CategoriesModal(
      id: json['id'] as int?,
      name: json['name'] as String?,
      subcategories: (json['subcategories'] as List<dynamic>?)
          ?.map((e) => Subcategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'subcategories': subcategories?.map((e) => e.toJson()).toList(),
      };

  CategoriesModal copyWith({
    int? id,
    String? name,
    List<Subcategory>? subcategories,
  }) {
    return CategoriesModal(
      id: id ?? this.id,
      name: name ?? this.name,
      subcategories: subcategories ?? this.subcategories,
    );
  }
}
