import 'package:client_app/core/index.dart';
import 'package:client_app/core/widgets/core_text.dart';
import 'package:client_app/core/widgets/core_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/auth/login_bloc.dart';
import '../../core/constant/icon_constant.dart';
import '../../core/utils/enums.dart';
import '../../core/utils/validator.dart';

class PhoneNumberView extends StatefulWidget {
  const PhoneNumberView({super.key});

  @override
  State<PhoneNumberView> createState() => _PhoneNumberViewState();
}

class _PhoneNumberViewState extends State<PhoneNumberView> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CoreScaffold(
      title: 'Login',
      body: BlocListener<LoginBloc, LoginState>(
        listenWhen: (previous, current) =>
        previous.apiStatus != current.apiStatus,
        listener: (context, state) {
          if (state.apiStatus == ApiStatus.success) {
            GoRouter.of(context).push(
              RouteName.otpVerification,
              extra: state.phoneNo,
            );
          } else if (state.apiStatus == ApiStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.statusMessage)),
            );
          }
        },
        child: _buildPhoneNumberForm(),
      ),
      isDrawer: false,
      isResizeToAvoidBottomInset: false,
    );
  }

  Widget _buildPhoneNumberForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Center(
              child: SvgPicture.asset(
                ICON_CONST.phone,
                width: 330,
                height: 250,
              ),
            ),
            const SizedBox(height: AppSizes.textSizeXL),
            CoreLevel(
              textAlign: TextAlign.center,
              text: 'Verify Phone Number',
              style: const TextStyle(
                fontSize: AppSizes.textSize22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.textSizeXL),
            CoreLevel(
              textAlign: TextAlign.center,
              text: 'We will send you an OTP to verify your phone number',
              style: const TextStyle(
                fontSize: AppSizes.textSizeL,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: AppSizes.textSizeXL),
            _buildPhoneNumberField(),
            const SizedBox(height: 20),
            _buildSendOtpButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
      previous.phoneNo != current.phoneNo,
      builder: (context, state) {
        return CoreTextFormField(
          controller: _phoneNumberController,
          hintText: 'Enter phone number',
          keyboardType: TextInputType.phone,
          validator: (value) =>
          UtilValidators.isVietnamesePhoneNumber(value ?? '')
              ? 'Please enter a valid phone number'
              : null,
          onChanged: (value) =>
              context.read<LoginBloc>().add(PhoneNoChange(phoneNo: value)),
          decoration: InputDecoration(
            hintStyle: TextStyle(color: kDarkParticlesColor),
            border: OutlineInputBorder(
              borderRadius: AppRadius.radiusAllS,
            ),
            prefixIcon: const Icon(Icons.phone),
          ),
        );
      },
    );
  }

  Widget _buildSendOtpButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return CoreButton(
          isLoading: state.apiStatus == ApiStatus.loading,
          text: 'Send OTP',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<LoginBloc>().add(LoginSubmit());
            }
          },
        );
      },
    );
  }
}