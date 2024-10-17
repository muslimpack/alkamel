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

  const ShareImageLoadedState({
    required this.hadith,
    required this.showLoadingIndicator,
  });

  @override
  List<Object> get props => [
        showLoadingIndicator,
        hadith,
      ];

  ShareImageLoadedState copyWith({
    Hadith? hadith,
    bool? showLoadingIndicator,
  }) {
    return ShareImageLoadedState(
      hadith: hadith ?? this.hadith,
      showLoadingIndicator: showLoadingIndicator ?? this.showLoadingIndicator,
    );
  }
}
