import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:protour_traval/navigatoin_home_screen.dart';

class AssuranceFormBloc extends FormBloc<String, String> {
  //--------------------------Bloc 2 ---------------
  final country = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final assuranceDuration = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final travelDate = InputFieldBloc<DateTime, Object>(
    validators: [FieldBlocValidators.required],
  );
  final personnNumber = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final travelDocumet = SelectFieldBloc(
    items: ['passport ordinaire'],
    validators: [FieldBlocValidators.required],
  );

  final nationalty = SelectFieldBloc(
    items: ['Algerian'],
    validators: [FieldBlocValidators.required],
    initialValue: 'Algerian',
  );
//--------------------------Bloc 2 ---------------
  final firstName = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final lastName = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final birthPlace = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final birthDate = InputFieldBloc<DateTime, Object>(
    validators: [FieldBlocValidators.required],
  );
  final passportNumber = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  final dateDelivrance = InputFieldBloc<DateTime, Object>(
    validators: [FieldBlocValidators.required],
  );
  final dateExpiration = InputFieldBloc<DateTime, Object>(
    validators: [FieldBlocValidators.required],
  );
  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.email,
    ],
  );
//--------------------------Bloc 3 ---------------
  final codition = BooleanFieldBloc();

  AssuranceFormBloc() {
    addFieldBlocs(
      step: 0,
      fieldBlocs: [
        country,
        assuranceDuration,
        travelDate,
        personnNumber,
        travelDocumet,
        nationalty
      ],
    );
    addFieldBlocs(
      step: 1,
      fieldBlocs: [
        firstName,
        lastName,
        birthPlace,
        birthDate,
        passportNumber,
        dateDelivrance,
        dateExpiration,
        email
      ],
    );
    addFieldBlocs(
      step: 2,
      fieldBlocs: [codition],
    );
  }

  @override
  void onSubmitting() async {
    if (state.currentStep == 0) {
      await Future.delayed(Duration(milliseconds: 500));
      emitSuccess();
    } else if (state.currentStep == 1) {
      await Future.delayed(Duration(milliseconds: 500));
      emitSuccess();
    } else if (state.currentStep == 2) {
      await Future.delayed(Duration(milliseconds: 500));
      emitSuccess();
    }
  }
}

class AssuranceForm extends StatefulWidget {
  @override
  _AssuranceFormState createState() => _AssuranceFormState();
}

class _AssuranceFormState extends State<AssuranceForm> {
  var _type = StepperType.horizontal;

  void _toggleType() {
    setState(() {
      if (_type == StepperType.horizontal) {
        _type = StepperType.vertical;
      } else {
        _type = StepperType.horizontal;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssuranceFormBloc(),
      child: Builder(
        builder: (context) {
          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text('Demande Assurance'),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(_type == StepperType.horizontal
                          ? Icons.swap_vert
                          : Icons.swap_horiz),
                      onPressed: _toggleType)
                ],
              ),
              body: SafeArea(
                child: FormBlocListener<AssuranceFormBloc, String, String>(
                  onSubmitting: (context, state) => LoadingDialog.show(context),
                  onSuccess: (context, state) {
                    LoadingDialog.hide(context);

                    if (state.stepCompleted == state.lastStep) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => SuccessScreen()));
                    }
                  },
                  onFailure: (context, state) {
                    LoadingDialog.hide(context);
                  },
                  child: StepperFormBlocBuilder<AssuranceFormBloc>(
                    type: _type,
                    physics: ClampingScrollPhysics(),
                    stepsBuilder: (formBloc) {
                      return [
                        _visaStep(formBloc),
                        _personalStep(formBloc),
                        _conditionStep(formBloc),
                      ];
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  FormBlocStep _visaStep(AssuranceFormBloc assuranceFormBloc) {
    return FormBlocStep(
      title: Text('Assurance'),
      content: Column(
        children: <Widget>[
          TextFieldBlocBuilder(
            textFieldBloc: assuranceFormBloc.country,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Pays',
              prefixIcon: Icon(Icons.location_on),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: assuranceFormBloc.assuranceDuration,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Durée par jour',
            ),
          ),
          DateTimeFieldBlocBuilder(
            dateTimeFieldBloc: assuranceFormBloc.travelDate,
            format: DateFormat('dd-MM-yyyy'),
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
            decoration: InputDecoration(
              labelText: 'Date debut du voyage',
              prefixIcon: Icon(Icons.calendar_today),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: assuranceFormBloc.personnNumber,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Nombre de personne',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          DropdownFieldBlocBuilder(
            selectFieldBloc: assuranceFormBloc.travelDocumet,
            decoration: InputDecoration(
              labelText: 'Document de voyage',
            ),
            itemBuilder: (context, value) => value,
          ),
          DropdownFieldBlocBuilder(
            selectFieldBloc: assuranceFormBloc.nationalty,
            decoration: InputDecoration(
              labelText: 'Nationality',
            ),
            itemBuilder: (context, value) => value,
          ),
        ],
      ),
    );
  }

  FormBlocStep _personalStep(AssuranceFormBloc assuranceFormBloc) {
    return FormBlocStep(
      title: Text('Personal'),
      content: Column(
        children: <Widget>[
          TextFieldBlocBuilder(
            textFieldBloc: assuranceFormBloc.firstName,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Prenome',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: assuranceFormBloc.lastName,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Nome de la famille',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: assuranceFormBloc.birthPlace,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Lieu de naissance',
              prefixIcon: Icon(Icons.cake),
            ),
          ),
          DateTimeFieldBlocBuilder(
            dateTimeFieldBloc: assuranceFormBloc.birthDate,
            firstDate: DateTime(1900),
            initialDate: DateTime.now(),
            lastDate: DateTime.now(),
            format: DateFormat('dd-MM-yyyy'),
            decoration: InputDecoration(
              labelText: 'Date de naissance',
              prefixIcon: Icon(Icons.cake),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: assuranceFormBloc.passportNumber,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Numero de passeport',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          DateTimeFieldBlocBuilder(
            dateTimeFieldBloc: assuranceFormBloc.dateDelivrance,
            format: DateFormat('dd-MM-yyyy'),
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            decoration: InputDecoration(
              labelText: 'Date delivration',
              prefixIcon: Icon(Icons.calendar_today),
            ),
          ),
          DateTimeFieldBlocBuilder(
            dateTimeFieldBloc: assuranceFormBloc.dateExpiration,
            format: DateFormat('dd-MM-yyyy'),
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
            decoration: InputDecoration(
              labelText: 'Date d\' expiration',
              prefixIcon: Icon(Icons.calendar_today),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: assuranceFormBloc.email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
          ),
        ],
      ),
    );
  }

  FormBlocStep _conditionStep(AssuranceFormBloc assuranceFormBloc) {
    return FormBlocStep(
      title: Text('Condition'),
      content: Column(
        children: <Widget>[
          CheckboxFieldBlocBuilder(
            booleanFieldBloc: assuranceFormBloc.codition,
            body: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                  'J\'accepte les conditions generale de la demande d\'assurance'),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  SuccessScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.tag_faces, size: 100),
            SizedBox(height: 10),
            Text(
              'Success',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            RaisedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => NavigationHomeScreen())),
              icon: Icon(Icons.replay),
              label: Text('Return To Home'),
            ),
          ],
        ),
      ),
    );
  }
}
