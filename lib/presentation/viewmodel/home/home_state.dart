import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final String? data;

  const HomeState({
    this.isLoading = false,
    this.errorMessage,
    this.data,
  });

  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? data,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, data];
}
