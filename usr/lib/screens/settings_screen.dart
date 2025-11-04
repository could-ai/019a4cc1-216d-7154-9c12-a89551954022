import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiService>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Candle Interval:', style: TextStyle(fontSize: 16)),
            DropdownButton<String>(
              value: api.candleInterval,
              items: ['1m', '5m']
                  .map((c) => DropdownMenuItem(child: Text(c), value: c))
                  .toList(),
              onChanged: (val) {
                if (val != null) api.updateCandleInterval(val);
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Notifications:', style: TextStyle(fontSize: 16)),
                Switch(
                  value: api.notificationsEnabled,
                  onChanged: (val) {
                    api.updateNotificationsEnabled(val);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}