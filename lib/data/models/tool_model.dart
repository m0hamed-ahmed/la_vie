import 'package:la_vie/domain/entities/tool.dart';

class ToolModel extends Tool {

  ToolModel({
    required super.toolId,
    required super.name,
    required super.description,
    required super.imageUrl,
  });

  factory ToolModel.fromJson(Map<String, dynamic> json) {
    return ToolModel(
      toolId: json['toolId'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}