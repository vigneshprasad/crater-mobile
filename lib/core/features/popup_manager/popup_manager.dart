import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/app_constants.dart';
import '../../../utils/app_localizations.dart';
import '../../widgets/success_popup/success_popup.dart';

final popupManagerProvider = Provider<PopupManager>((_) => PopupManagerImpl());

enum PopupType {
  signupComplete,
  conversationJoin,
  conversationOptIn,
  conversationLeave,
  paymentComplete
}

abstract class PopupManager {
  Future<void> showPopup(PopupType type, BuildContext context);
}

const signupCompleteKey = 'signup_complete_popup_shown';
const conversationJoinKey = 'conversation_join_popup_shown';
const conversationOptInKey = 'conversation_optin_popup_shown';
const conversationLeaveKey = 'conversation_leave_popup_shown';
const paymentCompleteKey = 'payment_complete_popup_shown';

class PopupManagerImpl implements PopupManager {
  Map<String, bool> popupStatus = {
    signupCompleteKey: false,
    conversationJoinKey: false,
    conversationOptInKey: false,
    conversationLeaveKey: false,
    paymentCompleteKey: false
  };

  String getSharedPreferencekey(PopupType type) {
    String key;
    switch (type) {
      case PopupType.signupComplete:
        key = signupCompleteKey;
        break;
      case PopupType.conversationJoin:
        key = conversationJoinKey;
        break;
      case PopupType.conversationOptIn:
        key = conversationOptInKey;
        break;
      case PopupType.conversationLeave:
        key = conversationLeaveKey;
        break;
      case PopupType.paymentComplete:
        key = paymentCompleteKey;
        break;
      default:
        key = null;
    }
    return key;
  }

  Future<bool> getStatus(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  Future<void> saveStatus(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, true);
  }

  Future<bool> shouldShowPopup(PopupType type) async {
    final key = getSharedPreferencekey(type);
    if (popupStatus[key] == true) {
      return false;
    }
    final state = await getStatus(key);

    if (state == true) {
      return false;
    }

    popupStatus[key] = true;
    await saveStatus(key);

    return true;
  }

  @override
  Future<void> showPopup(PopupType type, BuildContext context) async {
    final canShowPopup = await shouldShowPopup(type);
    if (!canShowPopup) {
      return;
    }

    switch (type) {
      case PopupType.signupComplete:
        await onSignupCompleted(context);
        break;
      case PopupType.conversationOptIn:
        await onConversationOptin(context);
        break;
      case PopupType.conversationJoin:
        await onConversionJoined(context);
        break;
      case PopupType.conversationLeave:
        await onLeaveConversation(context);
        break;
      case PopupType.paymentComplete:
        await onPaymentCompleted(context);
        break;
      default:
    }
  }

  Future<void> onSignupCompleted(BuildContext context) async {
    final title =
        AppLocalizations.of(context).translate('popup:signup_complete_title');
    final message =
        AppLocalizations.of(context).translate('popup:signup_complete_message');
    final buttonTitle = AppLocalizations.of(context)
        .translate('popup:signup_complete_button_title');

    await Future.delayed(const Duration(seconds: 1));
    await Navigator.of(context).push(SuccessPopup(
        title: title,
        message: message,
        buttonTitle: buttonTitle,
        iconAsset: AppImageAssets.signupComplete,
        onButtonClicked: () {
          Navigator.of(context).pop(true);
        }));
  }

  Future<void> onConversionJoined(BuildContext context) async {
    final title =
        AppLocalizations.of(context).translate('popup:conversation_join_title');
    final message = AppLocalizations.of(context)
        .translate('popup:conversation_join_message');
    final buttonTitle = AppLocalizations.of(context)
        .translate('popup:conversation_join_button_title');

    await Future.delayed(const Duration(seconds: 1));
    await Navigator.of(context).push(SuccessPopup(
        title: title,
        message: message,
        buttonTitle: buttonTitle,
        iconAsset: AppImageAssets.conversationJoin,
        onButtonClicked: () {
          Navigator.of(context).pop(true);
        }));
  }

  Future<void> onConversationOptin(BuildContext context) async {
    final title = AppLocalizations.of(context)
        .translate('popup:conversation_optin_title');
    final message = AppLocalizations.of(context)
        .translate('popup:conversation_optin_message');
    final buttonTitle = AppLocalizations.of(context)
        .translate('popup:conversation_optin_button_title');

    await Future.delayed(const Duration(seconds: 1));
    await Navigator.of(context).push(SuccessPopup(
        title: title,
        message: message,
        buttonTitle: buttonTitle,
        iconAsset: AppImageAssets.conversationOptin,
        onButtonClicked: () {
          Navigator.of(context).pop(true);
        }));
  }

  Future<void> onLeaveConversation(BuildContext context) async {
    final title = AppLocalizations.of(context)
        .translate('popup:conversation_leave_title');
    final message = AppLocalizations.of(context)
        .translate('popup:conversation_leave_message');
    final buttonTitle = AppLocalizations.of(context)
        .translate('popup:conversation_leave_button_title');

    await Future.delayed(const Duration(seconds: 1));

    await Navigator.of(context).push(SuccessPopup(
        title: title,
        message: message,
        buttonTitle: buttonTitle,
        iconAsset: AppImageAssets.conversationLeave,
        onButtonClicked: () {
          Navigator.of(context).pop(true);
        }));
  }

  Future<void> onPaymentCompleted(BuildContext context) async {
    final successText =
        AppLocalizations.of(context).translate('rewards:succes_text');
    final successDesc =
        AppLocalizations.of(context).translate('rewards:success_desc');
    final buttonText = AppLocalizations.of(context).translate("got_it");
    await Navigator.of(context)
        .push(
          SuccessPopup(
              title: successText,
              message: successDesc,
              buttonTitle: buttonText,
              iconAsset: AppImageAssets.packageSuccess,
              onButtonClicked: () {
                Navigator.of(context).pop(true);
              }),
        )
        .then((value) => ExtendedNavigator.of(context).popUntilRoot());
  }
}
