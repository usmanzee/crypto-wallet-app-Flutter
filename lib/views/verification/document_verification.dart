import 'package:crypto_template/controllers/verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:path/path.dart';

class DocumentVerification extends StatelessWidget {
  final GlobalKey<FormState> _documentFormKey = GlobalKey<FormState>();

  // final _documentValidator =
  //     RequiredValidator(errorText: 'This field is required');
  final _documentNumberValidator = MultiValidator([
    RequiredValidator(errorText: 'This field is required.'),
  ]);
  final _documentExpiryValidator = MultiValidator([
    RequiredValidator(errorText: 'This field is required.'),
  ]);
  final VerificationController verificationController = Get.find();

  final myFormat = DateFormat('d/MM/yyyy');

  Future<void> _selectDate(BuildContext context) async {
    var themeData = Get.isDarkMode ? ThemeData.dark() : ThemeData.light();
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: verificationController.currentDate.value,
      firstDate: DateTime(1970),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: themeData.copyWith(
            colorScheme: Get.isDarkMode
                ? ColorScheme.dark(
                    primary: Theme.of(context).primaryColor,
                  )
                : ColorScheme.light(
                    primary: Theme.of(context).primaryColor,
                  ),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != verificationController.currentDate.value)
      verificationController.documentExpiryTextController.text =
          myFormat.format(picked);
  }

  Future<void> _selectDocumentFile(
      context, bool isDocument, bool isAdditional) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Upload Picture'),
                      onTap: () async {
                        Get.back();
                        File image = await _imgFromGallery();
                        if (image != null) {
                          String fileName = basename(image.path);
                          if (isDocument) {
                            verificationController.documentFile.value = image;
                            verificationController.documentFileName.value =
                                fileName;
                            verificationController.documentFilePath.value =
                                image.path;
                            verificationController.documentFileBytes
                                .assignAll(image.readAsBytesSync());
                            documentImageValidation();
                          }
                          if (isAdditional) {
                            verificationController.additionalFile.value = image;
                            verificationController.additionalFileName.value =
                                fileName;
                            verificationController.additionalFilePath.value =
                                image.path;
                            verificationController.additionalFileBytes
                                .assignAll(image.readAsBytesSync());
                            additionalImageValidation();
                          }
                        }
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () async {
                      Get.back();

                      File image = await _imgFromCamera();
                      if (image != null) {
                        String fileName = basename(image.path);
                        if (isDocument) {
                          verificationController.documentFile.value = image;
                          verificationController.documentFileName.value =
                              fileName;
                          verificationController.documentFilePath.value =
                              image.path;
                          verificationController.documentFileBytes
                              .assignAll(image.readAsBytesSync());
                          documentImageValidation();
                        }
                        if (isAdditional) {
                          verificationController.additionalFile.value = image;
                          verificationController.additionalFileName.value =
                              fileName;
                          verificationController.additionalFilePath.value =
                              image.path;
                          verificationController.additionalFileBytes
                              .assignAll(image.readAsBytesSync());
                          additionalImageValidation();
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<File> _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    return image;
  }

  Future<File> _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    return image;
  }

  void _submitDocumentForm() {
    final _formState = _documentFormKey.currentState;
    documentImageValidation();
    additionalImageValidation();
    selfieValidation();
    if (_formState.validate() &&
        !verificationController.documentFileError.value &&
        !verificationController.additionalFileError.value &&
        !verificationController.selfieError.value) {
      _formState.save();
      verificationController.verifyDocuments();
    }
  }

  void documentImageValidation() {
    if (verificationController.documentFileName.value != '') {
      verificationController.documentFileError.value = false;
      verificationController.documentFileErrorMessage.value = '';
    } else {
      verificationController.documentFileError.value = true;
      verificationController.documentFileErrorMessage.value =
          'This Image is required.';
    }
  }

  void additionalImageValidation() {
    if (verificationController.additionalFileName.value != '') {
      verificationController.additionalFileError.value = false;
      verificationController.additionalFileErrorMessage.value = '';
    } else {
      verificationController.additionalFileError.value = true;
      verificationController.additionalFileErrorMessage.value =
          'This Image is required.';
    }
  }

  void selfieValidation() {
    if (verificationController.selfieName.value != '') {
      verificationController.selfieError.value = false;
      verificationController.selfieErrorMessage.value = '';
    } else {
      verificationController.selfieError.value = true;
      verificationController.selfieErrorMessage.value =
          'This Image is required.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() {
        return
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: <Widget>[
            //     SizedBox(height: 10),
            Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _documentFormKey,
          child: Column(
              // scrollDirection: Axis.vertical, shrinkWrap: true,
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
                    // validator: _documentValidator,
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
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
                              var newOption = verificationController
                                  .documentTypes
                                  .where((documentType) =>
                                      documentType['type'] == newOptionValue)
                                  .single;
                              verificationController.selectedDocumentType
                                  .assignAll(newOption);
                            },
                            items: verificationController.documentTypes
                                .map((documentType) {
                              return DropdownMenuItem<String>(
                                value: documentType['type'].toString(),
                                child: Text(documentType['name'].toString()),
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
                    validator: _documentNumberValidator,
                    cursorColor: Theme.of(context).hintColor,
                    controller:
                        verificationController.documentNumberTextController,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(
                          fontSize: 13.5,
                        ),
                        errorMaxLines: 3,
                        filled: true,
                        fillColor: Colors.transparent,
                        // labelText: 'Number',
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
                      validator: _documentExpiryValidator,
                      controller:
                          verificationController.documentExpiryTextController,
                      decoration: InputDecoration(
                          errorStyle:
                              TextStyle(fontSize: 13.5, color: Colors.red),
                          errorMaxLines: 3,
                          filled: true,
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  InkWell(
                    onTap: () {
                      _selectDocumentFile(context, true, false);
                    },
                    child: Container(
                      width: double.infinity,
                      // height: 100.0,
                      padding: const EdgeInsets.all(40.0),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).accentColor)),
                      child: Center(
                          child: Text(
                              "Upload ${verificationController.selectedDocumentType['name']} Clear Picture")),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  if (verificationController.documentFileName.value != '')
                    Row(children: [
                      Container(
                        height: 50,
                        child: Image.file(File(
                            verificationController.documentFilePath.value)),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Text(
                          verificationController.documentFileName.value,
                          style: TextStyle(
                              fontFamily: 'sans',
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                  if (verificationController.documentFileError.value)
                    Text(
                      verificationController.documentFileErrorMessage.value,
                      style: TextStyle(
                          fontFamily: 'sans', fontSize: 12, color: Colors.red),
                    ),
                ]),
                if (verificationController.selectedDocumentType['type'] !=
                    'utility_bill')
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        InkWell(
                          onTap: () {
                            _selectDocumentFile(context, false, true);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(40.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).accentColor)),
                            child: Center(
                                child:
                                    Text("Upload Utility Bill Clear Picture")),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        if (verificationController.additionalFileName.value !=
                            '')
                          Row(children: [
                            Container(
                              height: 50,
                              child: Image.file(File(verificationController
                                  .additionalFilePath.value)),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Expanded(
                              child: Text(
                                verificationController.additionalFileName.value,
                                style: TextStyle(
                                    fontFamily: 'sans',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                        if (verificationController.additionalFileError.value)
                          Text(
                            verificationController
                                .additionalFileErrorMessage.value,
                            style: TextStyle(
                                fontFamily: 'sans',
                                fontSize: 12,
                                color: Colors.red),
                          ),
                        SizedBox(height: 8),
                      ]),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  InkWell(
                    onTap: () async {
                      File image = await _imgFromCamera();
                      if (image != null) {
                        String fileName = basename(image.path);
                        verificationController.selfie.value = image;
                        verificationController.selfieName.value = fileName;
                        verificationController.selfiePath.value = image.path;
                        verificationController.selfieBytes
                            .assignAll(image.readAsBytesSync());
                        selfieValidation();
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(40.0),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).accentColor)),
                      child: Center(child: Text("Take your selfie")),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  if (verificationController.selfieName.value != '')
                    Row(children: [
                      Container(
                        height: 50,
                        child: Image.file(
                            File(verificationController.selfiePath.value)),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Text(
                          verificationController.selfieName.value,
                          style: TextStyle(
                              fontFamily: 'sans',
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                  if (verificationController.selfieError.value)
                    Text(
                      verificationController.selfieErrorMessage.value,
                      style: TextStyle(
                          fontFamily: 'sans', fontSize: 12, color: Colors.red),
                    ),
                ]),
                MaterialButton(
                  minWidth: double.infinity,
                  child: Text('Submit'),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    _submitDocumentForm();
                  },
                ),
              ]),
        );
      }),
    );
  }
}
