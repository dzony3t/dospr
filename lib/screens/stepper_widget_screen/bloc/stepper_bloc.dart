import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'stepper_event.dart';
part 'stepper_state.dart';

class StepperBloc extends Bloc<StepperEvent, StepperState> {
  final int maxSteps;

  StepperBloc({this.maxSteps})
      : super(StepperState(step: 1, maxSteps: maxSteps, value: StepperType.vertical));
  @override
  Stream<StepperState> mapEventToState(
    StepperEvent event,
  ) async* {
    if (event is OnTapStep) yield* onTapStep(event);
    if (event is CancelStep) yield* cancelStep();
    if (event is ContinueStep) yield* continueStep();
    if (event is ChangeDirectionToHorizontal) yield* changeDirectionToHor();
    if (event is ChangeDirectionToVertical) yield* changeDirectionToVert();
  }

  Stream<StepperState> changeDirectionToHor() async* {
    try {
      yield state.copyWith(value: StepperType.horizontal);
    } catch (error) {
      print(error);
    }
  }
  Stream<StepperState> changeDirectionToVert() async* {
    try {
      yield state.copyWith(value: StepperType.vertical);
    } catch (error) {
      print(error);
    }
  }

  Stream<StepperState> onTapStep(OnTapStep event) async* {
    try {
      yield state.copyWith(step: event.step);
    } catch (error) {
      print(error);
    }
  }

  Stream<StepperState> cancelStep() async* {
    try {
      print('yielduje przed copy-with w cancel');
      yield state.copyWith(
        step: state.step - 1 >= 0 ? state.step - 1 : 0,
      );
      print('yielduje po copy-with w cancel');
    } catch (error) {
      print(error);
    }
  }

  Stream<StepperState> continueStep() async* {
    try {
      print('yielduje przed copy-with');
      yield state.copyWith(
        step: state.step + 1 < maxSteps ? state.step + 1 : 0,
      );
      print('yielduje po copy-with');
    } catch (error) {
      print(error);
    }
  }
}
