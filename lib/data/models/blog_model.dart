import 'package:la_vie/domain/entities/blog.dart';
import 'package:la_vie/domain/entities/plant.dart';
import 'package:la_vie/domain/entities/seed.dart';
import 'package:la_vie/domain/entities/tool.dart';

class BlogModel extends Blog {

  BlogModel({
    required super.plants,
    required super.seeds,
    required super.tools,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      plants: List<Plant>.from(json['plants'].map((e) => e)),
      seeds: List<Seed>.from(json['seeds'].map((e) => e)),
      tools: List<Tool>.from(json['tools'].map((e) => e)),
    );
  }
}