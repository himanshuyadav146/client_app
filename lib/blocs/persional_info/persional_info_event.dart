part of 'persional_info_bloc.dart';

abstract class PersionalInfoEvent extends Equatable {
  const PersionalInfoEvent();

  @override
  List<Object> get props => [];
}

class GetPersionalInfo extends PersionalInfoEvent {
  const GetPersionalInfo();
}

class PersionalInfoSubmit extends PersionalInfoEvent {
  final PersionalInfoModel persionalInfoModel;

  const PersionalInfoSubmit({required this.persionalInfoModel});

  @override
  List<Object> get props => [persionalInfoModel];
}