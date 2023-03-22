import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mercato_app/core/error/failures.dart';
import 'package:mercato_app/core/strings/failures.dart';
import 'package:mercato_app/features/drugs/domain/entities/drug.dart';
import 'package:mercato_app/features/drugs/domain/usecases/get_all_drugs.dart';

part 'drugs_event.dart';
part 'drugs_state.dart';

class DrugsBloc extends Bloc<DrugsEvent, DrugsState> {

  final GetAllDrugsUseCase getAllDrugs;

  DrugsBloc({required this.getAllDrugs}) : super(DrugsInitial()) {
    on<DrugsEvent>((event, emit) async{
      if(event is GetAllDrugsEvent){
        emit(LoadingDrugsState());
        final failuresOrDrugs = await getAllDrugs(event.query);

        emit(_mapFailureOrDrugsToState(failuresOrDrugs));
      }else if (event is RefreshDrugsEvent){
        print("REFRESH${event.query}");

        emit(LoadingDrugsState());

        final failuresOrDrugs = await getAllDrugs(event.query);
        emit(_mapFailureOrDrugsToState(failuresOrDrugs));
      }else{
        print("ELLLLLLSSSEEEEE");

      }
    });
  }

  DrugsState _mapFailureOrDrugsToState(Either<Failure,List<Drug>>either ){
    return either.fold(
      (failure) => ErrorDrugsState(message: _mapFailureToMessage(failure)),
      
      (drugs) => LoadedDrugsState(drugs: drugs));
  }

  String _mapFailureToMessage (Failure failure){
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later.";
    }
  }
}
