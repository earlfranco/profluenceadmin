import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DialyLogin extends StatelessWidget {
  const DialyLogin({
    super.key,
    required this.dailyLoginCounts,
  });

  final Map<String, int> dailyLoginCounts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 320,
      child: AspectRatio(
        aspectRatio: 0.66,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final barsSpace = 4.0 * constraints.maxWidth / 100;
              final barsWidth = 8.0 * constraints.maxWidth / 100;

              return BarChart(
                BarChartData(
                  alignment: BarChartAlignment.center,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        String day;
                        switch (group.x.toInt()) {
                          case 0:
                            day = 'Mon';
                            break;
                          case 1:
                            day = 'Tue';
                            break;
                          case 2:
                            day = 'Wed';
                            break;
                          case 3:
                            day = 'Thu';
                            break;
                          case 4:
                            day = 'Fri';
                            break;
                          case 5:
                            day = 'Sat';
                            break;
                          case 6:
                            day = 'Sun';
                            break;
                          default:
                            day = '';
                        }
                        return BarTooltipItem(
                          '$day\n${rod.toY.toInt()} logins',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          const style =
                              TextStyle(fontSize: 10, color: Colors.white);
                          String text;
                          switch (value.toInt()) {
                            case 0:
                              text = 'Mon';
                              break;
                            case 1:
                              text = 'Tue';
                              break;
                            case 2:
                              text = 'Wed';
                              break;
                            case 3:
                              text = 'Thu';
                              break;
                            case 4:
                              text = 'Fri';
                              break;
                            case 5:
                              text = 'Sat';
                              break;
                            case 6:
                              text = 'Sun';
                              break;
                            default:
                              text = '';
                              break;
                          }
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              text,
                              style: style,
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          if (value == meta.max) {
                            return Container();
                          }
                          const style =
                              TextStyle(fontSize: 10, color: Colors.white);
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              meta.formattedValue,
                              style: style,
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    checkToShowHorizontalLine: (value) => value % 1 == 0,
                    getDrawingHorizontalLine: (value) => const FlLine(
                      color: Colors.white,
                      strokeWidth: 1,
                    ),
                    drawVerticalLine: false,
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  groupsSpace: barsSpace,
                  barGroups: List.generate(7, (index) {
                    String day;
                    switch (index) {
                      case 0:
                        day = 'Mon';
                        break;
                      case 1:
                        day = 'Tue';
                        break;
                      case 2:
                        day = 'Wed';
                        break;
                      case 3:
                        day = 'Thu';
                        break;
                      case 4:
                        day = 'Fri';
                        break;
                      case 5:
                        day = 'Sat';
                        break;
                      case 6:
                        day = 'Sun';
                        break;
                      default:
                        day = '';
                    }

                    int loginCount = dailyLoginCounts[day] ?? 0;

                    return BarChartGroupData(
                      x: index,
                      barsSpace: barsSpace,
                      barRods: [
                        BarChartRodData(
                          toY: loginCount.toDouble(),
                          rodStackItems: [
                            BarChartRodStackItem(0, loginCount.toDouble(),
                                differentcolor(loginCount.toDouble())),
                          ],
                          borderRadius: BorderRadius.zero,
                          width: barsWidth,
                        ),
                      ],
                    );
                  }),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Color differentcolor(double loginCount) {
    if (loginCount < 2) {
      return Colors.lightBlue;
    } else if (loginCount <= 15) {
      return const Color(0xff33FD41);
    } else if (loginCount >= 10) {
      return const Color(0xffFE32F0);
    } else if (loginCount >= 22) {
      return const Color(0xff6318FA);
    } else {
      return const Color(0xffFDB900);
    }
  }
}
