part of 'auth_cubit.dart';

@immutable
sealed class AuthStates {}

final class LoginInitial extends AuthStates {}


final class LoginSuccess extends AuthStates {}



final class LoginLoading extends AuthStates {}



 class LoginFailure extends AuthStates {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
  
}
 class PasswordVisibilityState extends AuthStates{}

 

final class RegisterSuccess extends AuthStates {}



final class RegisterLoading extends AuthStates {}



 class RegisterFailure extends AuthStates {
  final String errorMessage;

  RegisterFailure({required this.errorMessage});
  
}


 