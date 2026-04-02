part of 'search_bloc.dart';

abstract class SearchEvent {}

class SanskritSearchChanged extends SearchEvent {
  final String query;
  SanskritSearchChanged(this.query);
}
