import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_flutter/modules/social_register/cubit/cubit.dart';
import 'package:social_app_flutter/modules/social_register/cubit/states.dart';

import '../../layout/social_layout/social_layout_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/style/colors.dart';

class SocialRegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SocialRegisterCubit(),
        child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
          listener: (context, state) {
            if (state is SocialRegisterSuccessState) {
              navigateTo(context, SocialLayout());
            }
          },
          builder: (context, state) {
            var cubit = SocialRegisterCubit.get(context);
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
                            'REGISTER',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(color: Colors.black),
                          ),
                          Text(
                            'SocialRegister now to communicate with friends',
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
                                  return 'name must not be empty';
                                }
                              },
                              controller: nameController,
                              label: 'Name',
                              prefixIcon: const Icon(Icons.person),
                              type: TextInputType.name),
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
                            height: 30.0,
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
                               /*   cubit.userSocialRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );*/
                                }
                              },
                              isPassword: cubit.isPassword,
                              suffixIcon: cubit.suffixIcon,
                              controller: passwordController,
                              label: 'password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              type: TextInputType.visiblePassword),
                          const SizedBox(
                            height: 30.0,
                          ),
                          defaultTextFormFiled(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'phone must not be empty';
                                }
                              },
                              controller: phoneController,
                              label: 'Phone',
                              prefixIcon: const Icon(Icons.phone),
                              type: TextInputType.phone),
                          SizedBox(
                            height: 30.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! SocialRegisterLoadingState,
                            builder: (context) => defaultButton(
                              color: defaultColor,
                              text: 'register',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userSocialRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
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
