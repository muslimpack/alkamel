import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:alkamel/src/core/extensions/extension_platform.dart';
import 'package:alkamel/src/core/functions/print.dart';
import 'package:alkamel/src/features/search/data/models/hadith.dart';
import 'package:alkamel/src/features/share/data/models/hadith_image_card_settings.dart';
import 'package:bloc/bloc.dart';
import 'package:capture_widget/core/widget_capture_controller.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

part 'share_image_state.dart';

class ShareImageCubit extends Cubit<ShareImageState> {
  final CaptureWidgetController captureWidgetController =
      CaptureWidgetController();

  final PageController pageController = PageController();

  ShareImageCubit() : super(ShareImageLoadingState());

  Future onPageChanged(int index) async {
    final state = this.state;
    if (state is! ShareImageLoadedState) return;

    emit(state.copyWith(activeIndex: index));
  }

  FutureOr start(Hadith hadith) async {
    final settings = const HadithImageCardSettings.defaultSettings().copyWith(
      charLengthPerSize: 840,
    );

    final List<TextRange> splittedMatnRanges = splitStringIntoChunksRange(
      hadith.hadith,
      settings.charLengthPerSize,
    );

    appPrint(splittedMatnRanges);

    emit(
      ShareImageLoadedState(
        hadith: hadith,
        showLoadingIndicator: false,
        settings: settings,
        splittedMatn: splittedMatnRanges,
        activeIndex: 0,
      ),
    );
  }

  ///MARK: Split

  List<TextRange> splitStringIntoChunksRange(String text, int charsPerChunk) {
    // Split the text into individual words
    final List<String> words = text.split(' ');
    final List<TextRange> chunkIndices = [];

    int chunkStart = 0;
    int chunkCharCount = 0;
    int start = 0;
    String currentChunk = '';

    for (final String word in words) {
      // Get the word's position in the original text
      final int wordStart = text.indexOf(word, start);
      final int wordEnd = wordStart + word.length;

      // Check if adding the word will exceed charsPerChunk
      if (chunkCharCount + word.length + 1 <= charsPerChunk) {
        // Add the word to the current chunk
        currentChunk += (currentChunk.isEmpty ? word : ' $word');
        chunkCharCount = currentChunk.length;
        start = wordEnd;
      } else {
        // If current chunk size is valid, add it to the list of ranges
        if (chunkCharCount >= charsPerChunk / 3) {
          chunkIndices.add(TextRange(start: chunkStart, end: wordStart));

          // Start a new chunk with the current word
          currentChunk = word;
          chunkCharCount = word.length;
          chunkStart = wordStart;
        } else {
          // Merge small chunk into the previous one
          if (chunkIndices.isNotEmpty) {
            chunkIndices.last =
                TextRange(start: chunkIndices.last.start, end: wordEnd);
          } else {
            chunkIndices.add(TextRange(start: chunkStart, end: wordEnd));
          }
          currentChunk = word;
          chunkStart = wordStart;
        }

        start = wordEnd;
      }
    }

    // Add the last chunk if it's non-empty
    if (currentChunk.isNotEmpty) {
      chunkIndices.add(TextRange(start: chunkStart, end: text.length));
    }

    return chunkIndices;
  }

  /// MARK: Save Image

  Future<void> shareImage() async {
    final state = this.state;
    if (state is! ShareImageLoadedState) return;

    emit(state.copyWith(showLoadingIndicator: true));

    try {
      const double pixelRatio = 2;
      final image = await captureWidgetController.getImage(pixelRatio);
      final byteData = await image?.toByteData(format: ImageByteFormat.png);

      if (PlatformExtension.isDesktop) {
        await _saveDesktop(byteData);
      } else {
        await _savePhone(byteData);
      }
    } catch (e) {
      appPrint(e.toString());
    }

    emit(state.copyWith(showLoadingIndicator: false));
  }

  Future _saveDesktop(ByteData? byteData) async {
    if (byteData == null) return;

    final Uint8List uint8List = byteData.buffer.asUint8List();

    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'SharedImage-$timestamp.png',
    );

    if (outputFile == null) return;

    if (!outputFile.endsWith(".png")) {
      outputFile += ".png";
    }

    appPrint(outputFile);

    final File file = File(outputFile);
    await file.writeAsBytes(uint8List);
  }

  Future _savePhone(ByteData? byteData) async {
    if (byteData == null) return;

    final tempDir = await getTemporaryDirectory();

    final File file = await File('${tempDir.path}/SharedImage.png').create();
    await file.writeAsBytes(byteData.buffer.asUint8List());

    await Share.shareXFiles([XFile(file.path)]);

    await file.delete();
  }

  /// **************************

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
