// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alkamel/generated/l10n.dart';
import 'package:alkamel/src/core/di/dependency_injection.dart';
import 'package:alkamel/src/features/search/data/models/hadith.dart';
import 'package:alkamel/src/features/share/presentation/components/hadith_as_image_card.dart';
import 'package:alkamel/src/features/share/presentation/controller/cubit/share_image_cubit.dart';
import 'package:capture_widget/capture_widget.dart';
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
            ),
            body: GestureDetector(
              onDoubleTap: () {
                context.read<ShareImageCubit>().fitImageToScreen(context);
              },
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  FittedBox(
                    child: CaptureWidget(
                      controller: context
                          .read<ShareImageCubit>()
                          .captureWidgetController,
                      child: HadithAsImageCard(hadith: hadith),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
