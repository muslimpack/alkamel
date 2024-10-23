// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alkamel/generated/l10n.dart';
import 'package:alkamel/src/core/di/dependency_injection.dart';
import 'package:alkamel/src/features/search/data/models/hadith.dart';
import 'package:alkamel/src/features/share/presentation/components/dot_bar.dart';
import 'package:alkamel/src/features/share/presentation/components/hadith_as_image_card.dart';
import 'package:alkamel/src/features/share/presentation/controller/cubit/share_image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShareAsImageScreen extends StatelessWidget {
  final Hadith hadith;
  const ShareAsImageScreen({
    super.key,
    required this.hadith,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ShareImageCubit>()..start(hadith),
      child: BlocBuilder<ShareImageCubit, ShareImageState>(
        builder: (context, state) {
          if (state is! ShareImageLoadedState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).shareAsImage),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () async {
                    await context.read<ShareImageCubit>().shareImage();
                  },
                  icon: const Icon(Icons.share),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(10),
                child: state.showLoadingIndicator
                    ? const LinearProgressIndicator()
                    : const SizedBox.shrink(),
              ),
            ),
            body: PageView.builder(
              controller: context.read<ShareImageCubit>().pageController,
              itemCount: state.splittedMatn.length,
              onPageChanged: context.read<ShareImageCubit>().onPageChanged,
              itemBuilder: (context, index) {
                return Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    FittedBox(
                      child: RepaintBoundary(
                        key: context.read<ShareImageCubit>().imageKeys[index],
                        child: HadithAsImageCard(
                          hadith: hadith,
                          settings: state.settings,
                          matnRange: state.splittedMatn[index],
                          splittedLength: state.splittedMatn.length,
                          splittedindex: index,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            bottomNavigationBar: BottomAppBar(
              height: kToolbarHeight,
              child: DotBar(
                length: state.splittedMatn.length,
                activeIndex: state.activeIndex,
              ),
            ),
          );
        },
      ),
    );
  }
}
