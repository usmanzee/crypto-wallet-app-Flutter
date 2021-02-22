import 'package:crypto_template/controllers/verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

class DocumentVerification extends StatelessWidget {
  final GlobalKey<FormState> _documentFormKey = GlobalKey();
  final VerificationController verificationController = Get.find();

  final DateTime selectedDate = DateTime.now();
  final myFormat = DateFormat('d/MM/yyyy');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      verificationController.documentExpiryTextController.text =
          myFormat.format(picked);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Form(
            key: _documentFormKey,
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Document Type",
                      style: TextStyle(
                        color: Theme.of(context).hintColor.withOpacity(0.7),
                        fontFamily: "Popins",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: FormField<String>(
                        // validator: _beneficiaryValidator,
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                // labelStyle: textStyle,
                                errorStyle: TextStyle(
                                    color: Colors.redAccent, fontSize: 16.0),
                                hintText: 'Please select beneficiary',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: verificationController
                                    .selectedDocumentType['type']
                                    .toString(),
                                isDense: true,
                                onChanged: (String newOptionValue) {
                                  print(newOptionValue);
                                  var newOption = verificationController
                                      .documentTypes
                                      .where((documentType) =>
                                          documentType['type'] ==
                                          newOptionValue)
                                      .single;
                                  print(newOption);
                                  verificationController.selectedDocumentType
                                      .assignAll(newOption);
                                },
                                items: verificationController.documentTypes
                                    .map((documentType) {
                                  return DropdownMenuItem<String>(
                                    value: documentType['type'].toString(),
                                    child:
                                        Text(documentType['name'].toString()),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Text(
                      "${verificationController.selectedDocumentType['name']} Number",
                      style: TextStyle(
                        color: Theme.of(context).hintColor.withOpacity(0.7),
                        fontFamily: "Popins",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: TextFormField(
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        // validator: (amount) {
                        //   if (withdrawController
                        //           .totalWithdrawlAmount.value >
                        //       double.parse(wallet.balance)) {
                        //     return 'Please enter a valid amount';
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        controller:
                            verificationController.documentNumberTextController,
                        onChanged: (amount) {
                          // var validAmount = amount != null && amount != ''
                          //     ? amount
                          //     : '0.0';
                          // withdrawController.amount.value = validAmount;
                          // withdrawController.totalWithdrawlAmount.value =
                          //     double.parse(validAmount) +
                          //         double.parse(wallet.fee);
                        },
                        decoration: InputDecoration(
                            errorStyle: TextStyle(
                              fontSize: 13.5,
                            ),
                            errorMaxLines: 3,
                            filled: true,
                            fillColor: Colors.transparent,
                            labelText: 'Number',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                    Text(
                      "${verificationController.selectedDocumentType['name']} Expiry",
                      style: TextStyle(
                        color: Theme.of(context).hintColor.withOpacity(0.7),
                        fontFamily: "Popins",
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextFormField(
                          obscureText: false,
                          enabled: false,
                          keyboardType: TextInputType.number,

                          // validator: (amount) {
                          //   if (withdrawController
                          //           .totalWithdrawlAmount.value >
                          //       double.parse(wallet.balance)) {
                          //     return 'Please enter a valid amount';
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          controller: verificationController
                              .documentExpiryTextController,

                          onChanged: (amount) {
                            // var validAmount = amount != null && amount != ''
                            //     ? amount
                            //     : '0.0';
                            // withdrawController.amount.value = validAmount;
                            // withdrawController.totalWithdrawlAmount.value =
                            //     double.parse(validAmount) +
                            //         double.parse(wallet.fee);
                          },
                          decoration: InputDecoration(
                              errorStyle: TextStyle(
                                fontSize: 13.5,
                              ),
                              errorMaxLines: 3,
                              filled: true,
                              fillColor: Colors.transparent,
                              labelText: 'Date',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                      ),
                    ),
                  ]),
              MaterialButton(
                minWidth: double.infinity,
                child: Text('Send Verification Code'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () async {
                  FilePickerResult result =
                      await FilePicker.platform.pickFiles();
                  print(result);
                },
              ),
              SizedBox(
                height: 10,
              ),
            ]),
          )
        ],
      );
    });
  }
}
