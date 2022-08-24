import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/presentation/controller/forget_password/states.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordCubit() : super(ForgetPasswordInitialState());

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  forgetPassword() {}
}