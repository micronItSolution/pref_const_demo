import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_reminder/interfaces/top_bar_click_listener.dart';
import 'package:pills_reminder/utils/asset.dart';
import 'package:pills_reminder/utils/color.dart';
import 'package:pills_reminder/utils/enums.dart';
import 'package:pills_reminder/utils/font_style.dart';
import 'package:pills_reminder/utils/sizer_utils.dart';

class TopBar extends StatefulWidget {
  final TopBarClickListener? clickListener;
  final String headerTitle;
  final bool isShowSave;
  final bool isShowBack;
  final bool isEdit;
  final bool isDrawer;
  final bool isContact;

  const TopBar(
      {Key? key,
      this.headerTitle = "",
      this.clickListener,
      this.isShowBack = false,
      this.isShowSave = false,
      this.isEdit = false,
      this.isDrawer= false,
      this.isContact = false})
      : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  void initState() {
    /* if (Debug.googleAd && !Preference.shared.getIsPurchase()) {
      _loadInterstitialAd();
    }*/
    super.initState();
  }

  /* InterstitialAd? interstitialAd;

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              Utils.showHideStatusBar(isHide: false);
              _loadInterstitialAd();
            },
          );
          interstitialAd = ad;
          setState(() {});
        },
        onAdFailedToLoad: (err) {
          Debug.printLog("Failed to load an interstitial ad:", err.message);
        },
      ),
    );
  }

  showAd() async{
    Debug.printLog("topbar", (interstitialAd != null).toString());
    if (interstitialAd != null && Preference.shared.getInterstitialAdCount() % Constant.interstitialCount == 0) {
      Utils.showHideStatusBar();
      await interstitialAd!.show();
    }
    Preference.shared.setInterstitialAdCount(Preference.shared.getInterstitialAdCount() + 1);
  }
*/
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: AppSizes.width_4_5, vertical: AppSizes.height_1),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (widget.isShowBack) ...{
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    widget.clickListener?.onTopBarClick(EnumTopBar.topBarBack);
                  },

                  child: Container(
                      height: AppSizes.height_5,
                      width: AppSizes.height_5,
                      padding:
                          EdgeInsets.symmetric(vertical: AppSizes.height_0_7),
                      child: Image.asset(AppAsset.icBackspaceWhite)),
                ),
              )
            },if (widget.isDrawer) ...{
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    widget.clickListener?.onTopBarClick(EnumTopBar.topBarDrawer);
                  },

                  child: Container(
                      height: AppSizes.height_5,
                      width: AppSizes.height_5,
                      padding:
                          EdgeInsets.symmetric(vertical: AppSizes.height_0_7),
                      child: Image.asset(AppAsset.icMenuWhite)),
                ),
              )
            },
            Center(
              child: Text(
                widget.headerTitle,
                style: AppFontStyle.styleW600(
                  AppColor.white,
                  AppFontSize.size_16,
                ),
              ),
            ),
            if (widget.isShowSave) ...{
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // showAd();
                    widget.clickListener?.onTopBarClick(EnumTopBar.topBarSave);
                  },
                  child: Image.asset(
                    AppAsset.icDoneBlack,
                    height: AppSizes.height_3,
                    width: AppSizes.height_3,
                    color: AppColor.white,
                  ),
                ),
              )
            },
            if (widget.isEdit) ...{
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // showAd();
                    widget.clickListener?.onTopBarClick(EnumTopBar.topBarEdit);
                  },
                  child: Image.asset(
                    AppAsset.icEdit,
                    height: AppSizes.height_2_5,
                    color: AppColor.white,
                  ),
                ),
              )
            },
          ],
        ),
      ),
    );
  }
}
