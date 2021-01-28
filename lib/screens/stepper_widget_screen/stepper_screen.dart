import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/stepper_bloc.dart';
import 'model_pikto.dart';

class StepperScreen extends StatefulWidget {
  @override
  _StepperScreen createState() => _StepperScreen();
//  ss
}

class _StepperScreen extends State<StepperScreen> {
  static ModelPikto model = ModelPikto();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<Step> steps = [
    Step(
      title: Text("Teren zewnętrzny"),
      isActive: true,
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Wpisz rodzaj terenu'),
            onSaved: (String value) {
              model.teren = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Wpisz wielkość terenu'),
            onSaved: (String value) {
              model.powierzchnia = value;
            },
          ),
        ],
      ),
    ),
    Step(
      title: Text("Budynek"),
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Wpisz rodzaj budynku'),
            onSaved: (String value) {
              model.rodzaj = value;
            },
          ),
        ],
      ),
      state: StepState.disabled,
      isActive: true,
    ),
    Step(
      title: Text("Piętra"),
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Wpisz ilość pięter'),
            onSaved: (String value) {
              model.pietra = value;
            },
          ),
        ],
      ),
      isActive: true,
    ),
    Step(
      title: Text("Nr piętra"),
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Wpisz numer piętra'),
            onSaved: (String value) {
              model.pietra = value;
            },
          ),
        ],
      ),
      isActive: true,
    ),
    Step(
      title: Text("Wyposażenie"),
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Wpisz wyposażenie'),
            onSaved: (String value) {
              model.wyposazenie = value;
            },
          ),
        ],
      ),
      isActive: true,
    ),
    Step(
      title: Text("Urządzenia techniczne"),
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration:
                InputDecoration(labelText: 'Wpisz urządzenia techniczne'),
            onSaved: (String value) {
              model.urzadenia = value;
            },
          ),
        ],
      ),
      isActive: true,
    ),
    Step(
      title: Text("Instalacje"),
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Wpisz instalacje'),
            onSaved: (String value) {
              model.instalacje = value;
            },
          ),
        ],
      ),
      isActive: true,
    ),
  ];

  StepperBloc stepperBloc = StepperBloc();
  @override
  void initState() {
    super.initState();
    stepperBloc = StepperBloc(maxSteps: steps.length);
  }

  @override
  void dispose() {
    stepperBloc.close();
    super.dispose();
  }

  void _submitDetails() {
    final FormState formState = _formKey.currentState;
    formState.save();
    showDialog(
        context: context,
        child: AlertDialog(
          title: Text("Details"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Rodzaj terenu : " + model.teren),
                Text("Powierzchnia : " + model.powierzchnia),
                Text("Budynek : " + model.rodzaj),
                Text("Ilość Pięter: " + model.pietra),
                Text("Nr piętra: " + model.pietra),
                Text("Wyposażenie na danym piętrze: " + model.wyposazenie),
                Text("Urządzenia: " + model.urzadenia),
                Text("Instalacje: " + model.instalacje),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.horizontal_rule),
              onPressed: () => stepperBloc.add(ChangeDirectionToHorizontal())),
          IconButton(
              icon: Icon(Icons.vertical_align_bottom),
              onPressed: () => stepperBloc.add(ChangeDirectionToVertical()))
        ],
        title: Text('Stepper Widget'),
      ),
      body: BlocBuilder(
        cubit: stepperBloc,
        builder: (context, state) {
          return state.value == StepperType.horizontal
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    child: Stepper(
                      currentStep: state.step,
                      steps: steps,
                      type: state.value,
                      onStepTapped: (step) {
                        print(step);
                        print('taplem');
                        stepperBloc.add(OnTapStep(step: step));
                      },
                      onStepCancel: () {
                        print(state.value);
                        print('stepp canceled');
                        stepperBloc.add(CancelStep());
                      },
                      onStepContinue: () {
                        print('stepp continued');
                        stepperBloc.add(ContinueStep());
                      },
                    ),
                  ),
                )
              : Container(
                  child: Form(
                    key: _formKey,
                    child: ListView(children: [
                      Stepper(
                        physics: ClampingScrollPhysics(),
                        currentStep: state.step,
                        steps: steps,
                        type: state.value,
                        onStepTapped: (step) {
                          print(step);
                          print('taplem');
                          stepperBloc.add(OnTapStep(step: step));
                        },
                        onStepCancel: () {
                          print(state.value);
                          print('stepp canceled');
                          stepperBloc.add(CancelStep());
                        },
                        onStepContinue: () {
                          print('stepp continued');
                          stepperBloc.add(ContinueStep());
                        },
                      ),
                      RaisedButton(
                        child: Text(
                          'Save details',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: _submitDetails,
                        color: Colors.blue,
                      ),
                    ]),
                  ),
                );
        },
      ),
    );
  }
}
