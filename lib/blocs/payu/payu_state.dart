part of 'payu_bloc.dart';

abstract class PayuState extends Equatable {
  const PayuState();

  @override
  List<Object> get props => [];
}

class PayuInitial extends PayuState {}

class PayuLoading extends PayuState {}

class PayuSuccess extends PayuState {
  final dynamic response;

  const PayuSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class PayuFailure extends PayuState {
  final dynamic error;

  const PayuFailure({required this.error});

  @override
  List<Object> get props => [error];
}
