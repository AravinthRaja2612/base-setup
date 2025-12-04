import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final String? data;

  const LoginState({
    this.isLoading = false,
    this.errorMessage,
    this.data,
  });

  LoginState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? data,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, data];
}
