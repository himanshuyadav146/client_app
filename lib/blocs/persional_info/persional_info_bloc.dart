import 'package:bloc/bloc.dart';
import 'package:client_app/data/models/persional_info/persional_info_model.dart';
import 'package:equatable/equatable.dart';
import '../../core/di/di_container.dart';
import '../../data/models/auth_models/otp_verification_response.dart';
import '../../domain/repositories/persional_info/persional_info_repository.dart';
import '../income_source/income_source_bloc.dart';

part 'persional_info_event.dart';
part 'persional_info_state.dart';

class PersionalInfoBloc extends Bloc<PersionalInfoEvent, PersionalInfoState> {
  final PersionalInfoRepository persionalInfoRepository;

  PersionalInfoBloc({required this.persionalInfoRepository})
      : super(PersionalInfoFormInitial()) {
    on<GetPersionalInfo>(_onGetPersionalInfo);
    on<PersionalInfoSubmit>(_onSubmitPersionalInfo);
  }

  void _onGetPersionalInfo(
      GetPersionalInfo event, Emitter<PersionalInfoState> emit) {
    // Use persionalInfoModel if needed
  }

  Future<void> _onSubmitPersionalInfo(
      PersionalInfoSubmit event, Emitter<PersionalInfoState> emit) async {
    emit(PersionalInfoLoading());

    try {
      final response = await persionalInfoRepository.submitPersionalInfo(
        event.persionalInfoModel,
      );

      if (response.status == 'success') {
        emit(PersionalInfoSubmissionSuccess());
      } else {
        emit(PersionalInfoSubmissionFailure(response.message ?? 'Submission failed'));
      }
    } catch (e) {
      emit(PersionalInfoSubmissionFailure(e.toString()));
    }
  }

  void getSelectedIncomeSource() {
    final selected = getIt<IncomeSourceBloc>().state is IncomeSourceLoadedState
        ? (getIt<IncomeSourceBloc>().state as IncomeSourceLoadedState)
        .selectedCategories
        : <Data>{};

    print("Selected Income Source: $selected");
  }
}