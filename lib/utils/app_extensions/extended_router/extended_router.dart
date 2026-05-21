part of '../app_extension.dart';

class KExtendedRouter {
  KExtendedRouter._();

  _BottomSheetRoute bottomSheet = _BottomSheetRoute._();

  _DialogRoute dialog = _DialogRoute._();

  Future<DateTime?>? showKDatePicker({
    BuildContext? context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    DateTime? currentDate,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    SelectableDayPredicate? selectableDayPredicate,
    String? helpText,
    String? cancelText,
    String? confirmText,
    Locale? locale,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    TextDirection? textDirection,
    TransitionBuilder? builder,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    String? errorFormatText,
    String? errorInvalidText,
    String? fieldHintText,
    String? fieldLabelText,
  }) {
    return showDatePicker(
      context: context ?? KAppX.currentContext!,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      currentDate: currentDate,
      initialEntryMode: initialEntryMode,
      selectableDayPredicate: selectableDayPredicate,
      helpText: helpText,
      cancelText: cancelText,
      confirmText: confirmText,

      locale: locale,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      textDirection: textDirection,
      builder: (context, child) {
        return Consumer(
          builder: (context, ref, _) {
            final currentTheme = ref.watch(KAppX.theme.current).themeBox;

            return Theme(
              data: ThemeData(
                dialogTheme: Theme.of(context).dialogTheme.copyWith(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(28.toAutoScaledHeight),
                    ),
                  ),
                ),
                colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: currentTheme.colors.primary,
                  onPrimary: currentTheme.colors.onPrimary,
                  surface: currentTheme.colors.onPrimary,
                  onSurface: currentTheme.colors.onBackground,
                ),
                dividerTheme: DividerTheme.of(context).copyWith(
                  color: currentTheme.colors.primary.shade90,
                  thickness: 1.toAutoScaledHeight,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor:
                        currentTheme.colors.primary, // button text color
                    textStyle: TextStyle(
                      fontSize: currentTheme.fontSizes.s14,
                      fontWeight: currentTheme.fontWeights.wBolder,
                    ),
                  ),
                ),

                iconTheme: Theme.of(context).iconTheme.copyWith(
                  color: currentTheme.colors.onBackgroundVariant,
                ),

                // iconTheme: const IconThemeData(opacity: 0),
              ),
              child: child!,
            );
          },
        );
      },
      initialDatePickerMode: initialDatePickerMode,
      errorFormatText: errorFormatText,
      errorInvalidText: errorInvalidText,
      fieldHintText: fieldHintText,
      fieldLabelText: fieldLabelText,
    );
  }

  Future<TimeOfDay?>? showKTimePicker({
    BuildContext? context,
    required TimeOfDay initialTime,
    TransitionBuilder? builder,
    bool useRootNavigator = true,
    TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dial,
    String? cancelText,
    String? confirmText,
    String? helpText,
    RouteSettings? routeSettings,
  }) {
    return showTimePicker(
      context: context ?? KAppX.currentContext!,
      initialTime: initialTime,
      useRootNavigator: useRootNavigator,
      initialEntryMode: initialEntryMode,
      cancelText: cancelText,
      confirmText: confirmText,
      helpText: helpText,
      routeSettings: routeSettings,
      builder: (context, child) {
        return Consumer(
          builder: (context, ref, _) {
            final currentTheme = ref.watch(KAppX.theme.current).themeBox;

            return Theme(
              data: ThemeData(
                timePickerTheme: TimePickerThemeData(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(28.toAutoScaledHeight),
                    ),
                  ),
                  backgroundColor: currentTheme.colors.background,
                  hourMinuteShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.toAutoScaledHeight),
                    ),
                  ),
                  hourMinuteColor: WidgetStateColor.resolveWith(
                    (states) => states.contains(WidgetState.selected)
                        ? currentTheme.colors.primary
                        : currentTheme.colors.background,
                  ),
                  hourMinuteTextColor: WidgetStateColor.resolveWith(
                    (states) => states.contains(WidgetState.selected)
                        ? currentTheme.colors.onPrimary
                        : currentTheme.colors.onBackground,
                  ),
                  dayPeriodShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.toAutoScaledHeight),
                    ),
                    side: BorderSide(
                      color: currentTheme.colors.onBackgroundVariant,
                      width: 1.toAutoScaledHeight,
                    ),
                  ),
                  dayPeriodColor: WidgetStateColor.resolveWith(
                    (states) => states.contains(WidgetState.selected)
                        ? currentTheme.colors.primary
                        : currentTheme.colors.background,
                  ),
                  dayPeriodTextColor: WidgetStateColor.resolveWith(
                    (states) => states.contains(WidgetState.selected)
                        ? currentTheme.colors.onPrimary
                        : currentTheme.colors.onBackgroundVariant,
                  ),
                  hourMinuteTextStyle: TextStyle(
                    fontSize: currentTheme.fontSizes.s48,
                    fontWeight: currentTheme.fontWeights.wBolder,
                  ),
                  dayPeriodTextStyle: TextStyle(
                    fontSize: currentTheme.fontSizes.s16,
                    fontWeight: currentTheme.fontWeights.wBolder,
                  ),
                  dialHandColor: currentTheme.colors.primary,
                  dialBackgroundColor: currentTheme.colors.background,
                  dialTextColor: WidgetStateColor.resolveWith(
                    (states) => states.contains(WidgetState.selected)
                        ? currentTheme.colors.onPrimary
                        : currentTheme.colors.onBackgroundVariant,
                  ),
                  entryModeIconColor: currentTheme.colors.onBackgroundVariant,
                ),
                textTheme: TextTheme(
                  labelSmall: TextStyle(
                    color: currentTheme.colors.onBackgroundVariant,
                  ),
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor:
                        currentTheme.colors.primary, // button text color
                    textStyle: TextStyle(
                      fontSize: currentTheme.fontSizes.s14,
                      fontWeight: currentTheme.fontWeights.wBolder,
                    ),
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}
