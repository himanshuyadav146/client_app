import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/constant/app_sizes.dart';
import '../../core/constant/colors.dart';
import '../../core/constant/icon_constant.dart';
import '../../core/constant/strings.dart';
import '../../core/route/route_name.dart';
import '../../core/utils/enums.dart';
import '../../core/widgets/core_button.dart';
import '../../core/widgets/core_scafold.dart';
import '../../core/widgets/core_text.dart';
import '../../core/widgets/loader_widget.dart';
import '../../main.dart';
import '../blocs/login_bloc.dart';

class OtpVerificationView extends StatefulWidget {
  const OtpVerificationView({super.key});

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  // late final LoginBloc _loginBloc;
  final _formKey = GlobalKey<FormState>();
  final LoginBloc loginBloc = getIt<LoginBloc>();

  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    //_loginBloc = LoginBloc(authRepository: getIt());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onOtpEntered() {
    String otp = _controllers.map((c) => c.text).join();
    if (otp.length == 6) {
      context.read<LoginBloc>().add(PhoneNoChange(phoneNo: otp));
      GoRouter.of(context).go(RouteName.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CoreScaffold(
      title: 'OTP Verification',
      body: BlocProvider<LoginBloc>.value(
        value: loginBloc,
        child: BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) =>
              previous.apiStatus != current.apiStatus,
          listener: (context, state) {
            if (state.apiStatus == ApiStatus.success) {
              GoRouter.of(context).push(RouteName.home);
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
              return _buildOtpForm();
            },
          ),
        ),
      ),
      isDrawer: false,
      isResizeToAvoidBottomInset: false,
    );
  }

  Widget _buildOtpForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          Center(
            child: SvgPicture.asset(ICON_CONST.verify, width: 330, height: 250),
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
          _buildOTPField(),
          const SizedBox(height: 20),
          _buildVerifyButton(),
        ],
      ),
    );
  }

  Widget _buildOTPField() {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (KeyEvent event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace) {
          for (int i = 1; i < 6; i++) {
            if (_controllers[i].text.isEmpty &&
                _controllers[i - 1].text.isNotEmpty) {
              _focusNodes[i - 1].requestFocus();
              break;
            }
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: SizedBox(
                width: 50,
                height: 50,
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    counterText: "",
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty && index < 5) {
                      _focusNodes[index + 1].requestFocus();
                    }
                    _onOtpEntered();
                  },
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildVerifyButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.apiStatus != current.apiStatus,
      builder: (context, state) {
        return CoreButton(
          isLoading: state.apiStatus == ApiStatus.loading,
          text: 'Verify OTP',
          onPressed: () {
            String otp = _controllers.map((c) => c.text).join();
            if (otp.length == 6) {
              context.read<LoginBloc>().add(OTPChange(otp: otp));
              context.read<LoginBloc>().add(VerifyOTP());
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Enter all 6 digits")),
              );
            }
          },
        );
      },
    );
  }
}
