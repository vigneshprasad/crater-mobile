import 'package:flutter/material.dart';

class AppConstants {
  static const googleAuthScope = [
    'email',
    'https://www.googleapis.com/auth/userinfo.profile',
  ];

  static const defaultShareText = """
    Hey, 

    I would like to invite you to WorkNetwork. A place to meet & converse with relevant professionals to trade knowledge & grow your business/career, while building authentic relationships. Here’s the link: https://worknetwork.onelink.me/KbQv/join. 
  """;

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

  static const double profileImageMaxWidth = 1024;

  static const whatsNewPageLink =
      'https://www.notion.so/What-s-new-on-WorkNetwork-b17a439479194ed5890e13fb2cd24c24';
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

  static const splashDiscover =
      AssetImage("assets/images/splash/meeting-table.png");
  static const splashTopic =
      AssetImage("assets/images/splash/converse-topic.png");
  static const splashPeople =
      AssetImage("assets/images/splash/choose-meet.png");
  static const splashAI = AssetImage("assets/images/splash/ai-work.png");
  static const splashConversation =
      AssetImage("assets/images/splash/conversation-setup.png");
  static const splashVirtual =
      AssetImage("assets/images/splash/converse-virtually.png");

  static const splashChat = AssetImage("assets/images/splash/chat.png");
  static const splashAuction = AssetImage("assets/images/splash/auction.png");
  static const splashLearn = AssetImage("assets/images/splash/learn.png");

  static const emptyCalendar =
      AssetImage("assets/images/img_empty_state_calendar.png");

  static const signupComplete = AssetImage("assets/images/ic_signup_popup.png");
  static const conversationJoin =
      AssetImage("assets/images/ic_conversation_join.png");
  static const conversationOptin =
      AssetImage("assets/images/ic_conversation_optin.png");
  static const conversationLeave =
      AssetImage("assets/images/ic_conversation_leave.png");

  static const groupNotFound =
      AssetImage("assets/images/img_meeting_not_found.png");

  static const onboardingGroupCards =
      AssetImage("assets/images/img_group_cards.png");

  static const onboardingHello = AssetImage("assets/images/img_hello.png");
  static const onboardinCall =
      AssetImage("assets/images/img_group_and_one_on_one.png");

  static const feedback = AssetImage("assets/images/feedback.png");

  static const phone = AssetImage("assets/images/phone.png");
  static const username = AssetImage("assets/images/username.png");
  static const circles = AssetImage("assets/images/circles.png");
}

class AppSvgAssets {
  static const googleColored = "assets/svg/google.svg";
  static const linkedin = "assets/svg/linkedin.svg";
  static const linkedinFilled = "assets/svg/linkedin-fill.svg";
  static const facebook = "assets/svg/facebook.svg";
  static const apple = "assets/svg/apple-logo.svg";
  static const twitter = "assets/svg/twitter.svg";
  static const twitterBlack = "assets/svg/twitter-black.svg";
  static const share = "assets/svg/share.svg";
  static const streams = "assets/svg/streams.svg";
  static const home = "assets/svg/home.svg";
  static const homeFilled = "assets/svg/home-filled.svg";
  static const stream = "assets/svg/stream.svg";
  static const streamFilled = "assets/svg/stream-filled.svg";
  static const creators = "assets/svg/creators.svg";
  static const creatorsFilled = "assets/svg/creators-filled.svg";
  static const hub = "assets/svg/hub.svg";
  static const hubFilled = "assets/svg/hub-filled.svg";
  static const profile = "assets/svg/profile.svg";
  static const profileFilled = "assets/svg/profile-filled.svg";
  static const phone = "assets/svg/phone.svg";
  static const cableTV = "assets/svg/cable-tv.svg";
  static const collapse = "assets/svg/collapse.svg";
  static const expand = "assets/svg/expand.svg";
  static const auction = "assets/svg/auction.svg";
  static const chat = "assets/svg/chat.svg";
  static const send = "assets/svg/send.svg";
}

class AppLottieAssets {
  static const imageLoading = "assets/lottie/loading_dots.json";
  static const typingAnimation = "assets/lottie/typing_animation.json";
  static const peopleWaiting = "assets/lottie/people_waiting.json";
}

class AppHeroTransitions {
  static const packageCard = "packageCardTransition";
}
