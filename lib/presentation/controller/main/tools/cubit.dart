import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/methods.dart';
import 'package:la_vie/data/data_source/remote_data_source.dart';
import 'package:la_vie/data/repository/repository.dart';
import 'package:la_vie/domain/entities/tool.dart';
import 'package:la_vie/domain/repository/base_repository.dart';
import 'package:la_vie/domain/usecases/get_tools_usecase.dart';
import 'package:la_vie/presentation/controller/main/tools/states.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';

class ToolsCubit extends Cubit<ToolsStates> {
  ToolsCubit() : super(ToolsInitialState());

  static ToolsCubit get(context) => BlocProvider.of(context);

  List<Tool> _tools = [];
  List<Tool> get tools => _tools;

  Future<void> getTools() async {
    emit(GetToolsLoadingState());
    BaseRemoteDataSource baseRemoteDataSource = RemoteDataSource();
    BaseRepository baseRepository = Repository(baseRemoteDataSource);
    GetToolsUsecase getToolsUsecase = GetToolsUsecase(baseRepository);
    await getToolsUsecase.execute().then((value) {
      value.fold((failure) {
        Methods.showToastMessage(failure.message, toastColor: ColorManager.red700);
        emit(GetToolsErrorState());
      }, (tools) async {
        _tools = tools;
        emit(GetToolsSuccessState());
      });
    });
  }
}