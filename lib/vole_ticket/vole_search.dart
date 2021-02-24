import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class SearchFormBloc extends FormBloc<String, String> {
  final select1 = SelectFieldBloc(
    items: ['One way', 'Round trip', 'Multi city'],
    validators: [
      FieldBlocValidators.required,
    ],
  );
  final select2 = SelectFieldBloc(
    items: ['Economic', 'Class'],
    validators: [
      FieldBlocValidators.required,
    ],
  );
  final select3 = SelectFieldBloc(
    items: ['Algeria', 'France', 'Italy'],
    validators: [
      FieldBlocValidators.required,
    ],
  );
  final select4 = SelectFieldBloc(
    items: ['Algeria', 'France', 'Italy'],
    validators: [
      FieldBlocValidators.required,
    ],
  );
  final date1 = InputFieldBloc<DateTime, Object>(
    validators: [
      FieldBlocValidators.required,
    ],
  );
  final date2 = InputFieldBloc<DateTime, Object>(
    validators: [
      FieldBlocValidators.required,
    ],
  );
  final numberPerssonne = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );
  //final showSuccessResponse = BooleanFieldBloc();

  SearchFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        // showSuccessResponse,
        select1,
        select2,
        select3,
        select4,
        date1,
        date2,
        numberPerssonne,
      ],
    );
  }

  @override
  void onSubmitting() async {
    // action later aftere submution

    // await Future<void>.delayed(Duration(seconds: 1));

    //  if (showSuccessResponse.value) {
    //    emitSuccess();
    //  } else {
    //    emitFailure(failureResponse: 'This is an awesome error!');
    //  }
  }
}

class SearchVoleForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchFormBloc(),
      child: Builder(
        builder: (context) {
          final searchFormBloc = context.bloc<SearchFormBloc>();

          return Theme(
            data: Theme.of(context).copyWith(
              textTheme: TextTheme(
                subtitle1: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.all(0),
                alignLabelWithHint: true,
              ),
            ),
            child: Container(
              child: FormBlocListener<SearchFormBloc, String, String>(
                /*
              onSubmitting: (context, state) {
                //  LoadingDialog.show(context);
              },
              onSuccess: (context, state) {
                // LoadingDialog.hide(context);

                // Navigator.of(context).pushReplacement(
                // MaterialPageRoute(builder: (_) => SuccessScreen()));
              },
              onFailure: (context, state) {
                // LoadingDialog.hide(context);

                // Scaffold.of(context).showSnackBar(
                //   SnackBar(content: Text(state.failureResponse)));
              },
              */
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      verticalDirection: VerticalDirection.down,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 4, right: 4),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: DropdownFieldBlocBuilder(
                                  selectFieldBloc: searchFormBloc.select1,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 16),
                                    labelText: 'Type',
                                  ),
                                  itemBuilder: (context, value) => value,
                                ),
                              ),
                              SizedBox(width: 4),
                              Container(
                                width: 80,
                                child: TextFieldBlocBuilder(
                                  textFieldBloc: searchFormBloc.numberPerssonne,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                  ),
                                ),
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: DropdownFieldBlocBuilder(
                                  selectFieldBloc: searchFormBloc.select2,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 16),
                                    labelText: 'Type1',
                                  ),
                                  itemBuilder: (context, value) => value,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4, right: 4),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: DropdownFieldBlocBuilder(
                                  selectFieldBloc: searchFormBloc.select3,
                                  decoration: InputDecoration(
                                    labelText: 'Depart',
                                    prefixIcon: Icon(Icons.location_on),
                                  ),
                                  itemBuilder: (context, value) => value,
                                ),
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: DropdownFieldBlocBuilder(
                                  selectFieldBloc: searchFormBloc.select4,
                                  decoration: InputDecoration(
                                    labelText: 'Arrived',
                                    prefixIcon: Icon(Icons.location_on),
                                  ),
                                  itemBuilder: (context, value) => value,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4, right: 4),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: DateTimeFieldBlocBuilder(
                                  dateTimeFieldBloc: searchFormBloc.date1,
                                  format: DateFormat('dd-MM-yyyy'),
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                  decoration: InputDecoration(
                                    labelText: 'Date Aller',
                                    prefixIcon: Icon(Icons.calendar_today),
                                  ),
                                ),
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: DateTimeFieldBlocBuilder(
                                  dateTimeFieldBloc: searchFormBloc.date2,
                                  format: DateFormat('dd-MM-yyyy'),
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                  decoration: InputDecoration(
                                    labelText: 'Date Retour',
                                    prefixIcon: Icon(Icons.calendar_today),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4, left: 4, right: 4, bottom: 0),
                          child: Container(
                            height: 45,
                            width: double.infinity,
                            child: RaisedButton(
                              onPressed: searchFormBloc.submit,
                              child: Text(
                                'Search',
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
          );
        },
      ),
    );
  }
}

/*
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
                  MaterialPageRoute(builder: (_) => LoginForm())),
              icon: Icon(Icons.replay),
              label: Text('AGAIN'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
