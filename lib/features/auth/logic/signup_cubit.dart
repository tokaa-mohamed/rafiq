import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/auth/data/repos/SignUprepo.dart';
import 'package:rafiq/features/auth/logic/signup_state.dart';


class SignupCubit extends Cubit<SignupState> {
  final SignupRepo _signupRepo;
  SignupCubit(this._signupRepo) : super(SignupInitial());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void emitSignupStates() async {
    if (formKey.currentState!.validate()) {
      emit(SignupLoading());
      try {
        await _signupRepo.signup({
          'name': nameController.text,
          'phone': phoneController.text,
          'password': passwordController.text,
        });
        emit(SignupSuccess());
      } catch (e) {
        emit(SignupError(e.toString()));
      }
    }
  }
}

