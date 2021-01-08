import 'package:crypto_template/controllers/beneficiary_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/component/custom_text_field.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:crypto_template/component/style.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;

class AddBeneficiary extends StatefulWidget {
  final WalletClass.Wallet wallet;
  AddBeneficiary({this.wallet});

  @override
  _AddBeneficiaryState createState() => _AddBeneficiaryState(wallet: wallet);
}

class _AddBeneficiaryState extends State<AddBeneficiary> {
  final WalletClass.Wallet wallet;
  _AddBeneficiaryState({this.wallet});

  BeneficiaryController beneficiaryController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final requiredValidator =
      RequiredValidator(errorText: 'this field is required');

  @override
  void initState() {
    beneficiaryController = Get.put(BeneficiaryController(wallet: wallet));
    super.initState();
  }

  _handleFormSubmit() async {
    final _formState = _formKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      print('if');
      beneficiaryController.addBeneficiary();
    } else {
      print('else');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Beneficiary',
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w600,
              fontSize: 18.5),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
        elevation: 1.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0),
                    child: CustomTextField(
                        validator: requiredValidator,
                        controller:
                            beneficiaryController.fullNameTextController,
                        label: 'Full Name',
                        obscure: false,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0),
                    child: CustomTextField(
                        controller:
                            beneficiaryController.accountNumberTextController,
                        validator: requiredValidator,
                        label: 'Account Number',
                        obscure: false,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0),
                    child: CustomTextField(
                        controller:
                            beneficiaryController.bankNameTextController,
                        validator: requiredValidator,
                        label: 'Bank Name',
                        obscure: false,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0),
                    child: CustomTextField(
                        controller:
                            beneficiaryController.bankSwiftCodeTextController,
                        label: 'Bank Swift Code (optional)',
                        obscure: false,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0),
                    child: CustomTextField(
                        controller: beneficiaryController
                            .intermediaryBankNameTextController,
                        label: 'Intermediary Bank Name (optional)',
                        obscure: false,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0),
                    child: CustomTextField(
                        controller: beneficiaryController
                            .intermediaryBankSwiftCodeTextController,
                        label: 'Intermediary Bank Swift Code (optional)',
                        obscure: false,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0),
                    child: CustomTextField(
                        // validator: requiredValidator,
                        maxLines: 5,
                        maxLength: 50,
                        controller:
                            beneficiaryController.descriptionTextController,
                        label: 'Description',
                        obscure: false,
                        keyboardType: TextInputType.multiline,
                        textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        _handleFormSubmit();
                      },
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(0.0)),
                          color: colorStyle.primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20.0,
                                letterSpacing: 1.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
