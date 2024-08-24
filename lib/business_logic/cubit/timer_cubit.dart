import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_timer/data/models/ticker.dart';
part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  final Ticker ticker;
  StreamSubscription<int>? _tickerSubscription;
  static const int _initialDuration = 60;

  TimerCubit({required this.ticker})
      : super(const TimerState(status: TimerStatus.initial, duration: 60));

  void start(int duration) {
    emit(TimerState(status: TimerStatus.inProgress, duration: duration));
    _tickerSubscription?.cancel();
    _tickerSubscription =
        ticker.tick(ticks: duration).listen((duration) => tick(duration));
  }

  void tick(int duration) {
    if (duration > 0) {
      emit(TimerState(status: TimerStatus.inProgress, duration: duration));
    } else {
      emit(const TimerState(status: TimerStatus.completed, duration: 0));
      _tickerSubscription?.cancel();
    }
  }

  void pause() {
    if (state.status == TimerStatus.inProgress) {
      _tickerSubscription?.pause();
      emit(TimerState(status: TimerStatus.paused, duration: state.duration));
    }
  }

  void resume() {
    if(state.status == TimerStatus.paused) {
      _tickerSubscription?.resume();
      emit(TimerState(status: TimerStatus.inProgress, duration: state.duration));
    }
  }

  void reset() {
      _tickerSubscription?.cancel();
      emit(const TimerState(status: TimerStatus.initial, duration: _initialDuration));
    
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
