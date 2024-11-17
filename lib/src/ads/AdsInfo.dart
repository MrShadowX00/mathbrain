import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

AdRequest request = AdRequest(
  keywords: <String>['Games', 'Flutter', 'Logical', 'Business'],
  contentUrl: 'https://flutter.dev',
  nonPersonalizedAds: true,
);

String getInterstitialAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-7668896830420502/3261247645';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-7668896830420502/1371427381';
  }
  return "";
}

String getRewardBasedVideoAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-7668896830420502/8242111580';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-7668896830420502/8666629321';
  }
  return "";
}

String getBannerAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-7668896830420502/4492414749';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-7668896830420502/8240088062';
  }
  return "";
}
