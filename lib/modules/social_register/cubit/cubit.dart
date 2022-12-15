import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_flutter/models/user_data_model.dart';
import 'package:social_app_flutter/modules/social_register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  IconData suffixIcon = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeSocialRegisterPasswordVisibility());
  }

  void userSocialRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    //    //ميثود بتكريت يوزر بالايميل والباسورد هناك في الفايربيز
    //انا كده عملت كريت ليوزر بس معملتش save ل data بتاعه في الفيرستور معملتش داتا بيز اخزن فيها الداتا بتاعته
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
          emit(SocialRegisterSuccessState());
      print(value.user?.email);
      print(value.user?.uid);
          createUserData(
          email: email,
          name: name,
          phone: phone,
          uId: value.user?.uid,
          isEmailVerified: false);
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  //المفروض بعد ماهعمل ريجستر واكريت يوز هاهخد الداتا بتاعته دي اخزنها في الفايرستور
  void createUserData(
      {required String email,
      required String name,
      required String phone,
      required String? uId,
      required bool? isEmailVerified}) {
    UserDataModel model =
        UserDataModel(name, email, phone, uId, isEmailVerified);
    //هنا هيشوف لو في كوليكشن بالاسم ده هيدخل في لو مفيش هيعملي واحد جديد ويضيف فيع الدكومينت
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(UserDataRegistrationSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UserDataRegistrationErrorState(error.toString()));
    });
  }
}
