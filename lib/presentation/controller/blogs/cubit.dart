import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/methods.dart';
import 'package:la_vie/data/data_source/remote_data_source.dart';
import 'package:la_vie/data/repository/repository.dart';
import 'package:la_vie/domain/entities/blog.dart';
import 'package:la_vie/domain/repository/base_repository.dart';
import 'package:la_vie/domain/usecases/get_blogs_usecase.dart';
import 'package:la_vie/presentation/controller/blogs/states.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';

class BlogsCubit extends Cubit<BlogsStates> {
  BlogsCubit() : super(BlogsInitialState());

  static BlogsCubit get(context) => BlocProvider.of(context);

  late Blog _blog;
  Blog get blog => _blog;

  Future<void> getBlogs() async {
    emit(GetBlogsLoadingState());
    BaseRemoteDataSource baseRemoteDataSource = RemoteDataSource();
    BaseRepository baseRepository = Repository(baseRemoteDataSource);
    GetBlogsUsecase getBlogsUsecase = GetBlogsUsecase(baseRepository);
    await getBlogsUsecase.execute().then((value) {
      value.fold((failure) {
        Methods.showToastMessage(failure.message, toastColor: ColorManager.red700);
        emit(GetBlogsErrorState());
      }, (blog) async {
        _blog = blog;
        emit(GetBlogsSuccessState());
      });
    });
  }
}