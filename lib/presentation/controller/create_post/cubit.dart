import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:la_vie/core/utils/methods.dart';
import 'package:la_vie/data/data_source/remote_data_source.dart';
import 'package:la_vie/data/repository/repository.dart';
import 'package:la_vie/domain/repository/base_repository.dart';
import 'package:la_vie/domain/usecases/create_forum_post_usecase.dart';
import 'package:la_vie/presentation/controller/create_post/states.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';

class CreatePostCubit extends Cubit<CreatePostStates> {
  CreatePostCubit() : super(CreatePostInitialState());

  static CreatePostCubit get(context) => BlocProvider.of(context);

  XFile? _image;
  XFile? get image => _image;
  changeImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image != null) {
      _image = image;
      emit(ChangeImageState());
    }
  }

  createPost({
    required BuildContext context,
    required String title,
    required String description,
    required String imageBase64
  }) async {
    emit(CreatePostLoadingState());
    BaseRemoteDataSource baseRemoteDataSource = RemoteDataSource();
    BaseRepository baseRepository = Repository(baseRemoteDataSource);
    CreateForumPostUsecase createForumPostUsecase = CreateForumPostUsecase(baseRepository);
    await createForumPostUsecase.execute(title, description, imageBase64).then((value) {
      value.fold((failure) {
        Methods.showToastMessage(failure.message, toastColor: ColorManager.red700);
        emit(CreatePostErrorState());
      }, (forum) async {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop(true);
        Methods.showToastMessage(forum.message);
        emit(CreatePostSuccessState());
      });
    });
  }
}