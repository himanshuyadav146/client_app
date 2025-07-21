import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:client_app/core/utils/enums.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/repositories/auth/auth_repository.dart';
import '../../../services/session_manager/session_manager.dart';
import '../../../data/models/auth_models/email_auth_response.dart';

part 'email_auth_event.dart';
part 'email_auth_state.dart';

class EmailAuthBloc extends Bloc<EmailAuthEvent, EmailAuthState> {
  AuthRepository authRepository;

  EmailAuthBloc({required this.authRepository}) : super(const EmailAuthState()) {
    on<EmailChange>(_onEmailChanged);
    on<PasswordChange>(_onPasswordChange);
    on<NameChange>(_onNameChanged);
    on<EmailLoginSubmit>(_onEmailLoginSubmit);
    on<EmailSignupSubmit>(_onEmailSignupSubmit);
    on<ForgotPasswordSubmit>(_onForgotPasswordSubmit);
  }

  void _onEmailChanged(EmailChange event, Emitter<EmailAuthState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChange(PasswordChange event, Emitter<EmailAuthState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onNameChanged(NameChange event, Emitter<EmailAuthState> emit) {
    emit(state.copyWith(name: event.name));
  }

  Future<void> _onEmailLoginSubmit(
      EmailLoginSubmit event, Emitter<EmailAuthState> emit) async {
    final Map<String, dynamic> data = {
      "email": state.email,
      "password": state.password,
    };
    
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    
          try {
        final response = await authRepository.emailLogin(data);
        if (response.status == 'success') {
          // Save user session with email auth response
          await _saveEmailUserSession(response);
          emit(state.copyWith(
              statusMessage: response.message ?? 'Login successful', 
              apiStatus: ApiStatus.success));
        } else {
          emit(state.copyWith(
              statusMessage: response.message ?? 'Login failed', 
              apiStatus: ApiStatus.error));
        }
      } catch (error) {
        emit(state.copyWith(
            statusMessage: 'Something went wrong', 
            apiStatus: ApiStatus.error));
      }
  }

  // Helper method to save email user session
  Future<void> _saveEmailUserSession(EmailAuthResponse response) async {
    final sessionController = SessionController();
    await sessionController.saveEmailUserSession(response);
  }

  Future<void> _onEmailSignupSubmit(
      EmailSignupSubmit event, Emitter<EmailAuthState> emit) async {
    final Map<String, dynamic> data = {
      "name": state.name,
      "email": state.email,
      "password": state.password,
    };
    
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    
    try {
      final response = await authRepository.emailSignup(data);
      if (response.status == 'success') {
        emit(state.copyWith(
            statusMessage: response.message ?? 'Signup successful', 
            apiStatus: ApiStatus.success));
      } else {
        emit(state.copyWith(
            statusMessage: response.message ?? 'Signup failed', 
            apiStatus: ApiStatus.error));
      }
    } catch (error) {
      emit(state.copyWith(
          statusMessage: 'Something went wrong', 
          apiStatus: ApiStatus.error));
    }
  }

  Future<void> _onForgotPasswordSubmit(
      ForgotPasswordSubmit event, Emitter<EmailAuthState> emit) async {
    final Map<String, dynamic> data = {
      "email": state.email,
    };
    
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    
    try {
      final response = await authRepository.forgotPassword(data);
      if (response.status == 'success') {
        emit(state.copyWith(
            statusMessage: response.message ?? 'Password reset email sent', 
            apiStatus: ApiStatus.success));
      } else {
        emit(state.copyWith(
            statusMessage: response.message ?? 'Failed to send reset email', 
            apiStatus: ApiStatus.error));
      }
    } catch (error) {
      emit(state.copyWith(
          statusMessage: 'Something went wrong', 
          apiStatus: ApiStatus.error));
    }
  }
} 