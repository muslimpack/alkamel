// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alkamel/generated/l10n.dart';
import 'package:alkamel/src/features/home/data/models/hadith_ruling_enum.dart';
import 'package:alkamel/src/features/search/presentation/controller/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SearchFiltersButton extends StatelessWidget {
  const SearchFiltersButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () async {
            if (state is SearchLoadedState) {
              final result = await showSearchFilterDialog(
                context,
                activeRuling: state.activeRuling,
              );
              if (result == null) return;
              if (!context.mounted) return;

              context.read<SearchCubit>().changeActiveRuling(result);
            }
          },
          icon: Icon(MdiIcons.filter),
        );
      },
    );
  }
}

class SearchFiltersBar extends StatelessWidget {
  const SearchFiltersBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is! SearchLoadedState) return const SizedBox.shrink();
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: HadithRulingEnum.values.map((e) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: ToggleButton(
                  label: Text(
                    "${e.title} (${state.dbHadith.where((h) => h.rulingEnum == e).length})",
                  ),
                  showCheckmark: false,
                  selected: state.activeRuling.contains(e),
                  onSelected: (value) async {
                    context.read<SearchCubit>().toggleRulingStatus(e, value);
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

Future<List<HadithRulingEnum>?> showSearchFilterDialog(
  BuildContext context, {
  required List<HadithRulingEnum> activeRuling,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return SearchFiltersDialog(activeRuling: activeRuling);
    },
  );
}

class SearchFiltersDialog extends StatefulWidget {
  final List<HadithRulingEnum> activeRuling;
  const SearchFiltersDialog({
    super.key,
    required this.activeRuling,
  });

  @override
  State<SearchFiltersDialog> createState() => _SearchFiltersDialogState();
}

class _SearchFiltersDialogState extends State<SearchFiltersDialog> {
  late final List<HadithRulingEnum> activeRuling;

  @override
  void initState() {
    activeRuling = List.of(widget.activeRuling);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).searchFilters),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: HadithRulingEnum.values.map((e) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: ToggleButton(
              label: Text(e.title),
              selected: activeRuling.contains(e),
              onSelected: (value) {
                setState(() {
                  if (value) {
                    activeRuling.add(e);
                  } else {
                    activeRuling.remove(e);
                  }
                });
              },
            ),
          );
        }).toList(),
      ),
      actions: [
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop(activeRuling);
          },
          child: Text(S.of(context).apply),
        ),
      ],
    );
  }
}
