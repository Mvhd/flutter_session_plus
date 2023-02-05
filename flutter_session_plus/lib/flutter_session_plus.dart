
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
