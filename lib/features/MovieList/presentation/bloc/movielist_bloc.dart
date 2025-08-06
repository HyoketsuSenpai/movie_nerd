import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movielist_event.dart';
part 'movielist_state.dart';

class MovielistBloc extends Bloc<MovielistEvent, MovielistState> {
  MovielistBloc() : super(MovielistInitial()) {
    on<MovielistEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
