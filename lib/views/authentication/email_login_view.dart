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

class EmailLoginView extends StatefulWidget {
  const EmailLoginView({super.key});

  @override
  State<EmailLoginView> createState() => _EmailLoginViewState();
}

class _EmailLoginViewState extends State<EmailLoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmailAuthBloc>(),
      child: CoreScaffold(
        title: 'Login',
        body: BlocListener<EmailAuthBloc, EmailAuthState>(
          listenWhen: (previous, current) =>
              previous.apiStatus != current.apiStatus,
          listener: (context, state) {
            if (state.apiStatus == ApiStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.statusMessage)),
              );
              // Navigate to home after successful login
              GoRouter.of(context).pushReplacement(RouteName.tabbarScreen);
            } else if (state.apiStatus == ApiStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.statusMessage)),
              );
            }
          },
          child: _buildLoginForm(),
        ),
        isDrawer: false,
        isResizeToAvoidBottomInset: false,
      ),
    );
  }

  Widget _buildLoginForm() {
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
              text: 'Welcome Back',
              style: const TextStyle(
                fontSize: AppSizes.textSize22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.textSizeXL),
            CoreLevel(
              textAlign: TextAlign.center,
              text: 'Sign in to your account to continue',
              style: const TextStyle(
                fontSize: AppSizes.textSizeL,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: AppSizes.textSizeXL),
            _buildEmailField(),
            const SizedBox(height: 20),
            _buildPasswordField(),
            const SizedBox(height: 20),
            _buildLoginButton(),
            const SizedBox(height: 20),
            _buildForgotPasswordButton(),
            const SizedBox(height: 20),
            _buildSignupLink(),
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

  Widget _buildPasswordField() {
    return BlocBuilder<EmailAuthBloc, EmailAuthState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CoreTextFormField(
          controller: _passwordController,
          hintText: 'Password',
          obscureText: _obscurePassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
          onChanged: (value) =>
              context.read<EmailAuthBloc>().add(PasswordChange(password: value)),
          decoration: InputDecoration(
            hintText: 'Enter your password',
            hintStyle: TextStyle(color: kDarkParticlesColor),
            border: OutlineInputBorder(
              borderRadius: AppRadius.radiusAllS,
            ),
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<EmailAuthBloc, EmailAuthState>(
      builder: (context, state) {
        return CoreButton(
          isLoading: state.apiStatus == ApiStatus.loading,
          text: 'Login',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<EmailAuthBloc>().add(EmailLoginSubmit());
            }
          },
        );
      },
    );
  }

  Widget _buildForgotPasswordButton() {
    return TextButton(
      onPressed: () {
        GoRouter.of(context).push(RouteName.forgotPassword);
      },
      child: const Text(
        'Forgot Password?',
        style:  TextStyle(
          fontSize: AppSizes.textSize22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSignupLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(fontSize: AppSizes.textSizeM),
        ),
        TextButton(
          onPressed: () {
            GoRouter.of(context).push(RouteName.emailSignup);
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(
              fontSize: AppSizes.textSize22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
} 