
abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;

  SocialRegisterErrorState(this.error);
}

class ChangeSocialRegisterPasswordVisibility extends SocialRegisterStates {}

class UserDataRegistrationSuccessState extends SocialRegisterStates{}

class UserDataRegistrationErrorState extends SocialRegisterStates{
  final String error;

  UserDataRegistrationErrorState(this.error);
}