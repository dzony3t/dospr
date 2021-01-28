part of 'stepper_bloc.dart';

class StepperState extends Equatable {
  final int step;
  final int maxSteps;
  final StepperType value;

  StepperState({
    @required this.step,
    @required this.maxSteps,
    @required this.value,
  });

  StepperState copyWith({int step, int maxSteps, StepperType value}) {
    return StepperState(
      step: step ?? this.step,
      maxSteps: maxSteps ?? this.maxSteps,
      value: value?? this.value,
    );
  }

  @override
  List<Object> get props => [step, maxSteps, value];
}
