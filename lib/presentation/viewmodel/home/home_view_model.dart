import 'package:flutter_learn/presentation/viewmodel/view_model.dart';
import 'home_state.dart';


class HomeViewModel extends ViewModel<HomeState> {
  HomeViewModel() : super(const HomeState());

  void setLoading(bool value) {
    updateState(state.copyWith(isLoading: value));
  }

  void setData(String value) {
    updateState(state.copyWith(
      data: value,
      isLoading: false,
      errorMessage: null,
    ));
  }

  void setError(String message) {
    updateState(state.copyWith(
      errorMessage: message,
      isLoading: false,
    ));
  }

  void reset() {
    updateState(const HomeState());
  }

}
