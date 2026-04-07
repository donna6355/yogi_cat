import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_bloc.dart';
import '../components/sanskrit_card.dart';
import '../components/search_bar.dart';
import '../../data/pose_model.dart';
import '../../data/sanskrit_model.dart';

class SanskritScreen extends StatelessWidget {
  final List<Pose> asanaList;
  final List<Sanskrit> sanskritList;
  const SanskritScreen({
    required this.asanaList,
    required this.sanskritList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) =>
          SearchBloc(asanaList: asanaList, sanskritList: sanskritList),
      child: SearchPage(),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: SanskritSearchBar(),
        ),
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.filteredList.isEmpty) {
                return Center(
                  child: Text(
                    'noResults'.tr(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                );
              }
              return ListView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 100),
                itemCount: state.filteredList.length,
                itemBuilder: (context, index) {
                  final sanskrit = state.filteredList[index];
                  final linkedAsanas = context
                      .read<SearchBloc>()
                      .getLinkedAsanas(sanskrit);
                  return SanskritCard(
                    sanskrit: sanskrit,
                    linkedAsanas: linkedAsanas,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
