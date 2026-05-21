part of '../../app_extension.dart';

class KHaptic {
  KHaptic._();

  void hapticLight() {
    HapticFeedback.lightImpact();
  }

  void hapticMedium() {
    HapticFeedback.mediumImpact();
  }

  void hapticHeavy() {
    HapticFeedback.heavyImpact();
  }

  void hapticVibrate() {
    HapticFeedback.vibrate();
  }

  void selectionClick() {
    HapticFeedback.selectionClick();
  }
}
