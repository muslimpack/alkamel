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
  TransformationController transformationController =
      TransformationController();

  final CaptureWidgetController captureWidgetController =
      CaptureWidgetController();
  ShareImageCubit() : super(ShareImageLoadingState());

  FutureOr start(Hadith hadith) async {
    const settings = HadithImageCardSettings.defaultSettings();
    emit(
      ShareImageLoadedState(
        hadith: hadith,
        showLoadingIndicator: false,
        settings: settings,
      ),
    );
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
    transformationController.dispose();
    return super.close();
  }
}
