part of 'movielist_bloc.dart';

abstract class MovielistState extends Equatable {
  const MovielistState();  

  @override
  List<Object> get props => [];
}
class MovielistInitial extends MovielistState {}
