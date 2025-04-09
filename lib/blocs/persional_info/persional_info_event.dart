part of 'persional_info_bloc.dart';

abstract class PersionalInfoEvent extends Equatable{
  const PersionalInfoEvent();

  @override
  List<Object> get props => [];
}

class GetPersionalInfo extends PersionalInfoEvent{}

class PersionalInfoSubmit extends PersionalInfoEvent{
  final PersionalInfoModel persionalInfoModel;

  const PersionalInfoSubmit(this.persionalInfoModel);

  @override
  List<Object> get props => [persionalInfoModel];
}