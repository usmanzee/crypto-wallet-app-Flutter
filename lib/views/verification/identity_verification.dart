import 'package:crypto_template/component/no_data.dart';
import 'package:crypto_template/controllers/verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:crypto_template/controllers/otp_controller.dart';

class IdentityVerification extends StatelessWidget {
  final VerificationController verificationController = Get.find();
  final GlobalKey<FormState> _nameForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _addressFormKey = GlobalKey<FormState>();
  final StepperType stepperType = StepperType.horizontal;

  final _firstNameValidator =
      RequiredValidator(errorText: 'This field is required');
  final _lastNameValidator =
      RequiredValidator(errorText: 'This field is required');
  final _dateOfBirthValidator =
      RequiredValidator(errorText: 'This field is required');
  final _addressValidator =
      RequiredValidator(errorText: 'This field is required');
  final _cityValidator = RequiredValidator(errorText: 'This field is required');
  final _postCodeValidator =
      RequiredValidator(errorText: 'This field is required');

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Obx(
        () => Container(
          child: new Stepper(
            physics: ClampingScrollPhysics(),
            steps: _myStep(context),
            currentStep: verificationController.currentStep,
            onStepTapped: (step) {},
            controlsBuilder: _createEventControlBuilder,
            onStepContinue: () {
              if (verificationController.currentStep <
                  this._myStep(context).length - 1) {
                print(verificationController.currentStep);
                if (verificationController.currentStep == 0) {
                  final _formState = _nameForm.currentState;
                  if (_formState.validate()) {
                    _formState.save();
                    verificationController.currentStep =
                        verificationController.currentStep + 1;
                  }
                } else {
                  verificationController.currentStep =
                      verificationController.currentStep + 1;
                }
              } else {
                final _formState = _addressFormKey.currentState;
                if (_formState.validate()) {
                  _formState.save();
                  verificationController.verifyIdentity();
                }
              }
            },
            onStepCancel: () {
              if (verificationController.currentStep > 0) {
                verificationController.currentStep =
                    verificationController.currentStep - 1;
              } else {
                verificationController.currentStep = 0;
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _createEventControlBuilder(BuildContext context,
      {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (verificationController.currentStep != 0)
            FlatButton(
              onPressed: onStepCancel,
              height: 30.0,
              minWidth: 40.0,
              color: Theme.of(context).hintColor,
              child: Text(
                "Back",
                style: TextStyle(fontSize: 10),
              ),
            )
          else
            Container(),
          FlatButton(
            onPressed: onStepContinue,
            height: 30.0,
            minWidth: 40.0,
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            child: Text(
              "Next",
              style: TextStyle(fontSize: 10),
            ),
          ),
        ]);
  }

  List<Step> _myStep(context) {
    List<Step> _steps = [
      Step(
          title: Text('Name/DOB'),
          content: Column(
            children: <Widget>[
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _nameForm,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller:
                          verificationController.firstNameTextController,
                      validator: _firstNameValidator,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          labelText: 'First Name',
                          hintText: 'Enter Your First Name'),
                    ),
                    TextFormField(
                      controller: verificationController.lastNameTextController,
                      validator: _lastNameValidator,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          labelText: 'Last Name',
                          hintText: 'Enter Your Last Name'),
                    ),
                    TextFormField(
                      controller:
                          verificationController.dateOfBirthTextController,
                      validator: _dateOfBirthValidator,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          labelText: 'Date of Birth',
                          hintText: 'Enter Your Date of Birth'),
                    ),
                  ],
                ),
              )
            ],
          ),
          isActive: verificationController.currentStep >= 0,
          state: StepState.indexed),
      Step(
          title: Text('Country/Nationality'),
          content: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  showCountriesList(context);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color:
                          Theme.of(context).textSelectionColor.withOpacity(0.7),
                      width: 1.0,
                    ),
                  )),
                  child: Center(
                      child:
                          Text(verificationController.selectedCountry.value)),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                  showNationalitiesList(context);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color:
                          Theme.of(context).textSelectionColor.withOpacity(0.7),
                      width: 1.0,
                    ),
                  )),
                  child: Center(
                      child: Text(
                          verificationController.selectedNationality.value)),
                ),
              ),
            ],
          ),
          isActive: verificationController.currentStep >= 1,
          state: StepState.indexed),
      Step(
          title: Text('Address'),
          content: Column(
            children: <Widget>[
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _addressFormKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: verificationController.addressTextController,
                      validator: _addressValidator,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          labelText: 'Address', hintText: 'Enter Your Address'),
                    ),
                    TextFormField(
                      controller: verificationController.cityTextController,
                      validator: _cityValidator,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          labelText: 'Enter City', hintText: 'Enter Your City'),
                    ),
                    TextFormField(
                      controller: verificationController.postCodeTextController,
                      validator: _postCodeValidator,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          labelText: 'Enter Pin Code',
                          hintText: 'Enter Your Area Pin Code'),
                    ),
                  ],
                ),
              )
            ],
          ),
          isActive: verificationController.currentStep >= 2,
          state: StepState.indexed),
    ];
    return _steps;
  }

  void showCountriesList(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return Obx(() {
            return FractionallySizedBox(
              heightFactor: 0.9,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: EdgeInsets.fromLTRB(8, 24, 8, 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: verificationController.countries.isEmpty
                              ? NoData()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (ctx, i) {
                                    return countriesList(ctx,
                                        verificationController.countries[i]);
                                  },
                                  itemCount:
                                      verificationController.countries.length,
                                ),
                        ),
                      ]),
                ),
              ),
            );
          });
        });
  }

  void showNationalitiesList(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return Obx(() {
            return FractionallySizedBox(
              heightFactor: 0.9,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: EdgeInsets.fromLTRB(8, 24, 8, 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: verificationController.nationalities.isEmpty
                              ? NoData()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (ctx, i) {
                                    return nationalitiesList(
                                        ctx,
                                        verificationController
                                            .nationalities[i]);
                                  },
                                  itemCount: verificationController
                                      .nationalities.length,
                                ),
                        ),
                      ]),
                ),
              ),
            );
          });
        });
  }

  Widget countriesList(BuildContext ctx, country) {
    return Obx(() {
      return Card(
        color: verificationController.selectedCountry.value == country
            ? Theme.of(ctx).canvasColor
            : Theme.of(ctx).scaffoldBackgroundColor,
        child: ListTile(
          leading: Radio(
            value: country,
            groupValue: verificationController.selectedCountry.value,
            onChanged: (var value) {
              verificationController.selectedCountry.value = value;
            },
          ),
          title: Text(country),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            verificationController.selectedCountry.value = country;
            verificationController.residencyTextController.text = country;
            Get.back();
          },
        ),
      );
    });
  }

  Widget nationalitiesList(BuildContext ctx, nationality) {
    return Obx(() {
      return Card(
        color: verificationController.selectedNationality.value == nationality
            ? Theme.of(ctx).canvasColor
            : Theme.of(ctx).scaffoldBackgroundColor,
        child: ListTile(
          leading: Radio(
            value: nationality,
            groupValue: verificationController.selectedNationality.value,
            onChanged: (var value) {
              verificationController.selectedNationality.value = value;
            },
          ),
          title: Text(nationality),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            verificationController.selectedNationality.value = nationality;
            verificationController.nationalityTextController.text = nationality;
            Get.back();
          },
        ),
      );
    });
  }
}
