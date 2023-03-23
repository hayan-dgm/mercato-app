import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mercato_app/core/error/failures.dart';
import 'package:mercato_app/core/strings/failures.dart';
import 'package:mercato_app/core/strings/messages.dart';
import 'package:mercato_app/features/drugs/domain/entities/drug.dart';
import 'package:mercato_app/features/drugs/domain/usecases/update_drug.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/image.dart';

part 'change_drugs_event.dart';
part 'change_drugs_state.dart';

class ChangeDrugsBloc extends Bloc<ChangeDrugsEvent, ChangeDrugsState> {

  final UpdateDrugUseCase updateDrug;

  ChangeDrugsBloc({required this.updateDrug}) : super(ChangeDrugsInitial()) {
    on<ChangeDrugsEvent>((event, emit) async{
      
      if(event is UpdateDrugEvent){
        emit(LoadingChangeDrugsState());
        final failureOrDoneMessage = await updateDrug(event.image);

        failureOrDoneMessage.fold(
          (failure) => emit(ErrorChangeDrugsState(message: _mapFailureToMessage(failure))), 
          (r) => emit(MessageChangeDrugsState(message: UPDATE_SUCCESS_MESSAGE)));

      }
    });
  }


    String _mapFailureToMessage (Failure failure){
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later.";
    }
  }
}
