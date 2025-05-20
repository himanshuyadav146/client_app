import 'package:bloc/bloc.dart';
import 'package:client_app/data/models/persional_info/persional_info_model.dart';
import 'package:equatable/equatable.dart';
import '../../core/di/di_container.dart';
import '../../domain/repositories/persional_info/persional_info_repository.dart';
import '../income_source/income_source_bloc.dart';
import 'package:client_app/data/models/income_source/sources.dart';


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
    final selectedIncomeSources = getSelectedIncomeSource();

    try {
      final modelWithSources = PersionalInfoModel(
        financialYear: event.persionalInfoModel.financialYear,
        firstName: event.persionalInfoModel.firstName,
        middleName: event.persionalInfoModel.middleName,
        lastName: event.persionalInfoModel.lastName,
        email: event.persionalInfoModel.email,
        dob: event.persionalInfoModel.dob,
        pan: event.persionalInfoModel.pan,
        aadhaar: event.persionalInfoModel.aadhaar,
        source: selectedIncomeSources,
      );

      final response = await persionalInfoRepository.submitPersionalInfo(
        modelWithSources,
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

  List<IncomeSource> getSelectedIncomeSource() {
    try {
      final incomeSourceBloc = getIt<IncomeSourceBloc>();
      if (incomeSourceBloc.state is IncomeSourceLoadedState) {
        return (incomeSourceBloc.state as IncomeSourceLoadedState)
            .selectedCategories;
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}