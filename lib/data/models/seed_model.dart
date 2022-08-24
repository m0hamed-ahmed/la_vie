import 'package:la_vie/domain/entities/seed.dart';

class SeedModel extends Seed {

  SeedModel({
    required super.seedId,
    required super.name,
    required super.description,
    required super.imageUrl,
  });

  factory SeedModel.fromJson(Map<String, dynamic> json) {
    return SeedModel(
      seedId: json['seedId'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}