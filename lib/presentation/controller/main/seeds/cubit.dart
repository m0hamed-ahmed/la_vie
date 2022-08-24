import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/methods.dart';
import 'package:la_vie/data/data_source/remote_data_source.dart';
import 'package:la_vie/data/repository/repository.dart';
import 'package:la_vie/domain/entities/seed.dart';
import 'package:la_vie/domain/repository/base_repository.dart';
import 'package:la_vie/domain/usecases/get_seeds_usecase.dart';
import 'package:la_vie/presentation/controller/main/seeds/states.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';

class SeedsCubit extends Cubit<SeedsStates> {
  SeedsCubit() : super(SeedsInitialState());

  static SeedsCubit get(context) => BlocProvider.of(context);

  List<Seed> _seeds = [];
  List<Seed> get seeds => _seeds;

  Future<void> getSeeds() async {
    emit(GetSeedsLoadingState());
    BaseRemoteDataSource baseRemoteDataSource = RemoteDataSource();
    BaseRepository baseRepository = Repository(baseRemoteDataSource);
    GetSeedsUsecase getSeedsUsecase = GetSeedsUsecase(baseRepository);
    await getSeedsUsecase.execute().then((value) {
      value.fold((failure) {
        Methods.showToastMessage(failure.message, toastColor: ColorManager.red700);
        emit(GetSeedsErrorState());
      }, (seeds) async {
        _seeds = seeds;
        emit(GetSeedsSuccessState());
      });
    });
  }
}