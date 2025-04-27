import 'package:client_app/core/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/validator.dart';
import '../../core/widgets/core_text.dart';
import '../../core/widgets/core_text_form_field.dart';

class ImportantDetails extends StatefulWidget {
  const ImportantDetails({super.key});

  @override
  State<ImportantDetails> createState() => _ImportantDetailsState();
}

class _ImportantDetailsState extends State<ImportantDetails> {

  final _formKey = GlobalKey<FormState>();
  final _interestIncome = TextEditingController();
  final _interestOnFD = TextEditingController();
  final _anyOtherIncome = TextEditingController();
  final _address = TextEditingController();
  final _state = TextEditingController();
  final _city = TextEditingController();
  final _pin = TextEditingController();
  bool _formSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return CoreScaffold(
        title: "Important Details",
        appBarBackgroundColor: Theme.of(context).primaryColor,
        appBarForegroundColor: Colors.white,
        showBackButton: true,
        body: Padding(
          padding: AppPadding.paddingAllM,
          child: Column(
            children: [
              Expanded(child: _importantDetailsForm()),
              const SizedBox(height: AppSizes.paddingS),
              _buildFormSubmit(context),
            ],
          ),
        ),
        isDrawer: false,
        isResizeToAvoidBottomInset: false
    );
  }

  Widget _importantDetailsForm() {
    return Form(
      key: _formKey,
      autovalidateMode: _formSubmitted
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CoreLevel(text: 'Interest Income'),
            const SizedBox(height: AppSizes.paddingXXS),
            CoreTextFormField(
              controller: _interestIncome,
              hintText: 'Interest Income',
              hintStyle: TextStyle(
                color: kBorderColor,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
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
            CoreLevel(text: 'Interest on RDs or FD'),
            const SizedBox(height: AppSizes.paddingXXS),
            CoreTextFormField(
              controller: _interestOnFD,
              hintText: 'Interest on RDs or FD',
              hintStyle: TextStyle(
                color: kBorderColor,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
              keyboardType: TextInputType.text,
              validator: (value) {// Success
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
            CoreLevel(text: 'Any Other Income'),
            const SizedBox(height: AppSizes.paddingXXS),
            CoreTextFormField(
              controller: _anyOtherIncome,
              hintText: 'Any Other Income',
              hintStyle: TextStyle(
                color: kBorderColor,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
              keyboardType: TextInputType.text,
              validator: (value) {// Success
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

            const SizedBox(height: AppSizes.paddingS),
              CoreLevel(
                  text: 'Current Address',
                  style: TextStyle(
                    color: kDarkPrimaryColor,
                    fontSize: 18,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600
                  )),
            const SizedBox(height: AppSizes.paddingS),

            CoreLevel(text: 'Full Address'),
            CoreTextFormField(
              controller: _address,
              hintText: 'Full Address',
              hintStyle: TextStyle(
                color: kBorderColor,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (!UtilValidators.isValidString(value ?? '')) {
                  return 'Please enter Address';
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
            CoreLevel(text: 'State'),
            const SizedBox(height: AppSizes.paddingXXS),
            CoreTextFormField(
              controller: _state,
              hintText: 'State',
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
            CoreLevel(text: 'City'),
            const SizedBox(height: AppSizes.paddingXXS),
            CoreTextFormField(
              controller: _city,
              hintText: 'Enter City',
              hintStyle: TextStyle(
                color: kBorderColor,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (!UtilValidators.isValidString(value ?? '')) {
                  return 'Please enter Aadhaar Card No';
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
            CoreLevel(text: 'Enter Pin Code'),
            const SizedBox(height: AppSizes.paddingXXS),
            CoreTextFormField(
              controller: _pin,
              hintText: 'Enter Pin Code',
              hintStyle: TextStyle(
                color: kBorderColor,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (!UtilValidators.isValidString(value ?? '')) {
                  return 'Please enter Aadhaar Card No';
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
        ]
        ),
      ),
    );
  }

  Widget _buildFormSubmit(BuildContext context) {
    return CoreButton(
        text: 'Submit',
        onPressed: () {
          setState(() {
            _formSubmitted = true;
          });

          if (_formKey.currentState?.validate() ?? false) {
            GoRouter.of(context).push(RouteName.documentsUpload);
          }
        });
  }
}
