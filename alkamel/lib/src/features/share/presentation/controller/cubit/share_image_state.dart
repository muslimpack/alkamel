// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'share_image_cubit.dart';

sealed class ShareImageState extends Equatable {
  const ShareImageState();

  @override
  List<Object> get props => [];
}

final class ShareImageLoadingState extends ShareImageState {}

class ShareImageLoadedState extends ShareImageState {
  final Hadith hadith;
  final bool showLoadingIndicator;
  final HadithImageCardSettings settings;

  const ShareImageLoadedState({
    required this.hadith,
    required this.showLoadingIndicator,
    required this.settings,
  });

  @override
  List<Object> get props => [
        showLoadingIndicator,
        hadith,
        settings,
      ];

  ShareImageLoadedState copyWith({
    Hadith? hadith,
    bool? showLoadingIndicator,
    HadithImageCardSettings? settings,
  }) {
    return ShareImageLoadedState(
      hadith: hadith ?? this.hadith,
      showLoadingIndicator: showLoadingIndicator ?? this.showLoadingIndicator,
      settings: settings ?? this.settings,
    );
  }
}
