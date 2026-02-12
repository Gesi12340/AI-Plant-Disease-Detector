// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Plant Doctor';

  @override
  String get loginTitle => 'Welcome Back';

  @override
  String get loginSubtitle => 'Login to your account';

  @override
  String get usernameLabel => 'Username';

  @override
  String get loginButton => 'Login';

  @override
  String get homeTitle => 'Plant Doctor';

  @override
  String get scanPlant => 'Scan Plant';

  @override
  String get scanSubtitle => 'Take a photo to analyze';

  @override
  String get history => 'History';

  @override
  String get historySubtitle => 'View past scans';

  @override
  String get profile => 'Profile';

  @override
  String get profileSubtitle => 'User settings';

  @override
  String get recentScans => 'Recent Scans';

  @override
  String get diagnosisResult => 'Diagnosis Result';

  @override
  String get confidence => 'Confidence';

  @override
  String get severity => 'Severity';

  @override
  String get treatmentRecommendation => 'Treatment Recommendation';

  @override
  String get healthyPlantMessage =>
      'No treatment needed. Keep maintaining good practices!';

  @override
  String get infectedPlantMessage =>
      '1. Remove infected leaves immediately.\n2. Apply copper-based fungicide.\n3. Ensure better air circulation.';

  @override
  String get sync => 'Sync';

  @override
  String get startSync => 'Start Sync';

  @override
  String get syncComplete => 'Sync Complete';

  @override
  String get syncFailed => 'Sync Failed';

  @override
  String get noConnection => 'No Internet Connection';

  @override
  String get diseaseTrends => 'Disease Trends';

  @override
  String get noDataChart => 'No data for chart';

  @override
  String get noHistory => 'No history yet';

  @override
  String get educationTitle => 'Plant Education';

  @override
  String get learnTab => 'Learn';

  @override
  String get quizTab => 'Quiz';

  @override
  String get tapToLearn => 'Tap to learn more';

  @override
  String get symptoms => 'Symptoms:';

  @override
  String get prevention => 'Prevention:';

  @override
  String get quizCompleted => 'Quiz Completed!';

  @override
  String get score => 'Score:';

  @override
  String get restartQuiz => 'Restart Quiz';

  @override
  String get question => 'Question';
}
