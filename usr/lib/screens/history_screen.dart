import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../models/signal.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final history = Provider.of<ApiService>(context).history;
    return Scaffold(
      appBar: AppBar(title: Text('History')),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final sig = history[index];
          return ListTile(
            title: Text(
                '${sig.direction} - ${(sig.confidence * 100).toStringAsFixed(1)}%'),
            subtitle: Text(sig.timestamp.toLocal().toString()),
          );
        },
      ),
    );
  }
}