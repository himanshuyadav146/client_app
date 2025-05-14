import 'package:client_app/core/index.dart';
import 'package:client_app/core/widgets/core_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/utils/validator.dart';
import '../../core/widgets/core_drop_down.dart';
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
  final _aadhaar = TextEditingController();

  bool _formSubmitted = false;

  String? _selectedFinancialYear;

  @override
  Widget build(BuildContext context) {
    return CoreScaffold(
      title: 'Personal Information',
      appBarBackgroundColor: Theme.of(context).primaryColor,
      appBarForegroundColor: Colors.white,
      showBackButton: true,
      isDrawer: false,
      isResizeToAvoidBottomInset: true,
      onBackButtonPressed: () {
        Navigator.of(context).pop();
      },
      body: Padding(
        padding: AppPadding.paddingAllM,
        child: Column(
          children: [
            Expanded(child: _buildForm()),
            const SizedBox(height: AppSizes.paddingM),
            _buildFormSubmit(context),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDOB(BuildContext context) async {
    final initialDate = DateTime.now().subtract(const Duration(days: 365 * 18));
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dob.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      autovalidateMode: _formSubmitted
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _formSectionLabel('Financial Year'),
            Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.paddingS),
              child: DropdownButtonHideUnderline(
                child: CoreDropdown<String>(
                  items: const ['2021-2022', '2022-2023', '2023-2024'],
                  value: _selectedFinancialYear,
                  onChanged: (value) {
                    setState(() {
                      _selectedFinancialYear = value;
                    });
                  },
                  prefixIcon: null,
                  decoration: _inputDecoration(hint: 'Select Financial Year'),
                  validator: (value) =>
                      value == null ? 'Please select a financial year' : null,
                ),
              ),
            ),
            _formSectionLabel('First Name'),
            _buildTextField(
              controller: _firstName,
              hintText: 'Enter First Name',
              validator: (value) => _validateRequired(value, 'First Name'),
            ),
            _formSectionLabel('Middle Name'),
            _buildTextField(
              controller: _middleName,
              hintText: 'Enter Middle Name',
              validator: (value) => _validateRequired(value, 'Middle Name'),
            ),
            _formSectionLabel('Last Name'),
            _buildTextField(
              controller: _lastName,
              hintText: 'Enter Last Name',
              validator: (value) => _validateRequired(value, 'Last Name'),
            ),
            _formSectionLabel('Email'),
            _buildTextField(
              controller: _email,
              hintText: 'Enter Email',
              keyboardType: TextInputType.emailAddress,
              validator: UtilValidators.validateEmail,
            ),
            _formSectionLabel('PAN'),
            _buildTextField(
              controller: _pan,
              hintText: 'Enter PAN',
              validator: UtilValidators.validatePAN,
            ),
            _formSectionLabel('Aadhaar Card Number'),
            _buildTextField(
              controller: _aadhaar,
              hintText: 'Enter Aadhaar Card Number',
              keyboardType: TextInputType.number,
              validator: UtilValidators.validateAadhaar,
            ),
            _formSectionLabel('Date of Birth'),
            GestureDetector(
              onTap: () => _selectDOB(context),
              child: AbsorbPointer(
                child: _buildTextField(
                  controller: _dob,
                  hintText: 'DD/MM/YYYY',
                  keyboardType: TextInputType.datetime,
                  validator: UtilValidators.validateDOB,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppSizes.paddingS, bottom: AppSizes.paddingXXS),
      child: CoreLevel(text: text),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.paddingS),
      child: CoreTextFormField(
        controller: controller,
        keyboardType: keyboardType,
        hintText: hintText,
        hintStyle: TextStyle(
          color: kBorderColor,
          fontSize: 14,
          fontStyle: FontStyle.italic,
        ),
        validator: validator,
        onChanged: (_) {},
        decoration: _inputDecoration(hint: hintText),
      ),
    );
  }

  InputDecoration _inputDecoration({required String hint}) {
    return InputDecoration(
      hintText: hint,
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
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadius.radiusAllS,
        borderSide: const BorderSide(color: Colors.red),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.radiusAllS,
        borderSide: BorderSide(color: kDarkParticlesColor.withBlue(5)),
      ),
    );
  }

  Widget _buildFormSubmit(BuildContext context) {
    return SafeArea(
      child: CoreButton(
        text: 'Submit',
        onPressed: () {
          setState(() => _formSubmitted = true);
          // if (_formKey.currentState?.validate() ?? false) {
          GoRouter.of(context).push(RouteName.importantDetails);
          // }
        },
      ),
    );
  }

  String? _validateRequired(String? value, String fieldName) {
    if (!UtilValidators.isValidString(value ?? '')) {
      return 'Please enter $fieldName';
    }
    return null;
  }
}
