import 'package:client_app/core/index.dart';
import 'package:client_app/views/blocs/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/enums.dart';

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
    _loginBloc = LoginBloc();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CoreScaffold(
      title: 'Login',
      body: BlocProvider<LoginBloc>.value(
        value: _loginBloc,
        child: BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) => previous.apiStatus != current.apiStatus,
          listener: (context, state) {
            if (state.apiStatus == ApiStatus.error || state.apiStatus == ApiStatus.success) {
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
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildEmailField(),
            const SizedBox(height: 20),
            _buildPasswordField(),
            const SizedBox(height: 20),
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Email',
            border: OutlineInputBorder(),
          ),
          validator: (value) => value == null || value.isEmpty ? 'Please enter email' : null,
          onChanged: (value) => context.read<LoginBloc>().add(EmailChange(email: value)),
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          controller: _passwordController,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Password',
            border: OutlineInputBorder(),
          ),
          validator: (value) => value == null || value.isEmpty ? 'Please enter password' : null,
          onChanged: (value) => context.read<LoginBloc>().add(PasswordChange(password: value)),
        );
      },
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.apiStatus != current.apiStatus,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.apiStatus == ApiStatus.loading
              ? null
              : () {
            if (_formKey.currentState!.validate()) {
              context.read<LoginBloc>().add(LoginSubmit());
            }
          },
          child: const Text('Login'),
        );
      },
    );
  }
}