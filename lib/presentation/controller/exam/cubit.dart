import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/methods.dart';
import 'package:la_vie/presentation/controller/exam/states.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';

class ExamCubit extends Cubit<ExamStates> {
  ExamCubit() : super(ExamInitialState());

  static ExamCubit get(context) => BlocProvider.of(context);

  int totalNumberOfQuestions = 10;

  int _currentQuestion = 1;
  int get currentQuestion => _currentQuestion;

  List<int?> correctIndex = [null, null, null, null, null, null, null, null, null, null];

  changeCorrectIndex(int index) {
    correctIndex[currentQuestion-1] = index;
    emit(ExamChangeCorrectIndexState());
  }

  nextCurrentQuestion() {
    if(currentQuestion < totalNumberOfQuestions) {
      _currentQuestion++;
      emit(ExamChangeCurrentQuestionState());
    } else {
      Methods.showToastMessage(StringManager.done);
    }
  }

  backCurrentQuestion() {
    if(currentQuestion > 1) {
      _currentQuestion--;
      emit(ExamChangeCurrentQuestionState());
    }
  }
}