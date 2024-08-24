// part of 'timer_bloc.dart';

import 'package:equatable/equatable.dart';

enum TimerEventType {started, paused, resumed, reset, ticked}

class TimerEvent  extends Equatable{
  final TimerEventType type;
  final int? duration;

  const TimerEvent({required this.type, this.duration});


  @override
  List<Object?> get props => [duration,type];
  
}

// sealed class TimerEvent {
//   const TimerEvent();
// }

// final class TimerStarted extends TimerEvent {
//   const TimerStarted({required this.duration});
//   final int duration;
// }

// final class TimerPaused extends TimerEvent {
//   const TimerPaused();
// }

// final class TimerResumed extends TimerEvent {
//   const TimerResumed();
// }

// class TimerReset extends TimerEvent {
//   const TimerReset();
// }

// class _TimerTicked extends TimerEvent {
//   const _TimerTicked({required this.duration});
//   final int duration;
// }
