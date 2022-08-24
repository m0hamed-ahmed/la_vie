import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/methods.dart';
import 'package:la_vie/data/data_source/remote_data_source.dart';
import 'package:la_vie/data/repository/repository.dart';
import 'package:la_vie/domain/entities/discussion_forum.dart';
import 'package:la_vie/domain/repository/base_repository.dart';
import 'package:la_vie/domain/usecases/get_discussion_forums_usecase.dart';
import 'package:la_vie/presentation/controller/discussion_forums/states.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/enum.dart';

class DiscussionForumsCubit extends Cubit<DiscussionForumsStates> {
  DiscussionForumsCubit() : super(DiscussionForumsInitialState());

  static DiscussionForumsCubit get(context) => BlocProvider.of(context);

  Forums _forum = Forums.allForums;
  Forums get forum => _forum;
  changeForumsItem(Forums forum) {
    _forum = forum;
    emit(DiscussionForumsChangeForumItemState());
  }

  List<DiscussionForum> _discussionForums = [];
  List<DiscussionForum> get discussionForums => _discussionForums;

  Future<void> getDiscussionForums() async {
    emit(GetDiscussionForumsLoadingState());
    BaseRemoteDataSource baseRemoteDataSource = RemoteDataSource();
    BaseRepository baseRepository = Repository(baseRemoteDataSource);
    GetDiscussionForumsUsecase getDiscussionForumsUsecase = GetDiscussionForumsUsecase(baseRepository);
    await getDiscussionForumsUsecase.execute().then((value) {
      value.fold((failure) {
        Methods.showToastMessage(failure.message, toastColor: ColorManager.red700);
        emit(GetDiscussionForumsErrorState());
      }, (discussionForums) async {
        _discussionForums = discussionForums;
        emit(GetDiscussionForumsSuccessState());
      });
    });
  }
}