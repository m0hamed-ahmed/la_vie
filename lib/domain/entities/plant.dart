class Plant {
  final String plantId;
  final String name;
  final String description;
  final String imageUrl;
  final int waterCapacity;
  final int sunLight;
  final int temperature;

  Plant({
    required this.plantId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.waterCapacity,
    required this.sunLight,
    required this.temperature,
  });
}