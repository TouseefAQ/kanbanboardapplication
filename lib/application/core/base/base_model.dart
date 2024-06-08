import 'dart:convert';

import 'package:flutter/cupertino.dart';

/// `BaseModel` is an abstract class that provides a base for all models.
///
/// This class includes a nullable string for the ID and getter and setter methods for the ID.
/// It also includes a getter for whether the model has data, which is true if the ID is not null.
///
/// The `BaseModel` class has methods for converting from and to JSON, comparing instances, and parsing various types from JSON.
/// These types include color, string, date, map, int, double, and bool.
/// It also has methods for parsing a list and an object from JSON.
abstract class BaseModel {




  /// Converts the `BaseModel` instance to a map of string to dynamic.
  ///
  /// This method should be overridden by subclasses.
  Map<String, dynamic>? toJson();

  /// Overrides the string representation of the `BaseModel` instance.
  ///
  /// Returns the string representation of the JSON of the model.
  @override
  String toString() {
    return toJson().toString();
  }

  /// Parses a color from a JSON object.
  ///
  /// Takes in a map of string to dynamic as the JSON and a string as the attribute.
  /// The attribute is the key in the JSON where the color is stored.
  /// The color is stored as a hex string.
  ///
  /// If the color cannot be parsed, an exception is thrown.
  Color colorFromJson(Map<String, dynamic>? json, String attribute,
      {String defaultHexColor = "#000000"}) {
    try {
      return json?[attribute].fromHex;
    } catch (e) {
      throw Exception('Error while parsing $attribute[$e]');
    }
  }

  /// Parses a string from a JSON object.
  ///
  /// Takes in a map of string to dynamic as the JSON and a string as the attribute.
  /// The attribute is the key in the JSON where the string is stored.
  ///
  /// If the string cannot be parsed, an exception is thrown.
  String stringFromJson(Map<String, dynamic>? json, String attribute,
      {String defaultValue = ''}) {
    try {
      return json != null
          ? json[attribute] != null
              ? json[attribute].toString()
              : defaultValue
          : defaultValue;
    } catch (e) {
      throw Exception('Error while parsing $attribute[$e]');
    }
  }

  /// Parses a date from a JSON object.
  ///
  /// Takes in a map of string to dynamic as the JSON and a string as the attribute.
  /// The attribute is the key in the JSON where the date is stored.
  /// The date is stored as a string in the ISO 8601 format.
  ///
  /// If the date cannot be parsed, an exception is thrown.
  DateTime? dateFromJson(Map<String, dynamic>? json, String attribute,
      {DateTime? defaultValue}) {
    try {
      return json != null
          ? json[attribute] != null
              ? DateTime.parse(json[attribute]).toLocal()
              : defaultValue
          : defaultValue;
    } catch (e) {
      throw Exception('Error while parsing $attribute[$e]');
    }
  }

  /// Parses a map from a JSON object.
  ///
  /// Takes in a map of string to dynamic as the JSON and a string as the attribute.
  /// The attribute is the key in the JSON where the map is stored.
  ///
  /// If the map cannot be parsed, an exception is thrown.
  dynamic mapFromJson(Map<String, dynamic>? json, String attribute,
      {Map<dynamic, dynamic>? defaultValue}) {
    try {
      return json != null
          ? json[attribute] != null
              ? jsonDecode(json[attribute])
              : defaultValue
          : defaultValue;
    } catch (e) {
      throw Exception('Error while parsing $attribute[$e]');
    }
  }

  /// Parses an integer from a JSON object.
  ///
  /// Takes in a map of string to dynamic as the JSON and a string as the attribute.
  /// The attribute is the key in the JSON where the integer is stored.
  ///
  /// If the integer cannot be parsed, an exception is thrown.
  int intFromJson(Map<String, dynamic>? json, String attribute,
      {int defaultValue = 0}) {
    try {
      if (json != null && json[attribute] != null) {
        if (json[attribute] is int) {
          return json[attribute];
        }
        return int.parse(json[attribute]);
      }
      return defaultValue;
    } catch (e) {
      throw Exception('Error while parsing $attribute[$e]');
    }
  }

  /// Parses a double from a JSON object.
  ///
  /// Takes in a map of string to dynamic as the JSON and a string as the attribute.
  /// The attribute is the key in the JSON where the double is stored.
  ///
  /// If the double cannot be parsed, an exception is thrown.
  double doubleFromJson(Map<String, dynamic>? json, String attribute,
      {int decimal = 2, double defaultValue = 0.0}) {
    try {
      if (json != null && json[attribute] != null) {
        if (json[attribute] is double) {
          return double.parse(json[attribute].toStringAsFixed(decimal));
        }
        if (json[attribute] is int) {
          return double.parse(
              json[attribute].toDouble().toStringAsFixed(decimal));
        }
        return double.parse(
            double.tryParse(json[attribute])!.toStringAsFixed(decimal));
      }
      return defaultValue;
    } catch (e) {
      throw Exception('Error while parsing $attribute[$e]');
    }
  }

  /// Parses a boolean from a JSON object.
  ///
  /// Takes in a map of string to dynamic as the JSON and a string as the attribute.
  /// The attribute is the key in the JSON where the boolean is stored.
  ///
  /// If the boolean cannot be parsed, an exception is thrown.
  bool boolFromJson(Map<String, dynamic>? json, String attribute,
      {bool defaultValue = false}) {
    try {
      if (json != null && json[attribute] != null) {
        if (json[attribute] is bool) {
          return json[attribute];
        } else if ((json[attribute] is String) &&
            !['0', '', 'false'].contains(json[attribute])) {
          return true;
        } else if ((json[attribute] is int) &&
            ![0, -1].contains(json[attribute])) {
          return true;
        }
        return false;
      }
      return defaultValue;
    } catch (e) {
      throw Exception('Error while parsing $attribute[$e]');
    }
  }

  /// Parses a list from a JSON array.
  ///
  /// Takes in a map of string to dynamic as the JSON, a list of strings as the attribute, and a callback function.
  /// The attribute is the list of keys in the JSON where the list is stored.
  /// The callback function is used to parse each item in the list.
  ///
  /// If the list cannot be parsed, an exception is thrown.
  List<T> listFromJsonArray<T>(Map<String, dynamic>? json,
      List<String> attribute, T Function(Map<String, dynamic>?) callback) {
    String attribute0 = attribute
        .firstWhere((element) => (json?[element] != null), orElse: () => '');
    return listFromJson(json, attribute0, callback);
  }

  /// Parses a list from a JSON object.
  ///
  /// Takes in a map of string to dynamic as the JSON, a string as the attribute, and a callback function.
  /// The attribute is the key in the JSON where the list is stored.
  /// The callback function is used to parse each item in the list.
  ///
  /// If the list cannot be parsed, an exception is thrown.
  List<T> listFromJson<T>(Map<String, dynamic>? json, String attribute,
      T Function(Map<String, dynamic>?) callback) {
    try {
      List<T> list = <T>[];
      if (json != null &&
          json[attribute] != null &&
          json[attribute] is List &&
          json[attribute].length > 0) {
        json[attribute].forEach((v) {
          if (v is Map<String, dynamic>?) {
            list.add(callback(v));
          }
        });
      }
      return list;
    } catch (e) {
      throw Exception('Error while parsing $attribute[$e]');
    }
  }

  /// Parses an object from a JSON object.
  ///
  /// Takes in a map of string to dynamic as the JSON, a string as the attribute, and a callback function.
  /// The attribute is the key in the JSON where the object is stored.
  /// The callback function is used to parse the object.
  ///
  /// If the object cannot be parsed, an exception is thrown.
  T? objectFromJson<T>(Map<String, dynamic>? json, String attribute,
      T Function(Map<String, dynamic>?) callback,
      {T? defaultValue}) {
    try {
      if (json != null &&
          json[attribute] != null &&
          json[attribute] is Map<String, dynamic>?) {
        return callback(json[attribute]);
      }
      return defaultValue;
    } catch (e) {
      throw Exception('Error while parsing $attribute[$e]');
    }
  }
}
