import 'package:la_vie/domain/entities/plant.dart';

class PlantModel extends Plant {

  PlantModel({
    required super.plantId,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.waterCapacity,
    required super.sunLight,
    required super.temperature,
  });

  factory PlantModel.fromJson(Map<String, dynamic> json) {
    return PlantModel(
      plantId: json['plantId'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      waterCapacity: json['waterCapacity'],
      sunLight: json['sunLight'],
      temperature: json['temperature'],
    );
  }
}