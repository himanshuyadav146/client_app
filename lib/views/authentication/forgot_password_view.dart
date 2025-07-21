import 'package:client_app/core/index.dart';
import 'package:client_app/core/widgets/core_text.dart';
import 'package:client_app/core/widgets/core_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:client_app/core/di/di_container.dart';

import '../../blocs/auth/email_auth_bloc.dart';
import '../../core/constant/icon_constant.dart';
import '../../core/utils/enums.dart';
import '../../core/utils/validator.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmailAuthBloc>(),
      child: CoreScaffold(
        title: 'Forgot Password',
        body: BlocListener<EmailAuthBloc, EmailAuthState>(
          listenWhen: (previous, current) =>
              previous.apiStatus != current.apiStatus,
          listener: (context, state) {
            if (state.apiStatus == ApiStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.statusMessage)),
              );
              // Navigate back to login after successful password reset request
              GoRouter.of(context).pop();
            } else if (state.apiStatus == ApiStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.statusMessage)),
              );
            }
          },
          child: _buildForgotPasswordForm(),
        ),
        isDrawer: false,
        isResizeToAvoidBottomInset: false,
      ),
    );
  }

  Widget _buildForgotPasswordForm() {
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
                ICON_CONST.phone, // Using existing icon
                width: 330,
                height: 250,
              ),
            ),
            const SizedBox(height: AppSizes.textSizeXL),
            CoreLevel(
              textAlign: TextAlign.center,
              text: 'Forgot Password',
              style: const TextStyle(
                fontSize: AppSizes.textSize22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.textSizeXL),
            CoreLevel(
              textAlign: TextAlign.center,
              text: 'Enter your email address and we will send you a link to reset your password',
              style: const TextStyle(
                fontSize: AppSizes.textSizeL,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: AppSizes.textSizeXL),
            _buildEmailField(),
            const SizedBox(height: 20),
            _buildResetPasswordButton(),
            const SizedBox(height: 20),
            _buildBackToLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return BlocBuilder<EmailAuthBloc, EmailAuthState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CoreTextFormField(
          controller: _emailController,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!UtilValidators.isValidEmail(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
          onChanged: (value) =>
              context.read<EmailAuthBloc>().add(EmailChange(email: value)),
          decoration: InputDecoration(
            hintText: 'Enter your email address',
            hintStyle: TextStyle(color: kDarkParticlesColor),
            border: OutlineInputBorder(
              borderRadius: AppRadius.radiusAllS,
            ),
            prefixIcon: const Icon(Icons.email),
          ),
        );
      },
    );
  }

  Widget _buildResetPasswordButton() {
    return BlocBuilder<EmailAuthBloc, EmailAuthState>(
      builder: (context, state) {
        return CoreButton(
          isLoading: state.apiStatus == ApiStatus.loading,
          text: 'Send Reset Link',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<EmailAuthBloc>().add(ForgotPasswordSubmit());
            }
          },
        );
      },
    );
  }

  Widget _buildBackToLoginButton() {
    return TextButton(
      onPressed: () {
        GoRouter.of(context).pop();
      },
      child: const Text(
        'Back to Login',
        style: TextStyle(
          fontSize: AppSizes.textSize22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
} 