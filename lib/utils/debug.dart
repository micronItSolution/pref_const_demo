import 'dart:developer';

class Debug {
  ///|>==|>==|> Set all debug variable false when you make release build. <|==<|==<|

  static const debug = true;
  static const googleAd = false;
  static const sandboxVerifyRecieptUrl = false;


  static printLog(String str, [error]) {
    if (debug) log(str);
  }
}
