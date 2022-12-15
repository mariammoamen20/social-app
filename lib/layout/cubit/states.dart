abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialLoadingState extends SocialStates {}

class SocialSuccessState extends SocialStates {}

class SocialErrorState extends SocialStates {
  final String error;

  SocialErrorState(this.error);
}
