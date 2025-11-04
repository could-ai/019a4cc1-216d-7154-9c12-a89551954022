import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/signal.dart';

class ApiService extends ChangeNotifier {
  String selectedPair = 'EUR/USD';
  List<String> pairs = ['EUR/USD', 'GBP/JPY', 'USD/JPY'];
  String candleInterval = '1m';
  bool notificationsEnabled = true;

  Signal? currentSignal;
  List<Signal> history = [];

  Future<Signal> fetchCurrentSignal() async {
    final url = Uri.parse(
        'http://localhost:8000/api/signal?pair=$selectedPair&interval=$candleInterval');
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final jsonData = json.decode(res.body);
        currentSignal = Signal.fromJson(jsonData);
      } else {
        currentSignal = Signal(
            timestamp: DateTime.now(), direction: 'NONE', confidence: 0);
      }
    } catch (e) {
      currentSignal =
          Signal(timestamp: DateTime.now(), direction: 'ERROR', confidence: 0);
    }
    if (notificationsEnabled) {
      // TODO: integrate push notification when new signal arrives
    }
    history.insert(0, currentSignal!);
    notifyListeners();
    return currentSignal!;
  }

  void updatePair(String pair) {
    selectedPair = pair;
    notifyListeners();
  }

  void updateCandleInterval(String interval) {
    candleInterval = interval;
    notifyListeners();
  }

  void updateNotificationsEnabled(bool enabled) {
    notificationsEnabled = enabled;
    notifyListeners();
  }
}