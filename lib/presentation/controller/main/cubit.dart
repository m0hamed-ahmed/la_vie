import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/presentation/controller/main/states.dart';
import 'package:la_vie/presentation/resources/enum.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitialState());

  static MainCubit get(context) => BlocProvider.of(context);

  Categories _category = Categories.plants;
  Categories get category => _category;
  changeCategoryItem(Categories category) {
    _category = category;
    emit(MainChangeCategoryItemState());
  }
}