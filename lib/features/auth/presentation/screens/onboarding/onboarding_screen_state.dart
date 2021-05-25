import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const onboardingKey = "SHOWN_ONBOARDING";

final onboardingProvider = Provider((_) => OnboardingState());

class OnboardingState {
  Future<void> setOnboardingShown() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(onboardingKey, true);
  }

  Future<bool> getOnboardingKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingKey) ?? false;
  }
}
