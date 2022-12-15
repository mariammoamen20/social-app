import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_flutter/layout/cubit/states.dart';
import 'package:social_app_flutter/models/user_data_model.dart';
import 'package:social_app_flutter/modules/socail_login/cubit/states.dart';

import '../../shared/components/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserDataModel? model;

  void getUserData() {
    emit(SocialLoadingState());
    //هنا هيروح يفتح  الكوليشكن اللي اسمه يوزر وبعدين يروح يجيب الدوكيمنت عن طريق ال id وبعدين يروح يجيب الداتا
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
          model = UserDataModel.fromJson(value.data());
          print(value.data());
          emit(SocialSuccessState());
    })
        .catchError((error) {
          print(error.toString());
          emit(SocialErrorState(error.toString()),);
    });
  }
}
