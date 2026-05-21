part of '../../app_extension.dart';

final kThemeBox = KThemeBox.instance;

final _themeProvider =
    StateNotifierProvider.autoDispose<KThemeStateNotifier, KThemeState>((ref) {
      final controller = KThemeStateNotifier();

      return controller;
    });

class KThemeState {
  final KThemeType type;
  final KThemeBox themeBox;

  KThemeState({required this.type, required this.themeBox});

  KThemeState.defaults() : this(type: kThemeBox.type, themeBox: kThemeBox);

  KThemeState copyWith({KThemeType? type}) {
    return KThemeState(type: type ?? this.type, themeBox: kThemeBox);
  }
}

class KThemeStateNotifier extends StateNotifier<KThemeState> {
  KThemeStateNotifier() : super(KThemeState.defaults());

  void switchTo(KThemeType type) {
    state = state.copyWith(type: type);

    kThemeBox.switchTo(type);
  }
}
