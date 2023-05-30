import 'dart:io';
import 'dart:math';
import 'package:chat_bot/pages/chat_pages/chat_screen_controller.dart';
import 'package:chat_bot/utils/app_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdsController extends GetxController with WidgetsBindingObserver {
  AppOpenAd? appOpenAd;
  InterstitialAd? interstitialAd;
  bool isPaused = false;
  final chatScreenController = Get.find<ChatScreenController>();
  bool bannerAdIsLoaded = false;

  // RewardedAd? rewardedAd;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      isPaused = true;
    }
    if (state == AppLifecycleState.resumed && isPaused) {
      loadAppOpenAd();
      isPaused = false;
    }
  }

  /// APP OPEN ADS
  loadAppOpenAd() {
    AppOpenAd.load(
        adUnitId: Platform.isAndroid ? appOpenAndroidId : appOpenIosId,
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
            onAdLoaded: (ad) {
              appOpenAd = ad;
              appOpenAd!.show();
            },
            onAdFailedToLoad: (error) {}),
        orientation: AppOpenAd.orientationPortrait);
  }

  /// REWARDED ADS
  RewardedAd? rewardedAd;

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: rewardedId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        //when failed to load
        onAdFailedToLoad: (LoadAdError error) {
          print("Failed to load rewarded ad, Error: $error");
        },
        //when loaded
        onAdLoaded: (RewardedAd ad) {
          print("$ad loaded");
          // Keep a reference to the ad so you can show it later.
          rewardedAd = ad;
          //set on full screen content call back
          setFullScreenContentCallback();
        },
      ),
    );
  }

  //method to set show content call back
  void setFullScreenContentCallback() {
    if (rewardedAd == null) return;
    rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      //when ad  shows fullscreen
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print("$ad onAdShowedFullScreenContent"),
      //when ad dismissed by user
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print("$ad onAdDismissedFullScreenContent");
        //dispose the dismissed ad
        ad.dispose();
      },
      //when ad fails to show
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print("$ad  onAdFailedToShowFullScreenContent: $error ");
        //dispose the failed ad
        ad.dispose();
      },

      //when impression is detected
      onAdImpression: (RewardedAd ad) => print("$ad Impression occured"),
    );
  }

  //show ad method1
  void showRewardedAd() {
    // loadRewardedAd();
    if (rewardedAd?.responseInfo != null) {
      rewardedAd?.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) async {
        rewardedAd?.dispose();
        getAd();
        loadRewardedAd();

        update();
        chatScreenController.messageLimit =
            chatScreenController.messageLimit + maxMessageLimit;
        await chatScreenController
            .storeChatLimit(chatScreenController.messageLimit.value);
        print(
            "chatScreenController.messageLimit =------> ${chatScreenController.messageLimit}");
        update();
      });
    }
  }

  /// INTERSISITAL ADS
  void onAdLoaded(InterstitialAd ad) {
    interstitialAd = ad;

    interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        interstitialAd?.dispose();
        initAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        interstitialAd?.dispose();
        initAd();
      },
    );
  }

  void initAd() {
    InterstitialAd.load(
      adUnitId: Platform.isAndroid ? interstitialAndroidId : interstitialIosId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: (error) {
          interstitialAd = null;

          initAd();
        },
      ),
    );
  }

  void getAd() {
    interstitialAd?.show();
    interstitialAd = null;
  }

  final bannerAds = BannerAd(
      size: AdSize.banner,
      adUnitId: bannerAndroidId,
      listener: BannerAdListener(),
      request: AdRequest()).obs;

  Future<void> loadBanner() async {
    await bannerAds.value.load();
    update();
  }

  @override
  void onInit() async {
    await loadAppOpenAd();
    loadRewardedAd();
    initAd();
    await loadBanner();
    WidgetsBinding.instance.addObserver(this);

    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    rewardedAd?.dispose();
    interstitialAd?.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
