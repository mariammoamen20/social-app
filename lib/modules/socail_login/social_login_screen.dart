import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_flutter/modules/socail_login/cubit/cubit.dart';
import 'package:social_app_flutter/modules/socail_login/cubit/states.dart';

import '../../layout/social_layout/social_layout_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/style/colors.dart';
import '../social_register/register_screen.dart';

class SocialSocialLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SocialLoginCubit(),
        child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
          listener: (context, state) {
            if (state is SocialLoginErrorState) {
              showToast(message: state.error, states: ToastStates.ERROR);
            }
            if(state is SocialLoginSuccessState){
              //لو عملت لوجن والستيت ب سكسس خلاص اعمل سيف ل user id  واعمل نافيجيت على الهةم سكرين
              CacheHelper.saveData(key: 'uid', value: state.uId).then((value){
                navigateToAndFinish(context, SocialLayout());
              }).catchError((error){

              });
            }
          },
          builder: (context, state) {
            var cubit = SocialLoginCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(color: Colors.black),
                          ),
                          Text(
                            'SocialLogin now to communicate with friends',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          defaultTextFormFiled(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'email must not be empty';
                                }
                              },
                              controller: emailController,
                              label: 'Email',
                              prefixIcon: const Icon(Icons.email_outlined),
                              type: TextInputType.emailAddress),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defaultTextFormFiled(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'password is too short';
                                }
                              },
                              suffixPressed: () {
                                cubit.changePasswordVisibility();
                              },
                              onSubmitted: (value) {
                                if (formKey.currentState!.validate()) {
                                  /*    cubit.userSocialLogin(
                                      email: emailController.text,
                                      password: passwordController.text);*/
                                }
                              },
                              isPassword: cubit.isPassword,
                              suffixIcon: cubit.suffixIcon,
                              controller: passwordController,
                              label: 'password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              type: TextInputType.visiblePassword),
                          const SizedBox(
                            height: 15.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! SocialLoginLoadingState,
                            builder: (context) => defaultButton(
                              color: defaultColor,
                              text: 'login',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userSocialLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              isUpperCase: true,
                            ),
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Dont\'t have an account ? '),
                              defaultTextButton(
                                function: () {
                                  navigateTo(
                                    context,
                                    SocialRegisterScreen(),
                                  );
                                },
                                text: 'Register',
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
