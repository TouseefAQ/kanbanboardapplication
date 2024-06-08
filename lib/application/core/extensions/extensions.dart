import 'package:flutter/material.dart';

extension HexColor on Color {
  static Color fromHex(String? hexColorString) {
    if (hexColorString == null) {
      return Colors.transparent;
    }
    hexColorString = hexColorString.replaceAll("#", '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}

extension SizeExt on num {
  SizedBox verticalBoxPadding() => SizedBox(height: toDouble());
  SizedBox horizontalBoxPadding() => SizedBox(width: toDouble());
}

extension DataParser on dynamic {
  String get asString => this == null ? '' : toString();
  num get asNum => this == null ? 0 : this as num;
  double get asDouble => this == null ? 0 : this as double;
  List get asList => this == null ? [] : this as List;
  Map get asMap => this == null ? {} : this as Map;
  bool get asBool => this == null ? false : this as bool;

  double get parseToDouble => double.tryParse(toString()) ?? 0.0;
  int get parseToInt => int.tryParse(toString()) ?? 0;

  bool get intToBool => this == 1 ? true : false;
  int get boolToInt => this == true ? 1 : 0;
}

extension AppTheme on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ThemeData get theme => Theme.of(this);
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get primaryColorWithBaseOpacity => primaryColor.withOpacity(0.2);

  Color get cardColor => Theme.of(this).cardColor;
  Color get dividerColor => Theme.of(this).dividerColor;
  Color get disabledColor => Theme.of(this).disabledColor;


  Color get lightGreyBorderColor => HexColor.fromHex("f6f6f6");
  Color get lightGreyNavBarColor => HexColor.fromHex("CFD6DC");
  Color get lightGreyTextColor => HexColor.fromHex("7E8392");
  Color get lightBlackColor => HexColor.fromHex("323643");
}





extension FormatChecker on String? {
  bool isSvg() {
    return this != null && this!.endsWith('.svg');
  }
}

extension BoldSubString on Text {
  Text boldSubString(String target) {
    final textSpans = List.empty(growable: true);
    final escapedTarget = RegExp.escape(target);
    final pattern = RegExp(escapedTarget, caseSensitive: false);
    final matches = pattern.allMatches(data!);

    int currentIndex = 0;
    for (final match in matches) {
      final beforeMatch = data!.substring(currentIndex, match.start);
      if (beforeMatch.isNotEmpty) {
        textSpans.add(TextSpan(text: beforeMatch));
      }

      final matchedText = data!.substring(match.start, match.end);
      textSpans.add(
        TextSpan(
          text: matchedText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );

      currentIndex = match.end;
    }

    if (currentIndex < data!.length) {
      final remainingText = data!.substring(currentIndex);
      textSpans.add(TextSpan(text: remainingText));
    }

    return Text.rich(
      TextSpan(children: <TextSpan>[...textSpans]),
    );
  }
}


extension WidgetGestureX on Widget {
  Widget onTap(VoidCallback onTap){
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }

}
