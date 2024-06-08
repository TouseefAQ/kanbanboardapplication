import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';

logHandler(LogRecord record) {
  final message =
      '[${record.level.name}][Message: ${record.message}] : ${record.error != null ? "[Exception: ${record.error}" : ''}]  ${record.stackTrace != null ? " : [STACKTRACE: ${record.stackTrace}]" : ""}';
  if (record.level == Level.FINE) {
    debugPrint(' ✅ $message');
  } else if (record.level == Level.SEVERE) {
    debugPrint('❌ $message');
  } else if (record.level == Level.WARNING) {
    debugPrint('⚠️ $message');
  } else if (record.level == Level.CONFIG) {
    debugPrint('⚙️ $message');
  } else if (record.level == Level.INFO) {
    final pattern = RegExp('.{1,1000}'); // 1000 is the size of each chunk
    pattern.allMatches(message).forEach((match) => debugPrint(match.group(0)));
  } else {
    debugPrint('❇️ $message');
  }
}

class D {
  static void info(Object? message,
      [Object? error, StackTrace? exceptionStackTrace, Zone? zone]) {
    final stackTrace = Trace.current().frames[1].location;
    var output = "$stackTrace | $message";
    gLog.log(
        Level.INFO, output, error, exceptionStackTrace, (zone ?? Zone.current));
  }

  static void severe(Object? message,
      [Object? error, StackTrace? exceptionStackTrace, Zone? zone]) {
    final stackTrace = Trace.current().frames[1].location;
    var output = "$stackTrace | $message";
    gLog.log(Level.SEVERE, output, error, exceptionStackTrace,
        (zone ?? Zone.current));
  }

  static void warning(Object? message,
      [Object? error, StackTrace? exceptionStackTrace, Zone? zone]) {
    final stackTrace = Trace.current().frames[1].location;
    var output = "$stackTrace | $message";
    gLog.log(Level.WARNING, output, error, exceptionStackTrace,
        (zone ?? Zone.current));
  }

  static void fine(Object? message,
      [Object? error, StackTrace? exceptionStackTrace, Zone? zone]) {
    final stackTrace = Trace.current().frames[1].location;
    var output = "$stackTrace | $message";
    gLog.log(
        Level.FINE, output, error, exceptionStackTrace, (zone ?? Zone.current));
  }

  static void httpRequestLogger(
      {Map<String, String>? headers, String? requestType, Uri? uri}) {
    D.info(
        "NETWORK REQUEST - [TYPE: $requestType] [ENDPOINT: ${uri?.scheme}://${uri?.host}${uri?.path}${uri?.queryParameters}] ${"[HEADERS: $headers]"}");
  }

  static void httpResponseLogger(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      D.info(
          "NETWORK RESPONSE - [STATUS_CODE:${response.statusCode}] [ENDPOINT: ${response.requestOptions.uri.scheme}://${response.requestOptions.uri.host}${response.requestOptions.uri.path}${response.requestOptions.uri.queryParameters}]");
    } else {
      D.severe(
          "NETWORK RESPONSE - [TYPE: ${response.requestOptions.method}] [ENDPOINT: ${response.requestOptions.uri.scheme}://${response.requestOptions.uri.host}${response.requestOptions.uri.path}${response.requestOptions.uri.queryParameters}] [STATUS_CODE:${response.statusCode}]");
    }
  }
}

final gLog = Logger("Global");
