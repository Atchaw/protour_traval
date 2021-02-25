import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:protour_traval/app_theme.dart';
import 'package:protour_traval/navigatoin_home_screen.dart';

class ReservationFormBloc extends FormBloc<String, String> {
  //--------------------------Bloc 1 ---------------

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

  ReservationFormBloc() {
    addFieldBlocs(
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
  }

  @override
  void onSubmitting() async {
    // action later aftere submution
    await Future<void>.delayed(Duration(milliseconds: 500));
    emitSuccess();
  }
}

class ReservationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.buildLightTheme(),
      child: BlocProvider(
        create: (context) => ReservationFormBloc(),
        child: Builder(
          builder: (context) {
            final reservationFormBloc = context.read<ReservationFormBloc>();
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
                  title: Text('Reservation Hotel'),
                ),
                body: SafeArea(
                  child: FormBlocListener<ReservationFormBloc, String, String>(
                    onSubmitting: (context, state) =>
                        LoadingDialog.show(context),
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
                    child: SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: <Widget>[
                                  TextFieldBlocBuilder(
                                    textFieldBloc:
                                        reservationFormBloc.firstName,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: 'Prenome',
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                  ),
                                  TextFieldBlocBuilder(
                                    textFieldBloc: reservationFormBloc.lastName,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: 'Nome de la famille',
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                  ),
                                  TextFieldBlocBuilder(
                                    textFieldBloc:
                                        reservationFormBloc.birthPlace,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: 'Lieu de naissance',
                                      prefixIcon: Icon(Icons.cake),
                                    ),
                                  ),
                                  DateTimeFieldBlocBuilder(
                                    dateTimeFieldBloc:
                                        reservationFormBloc.birthDate,
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
                                    textFieldBloc:
                                        reservationFormBloc.passportNumber,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Numero de passeport',
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                  ),
                                  DateTimeFieldBlocBuilder(
                                    dateTimeFieldBloc:
                                        reservationFormBloc.dateDelivrance,
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
                                    dateTimeFieldBloc:
                                        reservationFormBloc.dateExpiration,
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
                                    textFieldBloc: reservationFormBloc.email,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      prefixIcon: Icon(Icons.email),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Container(
                                height: 55,
                                width: double.infinity,
                                child: RaisedButton(
                                  onPressed: reservationFormBloc.submit,
                                  child: Text(
                                    'Payment',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
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
