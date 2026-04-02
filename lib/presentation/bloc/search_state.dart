part of 'search_bloc.dart';

class SearchState {
  final List<Sanskrit> filteredList;
  final String query;

  const SearchState({required this.filteredList, required this.query});

  SearchState copyWith({List<Sanskrit>? filteredList, String? query}) {
    return SearchState(
      filteredList: filteredList ?? this.filteredList,
      query: query ?? this.query,
    );
  }
}
