import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_bloc.dart';
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
        _SearchBar(),
        Expanded(child: _SanskritList()),
      ],
    );
  }
}

// ── Search Bar ────────────────────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: BlocBuilder<SearchBloc, SearchState>(
        buildWhen: (prev, curr) => prev.query != curr.query,
        builder: (context, state) {
          return TextField(
            controller: context.read<SearchBloc>().controller,
            onChanged: (value) =>
                context.read<SearchBloc>().add(SanskritSearchChanged(value)),
            decoration: InputDecoration(
              hintText: 'search'.tr(),
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Sanskrit List ─────────────────────────────────────────────────────────────

class _SanskritList extends StatelessWidget {
  const _SanskritList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.filteredList.isEmpty) {
          return Center(
            child: Text(
              'noResults'.tr(),
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          itemCount: state.filteredList.length,
          itemBuilder: (context, index) {
            final sanskrit = state.filteredList[index];
            final linkedAsanas = context.read<SearchBloc>().getLinkedAsanas(
              sanskrit,
            );

            return _SanskritCard(
              sanskrit: sanskrit,
              linkedAsanas: linkedAsanas,
            );
          },
        );
      },
    );
  }
}

// ── Sanskrit Card (ExpansionTile) ─────────────────────────────────────────────

class _SanskritCard extends StatelessWidget {
  final Sanskrit sanskrit;
  final List<Pose> linkedAsanas;

  const _SanskritCard({required this.sanskrit, required this.linkedAsanas});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(
          sanskrit.sanskrit,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          sanskrit.meaning,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 13,
          ),
        ),
        children: [
          ...linkedAsanas.map((pose) => Text(pose.name)),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
