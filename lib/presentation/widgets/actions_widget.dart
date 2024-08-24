import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/business_logic/cubit/timer_cubit.dart';

class ActionsWidget extends StatelessWidget {
  const ActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(
        // buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...switch (state.status) {
                TimerStatus.initial => [
                    FloatingActionButton(
                        child: const Icon(
                          Icons.play_arrow,
                        ),
                        onPressed: () =>
                            context.read<TimerCubit>().start(state.duration)),
                  ],
                TimerStatus.inProgress => [
                    FloatingActionButton(
                        child: const Icon(Icons.pause),
                        onPressed: () => context.read<TimerCubit>().pause()),
                    FloatingActionButton(
                      child: const Icon(Icons.restore),
                        onPressed: () => context.read<TimerCubit>().reset()),
                  ],
                TimerStatus.paused => [
                    FloatingActionButton(
                        child: const Icon(Icons.replay),
                        onPressed: () => context.read<TimerCubit>().resume())
                  ],
                TimerStatus.completed => [
                    FloatingActionButton(
                        onPressed: () => context.read<TimerCubit>().reset())
                  ],
                
              }
            ],
          );
        });
  }
}

