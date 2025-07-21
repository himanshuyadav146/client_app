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

class EmailSignupView extends StatefulWidget {
  const EmailSignupView({super.key});

  @override
  State<EmailSignupView> createState() => _EmailSignupViewState();
}

class _EmailSignupViewState extends State<EmailSignupView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _mobileController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmailAuthBloc>(),
      child: CoreScaffold(
        title: 'Sign Up',
        body: BlocListener<EmailAuthBloc, EmailAuthState>(
          listenWhen: (previous, current) =>
              previous.apiStatus != current.apiStatus,
          listener: (context, state) {
            if (state.apiStatus == ApiStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.statusMessage)),
              );
              // Navigate to login after successful signup
              GoRouter.of(context).pushReplacement(RouteName.emailLogin);
            } else if (state.apiStatus == ApiStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.statusMessage)),
              );
            }
          },
          child: _buildSignupForm(),
        ),
        isDrawer: false,
        isResizeToAvoidBottomInset: false,
      ),
    );
  }

  Widget _buildSignupForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Center(
              child: SvgPicture.asset(
                ICON_CONST.phone, // Using existing icon
                width: 250,
                height: 200,
              ),
            ),
            const SizedBox(height: AppSizes.textSizeXL),
            CoreLevel(
              textAlign: TextAlign.center,
              text: 'Create Account',
              style: const TextStyle(
                fontSize: AppSizes.textSize22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.textSizeXL),
            CoreLevel(
              textAlign: TextAlign.center,
              text: 'Sign up to get started with your account',
              style: const TextStyle(
                fontSize: AppSizes.textSizeL,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: AppSizes.textSizeXL),
            _buildNameField(),
            const SizedBox(height: 20),
            _buildMobileField(),
            const SizedBox(height: 20),
            _buildEmailField(),
            const SizedBox(height: 20),
            _buildPasswordField(),
            const SizedBox(height: 20),
            _buildConfirmPasswordField(),
            const SizedBox(height: 20),
            _buildSignupButton(),
            const SizedBox(height: 20),
            _buildLoginLink(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return BlocBuilder<EmailAuthBloc, EmailAuthState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return CoreTextFormField(
          controller: _nameController,
          hintText: 'Full Name',
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            if (value.length < 2) {
              return 'Name must be at least 2 characters';
            }
            return null;
          },
          onChanged: (value) =>
              context.read<EmailAuthBloc>().add(NameChange(name: value)),
          decoration: InputDecoration(
            hintText: 'Enter your full name',
            hintStyle: TextStyle(color: kDarkParticlesColor),
            border: OutlineInputBorder(
              borderRadius: AppRadius.radiusAllS,
            ),
            prefixIcon: const Icon(Icons.person),
          ),
        );
      },
    );
  }

  Widget _buildMobileField() {
    return CoreTextFormField(
      controller: _mobileController,
      hintText: 'Mobile Number',
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your mobile number';
        }
        if (value.length < 10) {
          return 'Mobile number must be at least 10 digits';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Enter your mobile number',
        hintStyle: TextStyle(color: kDarkParticlesColor),
        border: OutlineInputBorder(
          borderRadius: AppRadius.radiusAllS,
        ),
        prefixIcon: const Icon(Icons.phone),
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

  Widget _buildConfirmPasswordField() {
    return CoreTextFormField(
      controller: _confirmPasswordController,
      hintText: 'Confirm Password',
      obscureText: _obscureConfirmPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your password';
        }
        if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Re-enter your password',
        hintStyle: TextStyle(color: kDarkParticlesColor),
        border: OutlineInputBorder(
          borderRadius: AppRadius.radiusAllS,
        ),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obscureConfirmPassword = !_obscureConfirmPassword;
            });
          },
        ),
      ),
    );
  }

  Widget _buildSignupButton() {
    return BlocBuilder<EmailAuthBloc, EmailAuthState>(
      builder: (context, state) {
        return CoreButton(
          isLoading: state.apiStatus == ApiStatus.loading,
          text: 'Sign Up',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<EmailAuthBloc>().add(EmailSignupSubmit());
            }
          },
        );
      },
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account? ",
          style: TextStyle(fontSize: AppSizes.textSizeM),
        ),
        TextButton(
          onPressed: () {
            GoRouter.of(context).push(RouteName.emailLogin);
          },
          child: const Text(
            'Login',
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