part of 'persional_info_bloc.dart';

abstract class PersionalInfoState extends Equatable {
  const PersionalInfoState();

  @override
  List<Object> get props => [];
}

class PersionalInfoFormInitial extends PersionalInfoState {}

class PersionalInfoLoading extends PersionalInfoState {}

class PersionalInfoSubmissionSuccess extends PersionalInfoState {}

class PersionalInfoSubmissionFailure extends PersionalInfoState {
  final String error;

  const PersionalInfoSubmissionFailure(this.error);

  @override
  List<Object> get props => [error];
}