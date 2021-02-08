import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pow_pal_app/style.dart';
import '../../../models/state_snotel.dart';
import '../../../globals/global_favorites.dart' as global_fav;

class HourlyAirTemp extends StatefulWidget {
  final Stations station;

  HourlyAirTemp(this.station);

  @override
  _HourlyAirTempState createState() => _HourlyAirTempState();
}

class _HourlyAirTempState extends State<HourlyAirTemp> {
  List<Color> gradientColors = [
    const Color(0xff707793),
    const Color(0xff3BBA9C),
  ];
  List<FlSpot> spots = [];
  List<FlSpot> weeklySpots = [];
  double maxY = 0;
  double minY = 0;
  double weeklyMaxY = 0;
  double weeklyMinY = 0;

  bool showHourly = false;

  List<Widget> _chartChildren() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          showHourly
              ? Text(
                  'Hourly Air Temp',
                  style: ChartTitleTextStyle,
                )
              : Text(
                  'Weekly Air Temp',
                  style: ChartTitleTextStyle,
                )
        ],
      ),
      Row(
        children: [
          RaisedButton(
            onPressed: () {
              setState(
                () {
                  showHourly = !showHourly;
                },
              );
            },
            child: Text(
              showHourly ? 'hourly' : 'weekly',
              style: TextStyle(
                  fontSize: 12,
                  color: showHourly ? Colors.white : Colors.white),
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
    ];
  }

  List<FlSpot> _generateSpots() {
    List<FlSpot> tmp = [];
    for (int i = 0; i < widget.station.hourlyData.length; i++) {
      FlSpot spot = new FlSpot(
          i.toDouble(), widget.station.hourlyData[i].observedAirTemp);
      tmp.add(spot);
    }
    return tmp;
  }

  List<FlSpot> _generateWeeklySpots() {
    List<FlSpot> tmp = [];
    for (int i = 0; i < widget.station.weeklyData.length; i++) {
      FlSpot spot =
          new FlSpot(i.toDouble(), widget.station.weeklyData[i].airTemp);
      tmp.add(spot);
    }
    return tmp;
  }

  List<double> _getWeeklySpots() {
    List<FlSpot> tmp = weeklySpots;
    List<double> data = [];
    tmp.forEach((element) {
      data.add(element.y);
    });
    print(data);
    return data;
  }

  List<double> _getSpots() {
    List<FlSpot> tmp = spots;
    List<double> data = [];
    tmp.forEach((element) {
      data.add(element.y);
    });
    return data;
  }

  double _findWeeklyMaxY() {
    double max = widget.station.hourlyData[0].observedAirTemp;
    List<HourlyData> tmpData = widget.station.hourlyData;
    tmpData.forEach((data) {
      if (data.observedAirTemp > max) {
        max = data.observedAirTemp;
      }
    });
    return max + 5;
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

  double _findWeeklyMinY() {
    double min = widget.station.hourlyData[0].observedAirTemp;
    List<HourlyData> tmpData = widget.station.hourlyData;
    tmpData.forEach((data) {
      if (data.observedAirTemp < min) {
        min = data.observedAirTemp;
      }
    });
    return min - 5;
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

  String _getWeeklyYTitles(int value) {
    List<double> spotYValues = _getWeeklySpots();

    if (value % 2 == 0 && spotYValues.contains(value.toDouble())) {
      return value.toString();
    }
    return '';
  }

  String _getYTitles(int value) {
    List<double> spotYValues = _getSpots();

    if (value % 2 == 0 && spotYValues.contains(value.toDouble())) {
      return value.toString();
    }
    return '';
  }

  String _getWeeklyXTitles(int value) {
    if (value == 0) {
      return widget.station.weeklyData[0].date.toString().substring(5, 7);
    } else if (value == 1) {
      return widget.station.weeklyData[1].date.toString().substring(5, 7);
    } else if (value == 2) {
      return widget.station.weeklyData[2].date.toString().substring(5, 7);
    } else if (value == 3) {
      return widget.station.weeklyData[3].date.toString().substring(5, 7);
    } else if (value == 4) {
      return widget.station.weeklyData[4].date.toString().substring(5, 7);
    } else if (value == 5) {
      return widget.station.weeklyData[5].date.toString().substring(5, 7);
    } else if (value == 6) {
      return widget.station.weeklyData[6].date.toString().substring(5, 7);
    } else if (value == 7) {
      return widget.station.weeklyData[7].date.toString().substring(5, 7);
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
      weeklySpots = _generateWeeklySpots();
      maxY = _findMaxY();
      minY = _findMinY();
      weeklyMaxY = _findWeeklyMaxY();
      weeklyMinY = _findWeeklyMinY();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
      child: Column(
        children: <Widget>[..._chartChildren()],
      ),
    ));
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
            return _getWeeklyXTitles(value.toInt());
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
            return _getWeeklyYTitles(value.toInt());
          },
          reservedSize: 23,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: widget.station.weeklyData.length.toDouble() - 1,
      minY: weeklyMinY,
      maxY: weeklyMaxY,
      lineBarsData: [
        LineChartBarData(
          show: true,
          spots: weeklySpots,
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
}
