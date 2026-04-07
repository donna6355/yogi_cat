import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_bloc.dart';

class SanskritSearchBar extends StatelessWidget {
  const SanskritSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
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
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          );
        },
      ),
    );
  }
}
