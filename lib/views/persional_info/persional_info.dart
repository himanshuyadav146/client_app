import 'package:client_app/core/index.dart';
import 'package:client_app/core/widgets/core_text.dart';
import 'package:flutter/material.dart';

import '../../core/utils/validator.dart';
import '../../core/widgets/core_text_form_field.dart';

class PersionalInfo extends StatefulWidget {
  const PersionalInfo({super.key});

  @override
  State<PersionalInfo> createState() => _PersionalInfoState();
}

class _PersionalInfoState extends State<PersionalInfo> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _middleName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _dob = TextEditingController();
  final _pan = TextEditingController();
  final _financialYear = TextEditingController();
  bool _formSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return CoreScaffold(
        title: 'Persional Information',
        appBarBackgroundColor: Theme.of(context).primaryColor,
        appBarForegroundColor: Colors.white,
        showBackButton: true,
        body: Padding(
          padding: AppPadding.paddingAllM,
          child: _persionalInfoForm(),
        ),
        isDrawer: false,
        isResizeToAvoidBottomInset: false);
  }

  Widget _persionalInfoForm() {
    return Form(
      key: _formKey,
      autovalidateMode: _formSubmitted
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CoreLevel(text: 'Financial Year | Assessment Year'),
                const SizedBox(height: AppSizes.paddingXXS),
                CoreTextFormField(
                  controller: _financialYear,
                  hintText: 'Enter Financial Year',
                  hintStyle: TextStyle(
                    color: kBorderColor,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (!UtilValidators.isValidNumeric(value ?? '')) {
                      return 'Please enter a valid numeric value';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: kDarkParticlesColor),
                    border: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: kDarkParticlesColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: kDarkParticlesColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: kDarkParticlesColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide:
                          BorderSide(color: kDarkParticlesColor.withBlue(5)),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.paddingXXS),
                CoreLevel(text: 'First Name'),
                const SizedBox(height: AppSizes.paddingXXS),
                CoreTextFormField(
                  controller: _firstName,
                  hintText: 'First Name',
                  hintStyle: TextStyle(
                    color: kBorderColor,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (!UtilValidators.isValidString(value ?? '')) {
                      return 'Please enter First Name';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: kDarkParticlesColor),
                    border: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: kDarkParticlesColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: kDarkParticlesColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: kDarkParticlesColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide:
                          BorderSide(color: kDarkParticlesColor.withBlue(5)),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.paddingXXS),
                CoreLevel(text: 'Middle Name'),
                const SizedBox(height: AppSizes.paddingXXS),
                CoreTextFormField(
                  controller: _middleName,
                  hintText: 'Enter Financial Year',
                  hintStyle: TextStyle(
                    color: kBorderColor,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (!UtilValidators.isValidString(value ?? '')) {
                      return 'Please enter Middle Name';
                    }
                    return null; // Success
                  },
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: kDarkParticlesColor),
                    border: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: kDarkParticlesColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: kDarkParticlesColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: kDarkParticlesColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide:
                          BorderSide(color: kDarkParticlesColor.withBlue(5)),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.paddingXXS),
                CoreLevel(text: 'Last Name'),
                const SizedBox(height: AppSizes.paddingXXS),
                CoreTextFormField(
                  controller: _lastName,
                  hintText: 'Enter Financial Year',
                  hintStyle: TextStyle(
                    color: kBorderColor,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (!UtilValidators.isValidString(value ?? '')) {
                      return 'Please enter Last Name';
                    }
                    return null; // Success
                  },
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: kDarkParticlesColor),
                    border: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: kDarkParticlesColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: kDarkParticlesColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: kDarkParticlesColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide:
                          BorderSide(color: kDarkParticlesColor.withBlue(5)),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.paddingXXS),
                CoreLevel(text: 'Email'),
                const SizedBox(height: AppSizes.paddingXXS),
                CoreTextFormField(
                  controller: _email,
                  hintText: 'Enter Financial Year',
                  hintStyle: TextStyle(
                    color: kBorderColor,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (!UtilValidators.isValidEmail(value ?? '')) {
                      return 'Please enter Email';
                    }
                    return null; // Success
                  },
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: kDarkParticlesColor),
                    border: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: kDarkParticlesColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: kDarkParticlesColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: kDarkParticlesColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide:
                          BorderSide(color: kDarkParticlesColor.withBlue(5)),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.paddingXXS),
                CoreLevel(text: 'PAN'),
                const SizedBox(height: AppSizes.paddingXXS),
                CoreTextFormField(
                  controller: _pan,
                  hintText: 'Enter PAN',
                  hintStyle: TextStyle(
                    color: kBorderColor,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (!UtilValidators.isValidString(value ?? '')) {
                      return 'Please enter PAN';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: kDarkParticlesColor),
                    border: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: kDarkParticlesColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: kDarkParticlesColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: kDarkParticlesColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide:
                          BorderSide(color: kDarkParticlesColor.withBlue(5)),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.paddingXXS),
                CoreLevel(text: 'DOB'),
                const SizedBox(height: AppSizes.paddingXXS),
                CoreTextFormField(
                  controller: _dob,
                  hintText: 'Enter DOB',
                  hintStyle: TextStyle(
                    color: kBorderColor,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (!UtilValidators.isValidString(value ?? '')) {
                      return 'Please enter DOB';
                    }
                    return null;  // Success
                  },
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: kDarkParticlesColor),
                    border: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: kDarkParticlesColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: kDarkParticlesColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: kDarkParticlesColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: AppRadius.radiusAllS,
                      borderSide:
                          BorderSide(color: kDarkParticlesColor.withBlue(5)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          _buildFormSubmit()
        ],
      ),
    );
  }

  Widget _buildFormSubmit() {
    return CoreButton(text: 'Submit', onPressed: () {
      setState(() {
        _formSubmitted = true;
      });

      if (_formKey.currentState?.validate() ?? false) {
        // Form is valid, proceed with submission
      }
    });
  }
}
