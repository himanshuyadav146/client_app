import 'package:client_app/core/index.dart';
import 'package:client_app/core/widgets/core_text_form_field.dart';
import 'package:client_app/main.dart';
import 'package:client_app/views/blocs/auth/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/constant/icon_constant.dart';
import '../../core/utils/enums.dart';
import '../../core/utils/validator.dart';
import '../../core/widgets/core_text.dart';

class PhoneNoView extends StatefulWidget {
  const PhoneNoView({super.key});

  @override
  State<PhoneNoView> createState() => _PhoneNoViewState();
}

class _PhoneNoViewState extends State<PhoneNoView> {
  late final LoginBloc _loginBloc;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loginBloc = getIt<LoginBloc>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CoreScaffold(
      title: 'Login',
      body: BlocProvider<LoginBloc>.value(
        value: _loginBloc,
        child: BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) =>
              previous.apiStatus != current.apiStatus,
          listener: (context, state) {
            if (state.apiStatus == ApiStatus.success) {
              GoRouter.of(context).push(RouteName.otpVerification);
            } else if (state.apiStatus == ApiStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.statusMessage)),
              );
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state.apiStatus == ApiStatus.loading) {
                return const Center(child: LoaderWidget());
              }
              return _buildLoginForm();
            },
          ),
        ),
      ),
      isDrawer: false,
      isResizeToAvoidBottomInset: false,
    );
  }

  Widget _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Builder(builder: (context) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Center(
                child:
                    SvgPicture.asset(ICON_CONST.phone, width: 330, height: 250),
              ),
              const SizedBox(height: AppSizes.textSizeXL),
              CoreLevel(
                textAlign: TextAlign.center,
                text: kVerifyPhone,
                style: const TextStyle(
                  fontSize: AppSizes.textSize22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSizes.textSizeXL),
              CoreLevel(
                textAlign: TextAlign.center,
                text: kSentOTPText,
                style: const TextStyle(
                  fontSize: AppSizes.textSizeL,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: AppSizes.textSizeXL),
              _buildPhoneNoField(),
              const SizedBox(height: 20),
              _buildLoginButton(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildPhoneNoField() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.phoneNo != current.phoneNo,
      builder: (context, state) {
        return CoreTextFormField(
          controller: _emailController,
          hintText: 'Phone No',
          hintStyle: TextStyle(
            color: kBorderColor, // Custom hint text color
            fontSize: 14, // Custom hint text size
            fontStyle: FontStyle.italic, // Custom hint text style
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) =>
              UtilValidators.isVietnamesePhoneNumber(value ?? '')
                  ? 'Please enter phone no'
                  : null,
          onChanged: (value) =>
              context.read<LoginBloc>().add(PhoneNoChange(phoneNo: value)),
          decoration: InputDecoration(
            hintStyle: TextStyle(color: kDarkParticlesColor),
            border: OutlineInputBorder(
              borderRadius: AppRadius.radiusAllS,
            ),
            prefixIcon: Icon(Icons.phone),
          ),
        );
      },
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.apiStatus != current.apiStatus,
      builder: (context, state) {
        return CoreButton(
            isLoading: state.apiStatus == ApiStatus.loading,
            text: 'Send OTP',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<LoginBloc>().add(LoginSubmit());
              }
            });
      },
    );
  }
}
