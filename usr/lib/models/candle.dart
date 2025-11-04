class Candle {
  final DateTime time;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;
  final double? rsi;
  final double? macd;
  final double? signalLine;
  final double? ema50;
  final double? ema200;

  Candle({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
    this.rsi,
    this.macd,
    this.signalLine,
    this.ema50,
    this.ema200,
  });

  factory Candle.fromJson(Map<String, dynamic> json) {
    return Candle(
      time: DateTime.parse(json['time']),
      open: (json['open'] as num).toDouble(),
      high: (json['high'] as num).toDouble(),
      low: (json['low'] as num).toDouble(),
      close: (json['close'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
      rsi: json['rsi'] != null ? (json['rsi'] as num).toDouble() : null,
      macd: json['macd'] != null ? (json['macd'] as num).toDouble() : null,
      signalLine: json['signalLine'] != null ? (json['signalLine'] as num).toDouble() : null,
      ema50: json['ema50'] != null ? (json['ema50'] as num).toDouble() : null,
      ema200: json['ema200'] != null ? (json['ema200'] as num).toDouble() : null,
    );
  }
}