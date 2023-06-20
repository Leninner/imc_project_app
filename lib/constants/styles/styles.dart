import 'package:flutter/material.dart';

class StyleConstants {
  static const primaryFont = 'Roboto';
  static const secondaryFont = 'Montserrat';

  static const EdgeInsets paddingSmall = EdgeInsets.all(_paddingSmall);

  static const EdgeInsets paddingLeftSmall =
      EdgeInsets.only(left: _paddingSmall);
  static const EdgeInsets paddingRightSmall =
      EdgeInsets.only(right: _paddingSmall);
  static const EdgeInsets paddingBottomSmall =
      EdgeInsets.only(bottom: _paddingSmall);
  static const EdgeInsets paddingTopSmall = EdgeInsets.only(top: _paddingSmall);

  static const EdgeInsets paddingMedium = EdgeInsets.all(_paddingMedium);
  static const EdgeInsets paddingMediumY =
      EdgeInsets.only(top: _paddingMedium, bottom: _paddingMedium);
  static const EdgeInsets paddingLeftMedium =
      EdgeInsets.only(left: _paddingMedium);
  static const EdgeInsets paddingRightMedium =
      EdgeInsets.only(right: _paddingMedium);
  static const EdgeInsets paddingBottomMedium =
      EdgeInsets.only(bottom: _paddingMedium);
  static const EdgeInsets paddingTopMedium =
      EdgeInsets.only(top: _paddingMedium);

  static const EdgeInsets paddingLarge = EdgeInsets.all(_paddingLarge);
  static const EdgeInsets paddingLargeX =
      EdgeInsets.only(left: _paddingLarge, right: _paddingLarge);
  static const EdgeInsets paddingLeftLarge =
      EdgeInsets.only(left: _paddingLarge);
  static const EdgeInsets paddingRightLarge =
      EdgeInsets.only(right: _paddingLarge);
  static const EdgeInsets paddingBottomLarge =
      EdgeInsets.only(bottom: _paddingLarge);
  static const EdgeInsets paddingTopLarge = EdgeInsets.only(top: _paddingLarge);

  static const EdgeInsets marginSmall = EdgeInsets.all(_marginSmall);
  static const EdgeInsets marginLeftSmall = EdgeInsets.only(left: _marginSmall);
  static const EdgeInsets marginRightSmall =
      EdgeInsets.only(right: _marginSmall);
  static const EdgeInsets marginBottomSmall =
      EdgeInsets.only(bottom: _marginSmall);
  static const EdgeInsets marginTopSmall = EdgeInsets.only(top: _marginSmall);

  static const EdgeInsets marginMedium = EdgeInsets.all(_marginMedium);
  static const EdgeInsets marginLeftMedium =
      EdgeInsets.only(left: _marginMedium);
  static const EdgeInsets marginRightMedium =
      EdgeInsets.only(right: _marginMedium);
  static const EdgeInsets marginBottomMedium =
      EdgeInsets.only(bottom: _marginMedium);
  static const EdgeInsets marginTopMedium = EdgeInsets.only(top: _marginMedium);

  static const EdgeInsets marginLarge = EdgeInsets.all(_marginLarge);
  static const EdgeInsets marginLeftLarge = EdgeInsets.only(left: _marginLarge);
  static const EdgeInsets marginRightLarge =
      EdgeInsets.only(right: _marginLarge);
  static const EdgeInsets marginBottomLarge =
      EdgeInsets.only(bottom: _marginLarge);
  static const EdgeInsets marginTopLarge = EdgeInsets.only(top: _marginLarge);

  static const double _paddingSmall = 8.0;
  static const double _paddingMedium = 16.0;
  static const double _paddingLarge = 32.0;

  static const double _marginSmall = 8.0;
  static const double _marginMedium = 16.0;
  static const double _marginLarge = 32.0;
}
