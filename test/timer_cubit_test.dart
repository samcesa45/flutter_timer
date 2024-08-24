import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_timer/business_logic/cubit/timer_cubit.dart';
import 'package:flutter_timer/data/models/ticker.dart';
import 'package:mocktail/mocktail.dart';

class _MockTicker extends Mock implements Ticker {}

void main() {
  group("TimerCubit", () {
    late Ticker ticker;
    late TimerCubit timerCubit;

    setUp(() {
      ticker = _MockTicker();
      timerCubit = TimerCubit(ticker: ticker);

      when(() => ticker.tick(ticks: 5)).thenAnswer(
        (_) => Stream<int>.fromIterable([5, 4, 3, 2, 1]),
      );
    });

    tearDown(() {
      timerCubit.close();
    });

    test('initial state is {TimerStatus.initial, duration:60}', () {
      expect(
        TimerCubit(ticker: ticker).state,
        const TimerState(status: TimerStatus.initial, duration: 60),
      );
    });

    blocTest<TimerCubit, TimerState>(
      'emits inprogress 5 times after time started',
      build: () => TimerCubit(ticker: ticker),
      act: (cubit) => cubit.start(5),
      expect: () => [
        const TimerState(status: TimerStatus.inProgress, duration: 5),
        const TimerState(status: TimerStatus.inProgress, duration: 4),
        const TimerState(status: TimerStatus.inProgress, duration: 3),
        const TimerState(status: TimerStatus.inProgress, duration: 2),
        const TimerState(status: TimerStatus.inProgress, duration: 1),
      ],
      verify: (_) => verify(() => ticker.tick(ticks: 5)).called(1),
    );

    // blocTest<TimerCubit, TimerState>(
    //   'emits duration to be 2 when ticker is paused at 2)',
    //   build: () => TimerCubit(ticker: ticker),
    //   act: (cubit) {
    //     cubit.start(5);
    //     cubit.pause();
    //   },
    //   expect: () => [
    //     const TimerState(status: TimerStatus.inProgress, duration: 5),
    //     const TimerState(status: TimerStatus.inProgress, duration: 4),
    //     const TimerState(status: TimerStatus.inProgress, duration: 3),
    //     const TimerState(status: TimerStatus.paused, duration: 2)
    //   ],
    //   verify: (_) => verify(() => ticker.tick(ticks: 5)).called(1),
    // );

    // blocTest<TimerCubit, TimerState>(
    //     'emits {TimerStatus.inProgress, duration:5} when ticker is resumed at 5',
    //     build: () => TimerCubit(ticker: ticker),
    //     act: (cubit) => cubit.resume(),
    //     setUp: () {
    //       when(() => ticker.tick(ticks: 5)).thenAnswer(
    //         (_) => Stream<int>.value(5),
    //       );
    //     },
    //     expect: () => [
    //           const TimerState(status: TimerStatus.inProgress, duration: 5),
    //           const TimerState(status: TimerStatus.inProgress, duration: 4),
    //           const TimerState(status: TimerStatus.inProgress, duration: 3),
    //           const TimerState(status: TimerStatus.inProgress, duration: 2),
    //           const TimerState(status: TimerStatus.inProgress, duration: 1),
    //         ]);
  });
}
