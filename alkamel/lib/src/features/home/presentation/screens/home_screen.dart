import 'package:alkamel/src/core/extensions/extension.dart';
import 'package:alkamel/src/features/home/presentation/components/hadith_card.dart';
import 'package:alkamel/src/features/home/presentation/controller/cubit/home_cubit.dart';
import 'package:alkamel/src/features/search/presentation/components/search_field.dart';
import 'package:alkamel/src/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is! HomeLoadedState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  context.push(const SettingsScreen());
                },
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints:
                      const BoxConstraints(maxWidth: 750, maxHeight: 300),
                  child: Image.asset(
                    "assets/images/app_icon.png",
                  ),
                ),
                const SizedBox(height: 20),
                const SearchField(),
                const SizedBox(height: 20),
                if (state.authenticHadith != null)
                  HadithCard(
                    backgroundColor: Colors.green.withOpacity(.3),
                    hadith: state.authenticHadith!,
                  ),
                if (state.weakHadith != null)
                  HadithCard(
                    backgroundColor: Colors.orange.withOpacity(.3),
                    hadith: state.weakHadith!,
                  ),
                if (state.fabricatedHadith != null)
                  HadithCard(
                    backgroundColor: Colors.red.withOpacity(.3),
                    hadith: state.fabricatedHadith!,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
