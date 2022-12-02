import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hello/providers/devices_provider.dart';
import 'package:flutter_hello/widgets/custom_gauge_chart.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:provider/provider.dart';

class DevicesDetailScreen extends StatelessWidget {
  const DevicesDetailScreen({super.key});

  static String route = "/app-devices-detail";

  @override
  Widget build(BuildContext context) {
    final deviceProvider = Provider.of<DevicesProvider>(context, listen: false);
    deviceProvider.startSocketDevice();
    print('Device: ${deviceProvider.selectedDevice.key}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Detail'),
      ),
      body: _DeviceDetail(),
    );
  }
}

class TimeSeriesData {
  final DateTime time;
  final int data;

  TimeSeriesData({required this.time, required this.data});
}

class _DeviceDetail extends StatelessWidget {
  const _DeviceDetail({super.key});

  Color getColorStatus(status) {
    if (status == ServerStatus.online) {
      return Colors.green;
    }
    if (status == ServerStatus.offline) {
      return Colors.red;
    }
    return Colors.yellow;
  }

  @override
  Widget build(BuildContext context) {
    final List<TimeSeriesData> temperatureData =
        List.generate(15, (index) => index).reversed.toList().map((element) {
      Random random = Random();
      return TimeSeriesData(
        time: DateTime.now().subtract(Duration(seconds: element * 4)),
        data: random.nextInt(20) + 20,
      );
    }).toList();

    final deviceProvider = Provider.of<DevicesProvider>(context, listen: true);
    final bool led = deviceProvider.led;
    print("detail");
    return ListView(
      padding: EdgeInsets.all(15),
      children: [
        Text(
          'Device: ${deviceProvider.selectedDevice.key}',
          style: TextStyle(fontSize: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Row(
                children: [
                  Text('Status'),
                  Icon(
                    Icons.circle,
                    color: getColorStatus(deviceProvider.connection),
                  )
                ],
              ),
            ),
            SizedBox(
              child: Row(
                children: [
                  Text('Led'),
                  Switch(
                      value: led,
                      onChanged: (value) {
                        final deviceProvider = Provider.of<DevicesProvider>(
                            context,
                            listen: false);
                        deviceProvider.emitLed(value);
                      })
                ],
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Ink(
              decoration: ShapeDecoration(
                color: led
                    ? Colors.green.withOpacity(.3)
                    : Colors.red.withOpacity(.3),
                shape: const CircleBorder(),
              ),
              child: IconButton(
                iconSize: 30,
                onPressed: () {
                  final deviceProvider =
                      Provider.of<DevicesProvider>(context, listen: false);
                  deviceProvider.emitLed(!deviceProvider.led);
                },
                icon: Icon(
                  Icons.power_settings_new_outlined,
                  color: led ? Colors.green : Colors.red,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomGauge(
              value: deviceProvider.lights.isNotEmpty
                  ? deviceProvider.lights[deviceProvider.lights.length - 1]
                  : 0.0,
              maxValue: 1000,
              title: 'Light',
            ),
            CustomGauge(
              value: 35,
              maxValue: 120,
              title: 'Gass',
              segments: [
                GaugeSegment('Low', 20, Colors.red),
                GaugeSegment('Low-Middle', 20, Colors.orange),
                GaugeSegment('Middle', 20, Colors.yellow),
                GaugeSegment('Middle', 20, Colors.green.shade200),
                GaugeSegment('Middle', 20, Colors.green),
                GaugeSegment('Middle', 20, Colors.green.shade900),
              ],
            ),
          ],
        ),
        Container(
          width: 100,
          height: 300,
          margin: EdgeInsets.all(10),
          child: LineChart(
            LineChartData(
              maxY: 40,
              minY: 10,
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: Colors.white38,
                  width: 2,
                ),
              ),
              titlesData: FlTitlesData(
                topTitles: AxisTitles(),
                rightTitles: AxisTitles(),
                bottomTitles: AxisTitles(
                  drawBehindEverything: true,
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  barWidth: 2,
                  belowBarData: BarAreaData(
                    show: true,
                    color: Color.fromARGB(55, 33, 149, 243),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(0, 104, 176, 236),
                        Color.fromARGB(195, 33, 149, 243),
                      ],
                    ),
                  ),
                  isCurved: true,
                  spots: temperatureData
                      .map(
                        (e) => FlSpot(
                          e.time.millisecondsSinceEpoch.toDouble(),
                          e.data.toDouble(),
                        ),
                      )
                      .toList(),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
