import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Phone Field Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Container(
                //   // decoration: BoxDecoration(
                //   //   borderRadius: BorderRadius.circular(10),
                //   //   color: Colors.white,
                //   //   boxShadow: [
                //   //     BoxShadow(color: Colors.green, spreadRadius: 3),
                //   //   ],
                //   // ),
                //   child: IntlPhoneField(
                //     decoration: InputDecoration(
                //         errorStyle: TextStyle(
                //           fontSize: 13.5,
                //         ),
                //         errorMaxLines: 3,
                //         filled: true,
                //         fillColor: Colors.transparent,
                //         labelText: 'Address',
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(5))),
                //     onChanged: (phone) {
                //       print(phone.completeNumber);
                //     },
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  child: Text('Submit'),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    _formKey.currentState.validate();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
