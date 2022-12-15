import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_flutter/layout/cubit/cubit.dart';
import 'package:social_app_flutter/layout/cubit/states.dart';
import 'package:social_app_flutter/shared/components/components.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).model != null,
            builder: (context) {
              //var model = SocialCubit.get(context).model;
              return Column(
                children: [
                  if (!(FirebaseAuth.instance.currentUser!.emailVerified))
                    Container(
                      color: Colors.amber.withOpacity(0.7),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outline),
                            const SizedBox(
                              width: 15.0,
                            ),
                            const Expanded(
                              child: Text('please verfiy your account '),
                            ),
                            const SizedBox(
                              width: 30.0,
                            ),
                            TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.currentUser
                                    ?.sendEmailVerification()
                                    .then((value) {
                                  showToast(
                                      message: 'check your mail',
                                      states: ToastStates.SUCCESS);
                                }).catchError((error) {
                                  print(error.toString());
                                });
                              },
                              child: Text('SEND'),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
