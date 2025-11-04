class Signal {
  final DateTime timestamp;
  final String direction;
  final double confidence;

  Signal({required this.timestamp, required this.direction, required this.confidence});

  factory Signal.fromJson(Map<String, dynamic> json) {
    return Signal(
      timestamp: DateTime.parse(json['timestamp']),
      direction: json['direction'],
      confidence: (json['confidence'] as num).toDouble(),
    );
  }
}