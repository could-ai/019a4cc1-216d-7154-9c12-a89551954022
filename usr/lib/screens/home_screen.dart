import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../models/signal.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Signal? _currentSignal;
  Timer? _timer;
  Duration _timeToNextCandle = Duration.zero;

  @override
  void initState() {
    super.initState();
    _fetchSignal();
    _startTimers();
  }

  void _fetchSignal() async {
    final api = Provider.of<ApiService>(context, listen: false);
    final signal = await api.fetchCurrentSignal();
    setState(() {
      _currentSignal = signal;
    });
  }

  void _startTimers() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      _updateCountdown();
      // Refresh signal periodically (every 5 seconds as example)
      if (DateTime.now().second % 5 == 0) {
        _fetchSignal();
      }
    });
  }

  void _updateCountdown() {
    final now = DateTime.now();
    final nextMinute = now.add(Duration(minutes: 1))
        .subtract(Duration(
            seconds: now.second,
            milliseconds: now.millisecond,
            microseconds: now.microsecond));
    setState(() {
      _timeToNextCandle = nextMinute.difference(now);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signal = _currentSignal;
    final api = Provider.of<ApiService>(context);
    return Scaffold(
      appBar: AppBar(title: Text('AI Binary Signal Pro')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Pair:', style: TextStyle(fontSize: 16)),
            DropdownButton<String>(
              value: api.selectedPair,
              items: api.pairs
                  .map((pair) => DropdownMenuItem(child: Text(pair), value: pair))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  api.updatePair(value);
                  _fetchSignal();
                }
              },
            ),
            SizedBox(height: 20),
            if (signal != null) ...[
              Text('Signal: ${signal.direction}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text('Confidence: ${(signal.confidence * 100).toStringAsFixed(1)}%',
                  style: TextStyle(fontSize: 18)),
            ] else
              Center(child: CircularProgressIndicator()),
            SizedBox(height: 20),
            Text('Next Candle In: ${_timeToNextCandle.inSeconds}s'),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/chart'),
                    child: Text('Chart')),
                ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/history'),
                    child: Text('History')),
                ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/settings'),
                    child: Text('Settings')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}