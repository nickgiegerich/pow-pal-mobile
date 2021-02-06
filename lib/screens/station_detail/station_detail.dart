import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pow_pal_app/style.dart';
import '../../models/state_snotel.dart';
import '../../globals/global_favorites.dart' as global_fav;

class StationDetail extends StatefulWidget {
  final Stations station;
  // final int station_index;
  StationDetail(this.station);

  @override
  _DetailStationState createState() => _DetailStationState();
}

class _DetailStationState extends State<StationDetail> {
  List<Color> gradientColors = [
    const Color(0xff707793),
    const Color(0xff3BBA9C),
  ];
  List<FlSpot> spots = [];
  double maxY = 0;
  double minY = 0;
  bool showHourly = false;

  List<FlSpot> _generateSpots() {
    List<FlSpot> tmp = [];
    for (int i = 0; i < widget.station.hourlyData.length; i++) {
      FlSpot spot = new FlSpot(
          i.toDouble(), widget.station.hourlyData[i].observedAirTemp);
      tmp.add(spot);
    }
    return tmp;
  }

  List<double> _getSpots() {
    List<FlSpot> tmp = spots;
    List<double> data = [];
    tmp.forEach((element) {
      data.add(element.y);
    });
    return data;
  }

  double _findMaxY() {
    double max = widget.station.hourlyData[0].observedAirTemp;
    List<HourlyData> tmpData = widget.station.hourlyData;
    tmpData.forEach((data) {
      if (data.observedAirTemp > max) {
        max = data.observedAirTemp;
      }
    });
    return max + 5;
  }

  double _findMinY() {
    double min = widget.station.hourlyData[0].observedAirTemp;
    List<HourlyData> tmpData = widget.station.hourlyData;
    tmpData.forEach((data) {
      if (data.observedAirTemp < min) {
        min = data.observedAirTemp;
      }
    });
    return min - 5;
  }

  String _getYTitles(int value) {
    List<double> spotYValues = _getSpots();

    if (value % 2 == 0 && spotYValues.contains(value.toDouble())) {
      return value.toString();
    }
    return '';
  }

  String _getXTitles(int value) {
    if (value == 0) {
      return widget.station.hourlyData[0].dateTime
              .toString()
              .substring(11, 16) +
          '\n' +
          widget.station.hourlyData[0].dateTime.toString().substring(5, 10);
    } else if (value == 6) {
      return widget.station.hourlyData[6].dateTime
              .toString()
              .substring(11, 16) +
          '\n' +
          widget.station.hourlyData[6].dateTime.toString().substring(5, 10);
    } else if (value == 12) {
      return widget.station.hourlyData[12].dateTime
              .toString()
              .substring(11, 16) +
          '\n' +
          widget.station.hourlyData[12].dateTime.toString().substring(5, 10);
    } else if (value == 18) {
      return widget.station.hourlyData[18].dateTime
              .toString()
              .substring(11, 16) +
          '\n' +
          widget.station.hourlyData[18].dateTime.toString().substring(5, 10);
    } else if (value == 23) {
      return widget.station.hourlyData[23].dateTime
              .toString()
              .substring(11, 16) +
          '\n' +
          widget.station.hourlyData[23].dateTime.toString().substring(5, 10);
    }
    return '';
  }

  @override
  void initState() {
    setState(() {
      spots = _generateSpots();
      maxY = _findMaxY();
      minY = _findMinY();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.station.name + ' - ' + widget.station.id),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: IconButton(
              icon: global_fav.favorites.contains(widget.station)
                  ? Icon(Icons.star)
                  : Icon(Icons.star_border),
              color: listTileTheme().iconColor,
              onPressed: () {
                setState(() {
                  if (global_fav.favorites.contains(widget.station)) {
                    global_fav.favorites.remove(widget.station);
                  } else {
                    global_fav.favorites.add(widget.station);
                  }
                });
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Some Text',
                style: ChartTitleTextStyle,
              )
            ],
          ),
          Row(
            children: [
              FlatButton(
                onPressed: () {
                  setState(
                    () {
                      showHourly = !showHourly;
                    },
                  );
                },
                child: Text(
                  'hourly',
                  style: TextStyle(
                      fontSize: 12,
                      color: showHourly
                          ? Colors.white.withOpacity(0.5)
                          : Colors.white),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  setState(
                    () {
                      showHourly = !showHourly;
                    },
                  );
                },
                child: Text(
                  'hourly',
                  style: TextStyle(
                      fontSize: 12,
                      color: showHourly
                          ? Colors.white.withOpacity(0.5)
                          : Colors.white),
                ),
              ),
            ],
          ),
          AspectRatio(
            aspectRatio: 1.5,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                  color: Color(0xff232d37)),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 35, left: 12.0, top: 35, bottom: 15),
                child: LineChart(
                  showHourly ? hourly() : weekly(),
                ),
              ),
            ),
          ),
          AspectRatio(
            aspectRatio: 1.5,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                  color: Color(0xff232d37)),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 35, left: 12.0, top: 35, bottom: 15),
                child: LineChart(
                  showHourly ? hourly() : weekly(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  LineChartData hourly() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            return _getXTitles(value.toInt());
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            return _getYTitles(value.toInt());
          },
          reservedSize: 23,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: widget.station.hourlyData.length.toDouble() - 1,
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          show: true,
          spots: spots,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData weekly() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'OCT';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }
}
