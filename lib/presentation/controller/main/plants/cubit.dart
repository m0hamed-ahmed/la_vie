import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/methods.dart';
import 'package:la_vie/data/data_source/remote_data_source.dart';
import 'package:la_vie/data/repository/repository.dart';
import 'package:la_vie/domain/entities/plant.dart';
import 'package:la_vie/domain/repository/base_repository.dart';
import 'package:la_vie/domain/usecases/get_plants_usecase.dart';
import 'package:la_vie/presentation/controller/main/plants/states.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';

class PlantsCubit extends Cubit<PlantsStates> {
  PlantsCubit() : super(PlantsInitialState());

  static PlantsCubit get(context) => BlocProvider.of(context);

  List<Plant> _plants = [];
  List<Plant> get plants => _plants;

  Future<void> getPlants() async {
    emit(GetPlantsLoadingState());
    BaseRemoteDataSource baseRemoteDataSource = RemoteDataSource();
    BaseRepository baseRepository = Repository(baseRemoteDataSource);
    GetPlantsUsecase getPlantsUsecase = GetPlantsUsecase(baseRepository);
    await getPlantsUsecase.execute().then((value) {
      value.fold((failure) {
        Methods.showToastMessage(failure.message, toastColor: ColorManager.red700);
        emit(GetPlantsErrorState());
      }, (plants) async {
        _plants = plants;
        emit(GetPlantsSuccessState());
      });
    });
  }
}