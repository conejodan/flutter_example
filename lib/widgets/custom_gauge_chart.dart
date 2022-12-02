import 'package:flutter/material.dart';
import 'package:pretty_gauge/pretty_gauge.dart';

class CustomGauge extends StatelessWidget {
  final double value;
  final String title;
  final double maxValue;
  final Color primaryColor;
  final Color secondaryColor;
  final List<GaugeSegment>? segments;
  const CustomGauge({
    Key? key,
    required this.value,
    this.title = '',
    this.maxValue = 100,
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.grey,
    this.segments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrettyGauge(
      gaugeSize: 170,
      showMarkers: false,
      minValue: 0,
      maxValue: maxValue,
      segments: segments ??
          [
            GaugeSegment('Low', value, primaryColor),
            GaugeSegment('Medium', maxValue - value, secondaryColor),
          ],
      needleColor: Color.fromARGB(255, 146, 190, 227),
      currentValue: value,
      valueWidget: Text('$value', style: TextStyle(fontSize: 16)),
      displayWidget: Text(title, style: TextStyle(fontSize: 16)),
    );
  }
}
