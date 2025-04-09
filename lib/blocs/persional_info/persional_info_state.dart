
part of 'persional_info_bloc.dart';


class PersionalInfoState extends Equatable {
  const PersionalInfoState();

  @override
  List<Object> get props => [];

}

class PersionalInfoFormInitial extends PersionalInfoState {}

class PersionalInfoFormLoading extends PersionalInfoState {}

class PersionalInfoFormLoaded extends PersionalInfoState {
  final PersionalInfoModel persionalInfoModel;

  const PersionalInfoFormLoaded(this.persionalInfoModel);

  @override
  List<Object> get props => [persionalInfoModel];
}

class PersionalInfoFormError extends PersionalInfoState {
  final String message;

  const PersionalInfoFormError(this.message);

  @override
  List<Object> get props => [message];
}

class PersionalInfoFormSuccess extends PersionalInfoState {
  final PersionalInfoModel persionalInfoModel;

  const PersionalInfoFormSuccess(this.persionalInfoModel);

  @override
  List<Object> get props => [persionalInfoModel];
}


