part of 'stepper_bloc.dart';

abstract class StepperEvent extends Equatable {
  const StepperEvent();
}

class OnTapStep extends StepperEvent {
  final int step;

  OnTapStep({@required this.step});

  @override
  List<Object> get props => [step];
}

class CancelStep extends StepperEvent {
  @override
  List<Object> get props => [];
}

class ContinueStep extends StepperEvent {
  @override
  List<Object> get props => [];
}

class ChangeDirectionToHorizontal extends StepperEvent{
  @override
  List<Object> get props => [];
}

class ChangeDirectionToVertical extends StepperEvent{
  @override
  List<Object> get props => [];
}