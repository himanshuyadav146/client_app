import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/persional_info/persional_info_model.dart';
import '../../domain/repositories/persional_info/persional_info_repository.dart';

part 'persional_info_event.dart';

part 'persional_info_state.dart';



class PersionalInfoBloc extends Bloc<PersionalInfoEvent, PersionalInfoState>{
  late PersionalInfoRepository persionalInfoRepository;
  final PersionalInfoModel persionalInfoModel;

  PersionalInfoBloc({
    required this.persionalInfoRepository,
    required this.persionalInfoModel,
  }) : super( PersionalInfoFormInitial()){
    on<GetPersionalInfo>(_onGetPersionalInfo);
    on<PersionalInfoSubmit>(_onSubmitPersionalInfo);
  }

  void _onGetPersionalInfo(
      GetPersionalInfo event, Emitter<PersionalInfoState> emit) {
    // Use persionalInfoModel if needed
  }

  void _onSubmitPersionalInfo(
      PersionalInfoSubmit event, Emitter<PersionalInfoState> emit) {
    // Handle submission
  }
}