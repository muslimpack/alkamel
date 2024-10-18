import 'package:alkamel/generated/l10n.dart';
import 'package:alkamel/src/core/shared/custom_field_decoration.dart';
import 'package:alkamel/src/features/home/presentation/controller/cubit/home_cubit.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: context.read<HomeCubit>().searchController,
            decoration: customInputDecoration.copyWith(
              prefixIcon: IconButton(
                tooltip: S.of(context).clear,
                onPressed: () {
                  context.read<HomeCubit>().searchController.clear();
                  context.read<HomeCubit>().search("");
                },
                icon: Icon(MdiIcons.eraser),
              ),
            ),
            onChanged: (value) {
              EasyDebounce.debounce(
                'search',
                const Duration(milliseconds: 500),
                () {
                  context.read<HomeCubit>().search(value);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
