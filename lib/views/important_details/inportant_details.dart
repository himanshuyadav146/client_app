import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/validator.dart';
import '../../core/widgets/core_text.dart';
import '../../core/widgets/core_text_form_field.dart';
import 'package:client_app/core/index.dart';

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

  final double spacing = AppSizes.paddingS;

  @override
  Widget build(BuildContext context) {
    return CoreScaffold(
      title: "Important Details",
      appBarBackgroundColor: Theme.of(context).primaryColor,
      appBarForegroundColor: Colors.white,
      showBackButton: true,
      isDrawer: false,
      isResizeToAvoidBottomInset: false,
      body: Padding(
        padding: AppPadding.paddingAllM,
        child: Column(
          children: [
            Expanded(child: _importantDetailsForm()),
            SizedBox(height: spacing),
            _buildFormSubmit(context),
          ],
        ),
      ),
    );
  }

  Widget _importantDetailsForm() {
    return Form(
      key: _formKey,
      autovalidateMode: _formSubmitted
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildField(
                'Interest Income', _interestIncome, TextInputType.number),
            SizedBox(height: spacing),
            _buildField(
                'Interest on RDs or FD', _interestOnFD, TextInputType.number),
            SizedBox(height: spacing),
            _buildField(
                'Any Other Income', _anyOtherIncome, TextInputType.number),
            SizedBox(height: spacing),
            CoreLevel(
              text: 'Current Address',
              style: TextStyle(
                color: kDarkPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: spacing),
            _buildField('Full Address', _address, TextInputType.streetAddress,
                validator: (value) {
              if (!UtilValidators.isValidString(value ?? '')) {
                return 'Please enter Address';
              }
              return null;
            }),
            SizedBox(height: spacing),
            _buildField('State', _state, TextInputType.text,
                validator: (value) {
              if (!UtilValidators.isValidString(value ?? '')) {
                return 'Please enter State';
              }
              return null;
            }),
            SizedBox(height: spacing),
            _buildField('City', _city, TextInputType.text, validator: (value) {
              if (!UtilValidators.isValidString(value ?? '')) {
                return 'Please enter City';
              }
              return null;
            }),
            SizedBox(height: spacing),
            _buildField('Enter Pin Code', _pin, TextInputType.number,
                validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter PIN code';
              } else if (!UtilValidators.isValidIndianPinCode(value)) {
                return 'Enter valid 6-digit Indian PIN code';
              }
              return null;
            }),
            SizedBox(height: spacing),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      TextInputType keyboardType,
      {String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CoreLevel(text: label),
        const SizedBox(height: AppSizes.paddingXXS),
        CoreTextFormField(
          controller: controller,
          hintText: label,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: (value) {},
          hintStyle: TextStyle(
            color: kBorderColor,
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
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
          ),
        ),
      ],
    );
  }

  Widget _buildFormSubmit(BuildContext context) {
    return SafeArea(
      child: CoreButton(
        text: 'Submit',
        onPressed: () {
          setState(() => _formSubmitted = true);

          // if (_formKey.currentState?.validate() ?? false) {
          GoRouter.of(context).push(RouteName.documentsUpload);
          // }
        },
      ),
    );
  }
}
