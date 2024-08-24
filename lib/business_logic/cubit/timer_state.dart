
part of  'timer_cubit.dart';

enum TimerStatus {initial, inProgress, paused, completed}
class TimerState  extends Equatable{

   final TimerStatus status;
  final int duration;
  
   const TimerState({required this.status, required this.duration});
   
     @override
     List<Object?> get props => [status, duration];

     @override
     String toString()  =>  'TimerState {status: $status, duration: $duration}';
    
    
  
}