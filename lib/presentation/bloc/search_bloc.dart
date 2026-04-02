import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/pose_model.dart';
import '../../data/sanskrit_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final List<Pose> asanaList;
  final List<Sanskrit> sanskritList;
  final TextEditingController controller = TextEditingController();
  SearchBloc({required this.asanaList, required this.sanskritList})
    : super(SearchState(filteredList: sanskritList, query: '')) {
    on<SanskritSearchChanged>(_onSearchChanged);
  }

  // ── helpers ──────────────────────────────────────────────

  List<Sanskrit> _filter(String query) {
    if (query.isEmpty) return sanskritList;
    final q = query.toLowerCase();
    return sanskritList
        .where(
          (s) =>
              s.sanskrit.toLowerCase().contains(q) ||
              s.meaning.toLowerCase().contains(q),
        )
        .toList();
  }

  // ── event handlers ────────────────────────────────────────

  void _onSearchChanged(
    SanskritSearchChanged event,
    Emitter<SearchState> emit,
  ) {
    if (event.query.isEmpty) controller.clear();
    emit(
      state.copyWith(query: event.query, filteredList: _filter(event.query)),
    );
  }

  // ── public helper for UI ──────────────────────────────────

  List<Pose> getLinkedAsanas(Sanskrit sanskrit) {
    return asanaList
        .where((pose) => sanskrit.asanaIds.contains(pose.id))
        .toList();
  }
}
