

import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

/// Base ViewModel that holds a generic [T] state which must extend Equatable.
abstract class ViewModel<T extends Equatable> extends ChangeNotifier {
  ViewModel(this._state);

  T _state;
  T get state => _state;

  /// Update state only if it’s different.
  @protected
  void updateState(T newState) {
    if (newState != _state) {
      _state = newState;
      notifyListeners();
    }
  }

  /// Optional: Override to perform cleanup (close streams, etc.)
  @mustCallSuper
  @override
  void dispose() {
    // Base dispose — subclasses can override for cleanup
    super.dispose();
  }
}


