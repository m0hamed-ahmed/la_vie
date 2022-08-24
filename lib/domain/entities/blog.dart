import 'package:la_vie/domain/entities/plant.dart';
import 'package:la_vie/domain/entities/seed.dart';
import 'package:la_vie/domain/entities/tool.dart';

class Blog {
  List<Plant> plants;
  List<Seed> seeds;
  List<Tool> tools;

  Blog({
    required this.plants,
    required this.seeds,
    required this.tools,
  });
}