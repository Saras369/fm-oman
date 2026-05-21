import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @myHomePage.
  ///
  /// In en, this message translates to:
  /// **'My Home Page'**
  String get myHomePage;

  /// No description provided for @myHome.
  ///
  /// In en, this message translates to:
  /// **'My Home'**
  String get myHome;

  /// No description provided for @updateAttendanceRecord.
  ///
  /// In en, this message translates to:
  /// **'Update Attendance Record'**
  String get updateAttendanceRecord;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @fromDate.
  ///
  /// In en, this message translates to:
  /// **'From Date'**
  String get fromDate;

  /// No description provided for @toDate.
  ///
  /// In en, this message translates to:
  /// **'To Date'**
  String get toDate;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @fromTime.
  ///
  /// In en, this message translates to:
  /// **'From time'**
  String get fromTime;

  /// No description provided for @toTime.
  ///
  /// In en, this message translates to:
  /// **'To Time'**
  String get toTime;

  /// No description provided for @failedToLoadOptions.
  ///
  /// In en, this message translates to:
  /// **'Failed to load options'**
  String get failedToLoadOptions;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @submittedValues.
  ///
  /// In en, this message translates to:
  /// **'Submitted Values'**
  String get submittedValues;

  /// No description provided for @legendsView.
  ///
  /// In en, this message translates to:
  /// **'Legends View'**
  String get legendsView;

  /// No description provided for @financialServicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Financial Services'**
  String get financialServicesTitle;

  /// No description provided for @statTotalRequests.
  ///
  /// In en, this message translates to:
  /// **'Total Requests'**
  String get statTotalRequests;

  /// No description provided for @statApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get statApproved;

  /// No description provided for @statPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statPending;

  /// No description provided for @statRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get statRejected;

  /// No description provided for @requestsStatusBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Requests Status Breakdown'**
  String get requestsStatusBreakdown;

  /// No description provided for @requestTrendBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Request Trend Breakdown'**
  String get requestTrendBreakdown;

  /// No description provided for @breakdownSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Breakdown'**
  String get breakdownSectionTitle;

  /// No description provided for @chartLegendTotalTickets.
  ///
  /// In en, this message translates to:
  /// **'Total Tickets'**
  String get chartLegendTotalTickets;

  /// No description provided for @chartCenterTotalRequests.
  ///
  /// In en, this message translates to:
  /// **'Total Requests'**
  String get chartCenterTotalRequests;

  /// No description provided for @statusOpened.
  ///
  /// In en, this message translates to:
  /// **'Opened'**
  String get statusOpened;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get statusClosed;

  /// No description provided for @filterWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get filterWeekly;

  /// No description provided for @filterMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get filterMonthly;

  /// No description provided for @filterQuarterly.
  ///
  /// In en, this message translates to:
  /// **'Quarterly'**
  String get filterQuarterly;

  /// No description provided for @filterYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get filterYearly;

  /// No description provided for @selectOption.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get selectOption;

  /// No description provided for @approvalsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Approvals'**
  String get approvalsSectionTitle;

  /// No description provided for @searchFinancialRequestsHint.
  ///
  /// In en, this message translates to:
  /// **'Search by Request Name or Request ID'**
  String get searchFinancialRequestsHint;

  /// No description provided for @tabMyRequests.
  ///
  /// In en, this message translates to:
  /// **'My Requests'**
  String get tabMyRequests;

  /// No description provided for @tabActionItems.
  ///
  /// In en, this message translates to:
  /// **'Action Items'**
  String get tabActionItems;

  /// No description provided for @labelRequestId.
  ///
  /// In en, this message translates to:
  /// **'Request ID:'**
  String get labelRequestId;

  /// No description provided for @labelRequestName.
  ///
  /// In en, this message translates to:
  /// **'Request Name:'**
  String get labelRequestName;

  /// No description provided for @labelDate.
  ///
  /// In en, this message translates to:
  /// **'Date:'**
  String get labelDate;

  /// No description provided for @labelApprover.
  ///
  /// In en, this message translates to:
  /// **'Approver:'**
  String get labelApprover;

  /// No description provided for @chartMetricTotalTickets.
  ///
  /// In en, this message translates to:
  /// **'Total Tickets'**
  String get chartMetricTotalTickets;

  /// No description provided for @servicesPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get servicesPageTitle;

  /// No description provided for @servicesTabAllServices.
  ///
  /// In en, this message translates to:
  /// **'All Services'**
  String get servicesTabAllServices;

  /// No description provided for @servicesTabBookmarked.
  ///
  /// In en, this message translates to:
  /// **'Bookmarked'**
  String get servicesTabBookmarked;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
