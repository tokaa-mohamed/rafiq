import 'package:flutter/material.dart';
import '../utils/app_fonts_config.dart';

class AppTextStyles {
  static const String _cairo = 'Cairo';
  static const String _merriweather = 'MerriweatherSans';


  static const TextStyle bold28merr = TextStyle(
    fontFamily: _merriweather,
    fontSize: AppFontSizes.s28,
    fontWeight: AppFontWeights.extraBold,
  );

  static const TextStyle bold16cairo = TextStyle(
    fontFamily: _merriweather,
    fontSize: AppFontSizes.s16,
    fontWeight: AppFontWeights.bold,
  );

  static const TextStyle regular20merr = TextStyle(
    fontFamily: _merriweather,
    fontSize: AppFontSizes.s20,
    fontWeight: AppFontWeights.regular,
  );


  static const TextStyle regular16merr = TextStyle(
    fontFamily: _merriweather,
    fontSize: AppFontSizes.s16,
    fontWeight: AppFontWeights.regular,
  );

  static const TextStyle regular16cairo = TextStyle(
    fontFamily: _cairo,
    fontSize: AppFontSizes.s16,
    fontWeight: AppFontWeights.regular,
  );

  static const TextStyle regular14cairo = TextStyle(
    fontFamily: _cairo,
    fontSize: AppFontSizes.s14,
    fontWeight: AppFontWeights.regular,
  );

  static const TextStyle extrabold28cairo = TextStyle(
    fontFamily: _cairo,
    fontSize: AppFontSizes.s28,
    fontWeight: AppFontWeights.extraBold,
  );

    static const TextStyle regular20cairo = TextStyle(
    fontFamily: _cairo,
    fontSize: AppFontSizes.s20,
    fontWeight: AppFontWeights.regular,
  );

}