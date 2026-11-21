import 'dart:convert';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

/// flutter_session
/// A package that adds session functionality to Flutter with Base64 obfuscation
class FlutterSession {
  final Map _session = {};
  SharedPreferences? prefs;

  Future _initSharedPrefs() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  Future<dynamic> get(String key) async {
    await _initSharedPrefs();
    final value = prefs?.get(key);

    if (value is String) {
      try {
        // Attempt to decode from Base64 obfuscation
        final decodedBytes = base64.decode(value);
        final decodedString = utf8.decode(decodedBytes);
        try {
          return json.decode(decodedString);
        } catch (_) {
          return decodedString;
        }
      } catch (_) {
        // Fallback if not Base64 encoded
        try {
          return json.decode(value);
        } catch (_) {
          return value;
        }
      }
    }
    return value;
  }

  Future<void> set(String key, dynamic value) async {
    await _initSharedPrefs();

    String rawString;
    if (value is String) {
      rawString = value;
    } else if (value is int || value is bool || value is double) {
      rawString = value.toString();
    } else if (value is List<String>) {
      rawString = json.encode(value);
    } else if (value is Color) {
      rawString = value.toARGB32().toString();
    } else {
      try {
        rawString = json.encode((value as dynamic).toJson());
      } catch (e) {
        rawString = value.toString();
      }
    }

    // Obfuscate (Base64 encode) before saving locally
    final obfuscatedValue = base64.encode(utf8.encode(rawString));
    await prefs?.setString(key, obfuscatedValue);

    _session[key] = value;
  }
}

library flutter_session_plus;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FlutterSession {
  /// Initialize session container
  final Map _session = {};

  // Yes, it uses SharedPreferences
  SharedPreferences? prefs;

  // Initialize the SharedPreferences instance
  Future _initSharedPrefs() async {
    this.prefs = await SharedPreferences.getInstance();
  }

  /// Item setter
  ///
  /// @param key String
  /// @returns Future
  Future get(key) async {
    await _initSharedPrefs();
    try {
      dynamic jsonValue = prefs?.get(key);
      return json.decode(jsonValue);
    } catch (e) {
      return prefs?.get(key);
    }
  }

  /// Item setter
  ///
  /// @param key String
  /// @param value any
  /// @returns Future
  Future set(key, value) async {
    await _initSharedPrefs();

    // Detect item type
    switch (value.runtimeType) {
    // String
      case String:
        {
          prefs?.setString(key, value);
        }
        break;

    // Integer
      case int:
        {
          prefs?.setInt(key, value);
        }
        break;

    // Boolean
      case bool:
        {
          prefs?.setBool(key, value);
        }
        break;

    // Double
      case double:
        {
          prefs?.setDouble(key, value);
        }
        break;

    // List<String>
      case List:
        {
          prefs?.setStringList(key, value);
        }
        break;

    // Object
      default:
        {
          prefs?.setString(key, json.encode(value.toJson()));
        }
    }

    // Add item to session container
    _session.putIfAbsent(key, () => value);
  }
}
