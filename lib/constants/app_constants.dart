import 'package:flutter/material.dart';

class AppConstants {
  static const googleAuthScope = [
    'email',
    'https://www.googleapis.com/auth/userinfo.profile',
  ];

  static const defaultAvatar = {
    "a":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/A.png',
    "b":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/B.png',
    "c":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/C.png',
    "d":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/D.png',
    "e":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/E.png',
    "f":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/F.png',
    "g":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/G.png',
    "h":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/H.png',
    "i":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/I.png',
    "j":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/J.png',
    "k":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/K.png',
    "l":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/L.png',
    "m":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/M.png',
    "n":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/N.png',
    "o":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/O.png',
    "p":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/P.png',
    "q":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/Q.png',
    "r":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/R.png',
    "s":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/S.png',
    "t":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/T.png',
    "u":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/U.png',
    "v":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/V.png',
    "w":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/W.png',
    "x":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/X.png',
    "y":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/Y.png',
    "z":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/Z.png',
    "default":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/default.png',
  };

  static const String meetingTypeformLink =
      "https://worknetwork.typeform.com/to/OX3ZB9QV#email=";
}

class AppImageAssets {
  static const defaultAvatar =
      AssetImage("assets/images/img_default_avatar.png");
  static const searchUserempty =
      AssetImage("assets/images/img_no_user_search.png");
  static const drawerBg = AssetImage("assets/images/img_drawer_image.png");
  static const articleDefault =
      AssetImage("assets/images/img_article_placeholder.png");
  static const videoPlaceholder =
      AssetImage("assets/images/ic_video_placeholder.png");
  static const emptyMeeting =
      AssetImage("assets/images/img_empty_meetings.png");
  static const registeredMeeting =
      AssetImage("assets/images/img_meeting_registered.png");
  static const meetingsEmpty = AssetImage("assets/images/meetings_empty.png");
  static const meetingScheduled =
      AssetImage("assets/images/meeting_scheduled.png");
  static const packageSuccess =
      AssetImage("assets/images/img_success_purchase.jpg");
  static const rewardsTrophy =
      AssetImage("assets/images/img_reward_trophy.png");
  static const emailReset = AssetImage("assets/images/img_email.png");

  static const splashHome = AssetImage("assets/images/img_splash_home.png");
  static const splashObjective =
      AssetImage("assets/images/img_splash_objective.png");
  static const splashVideoCall =
      AssetImage("assets/images/img_splash_video_call.png");
  static const splashMeetingCard =
      AssetImage("assets/images/img_splash_meeting_card.png");
  static const splashReward = AssetImage("assets/images/img_splash_reward.png");
}

class AppSvgAssets {
  static const googleColored = "assets/svg/google.svg";
  static const linkedinFilled = "assets/svg/linkedin-fill.svg";
  static const facebook = "assets/svg/facebook.svg";
  static const apple = "assets/svg/apple-logo.svg";
}

class AppLottieAssets {
  static const imageLoading = "assets/lottie/loading_dots.json";
  static const typingAnimation = "assets/lottie/typing_animation.json";
}

class AppHeroTransitions {
  static const packageCard = "packageCardTransition";
}
