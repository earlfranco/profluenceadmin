import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SignupRecords extends StatelessWidget {
  const SignupRecords({
    super.key,
    required this.monthlySignupCounts,
  });

  final Map<String, int> monthlySignupCounts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 320,
      child: AspectRatio(
        aspectRatio: 1.66,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final barsSpace = 4.0 * constraints.maxWidth / 100;
              final barsWidth = 8.0 * constraints.maxWidth / 140;

              return BarChart(
                BarChartData(
                  alignment: BarChartAlignment.center,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        String month;
                        switch (group.x.toInt()) {
                          case 0:
                            month = 'Jan';
                            break;
                          case 1:
                            month = 'Feb';
                            break;
                          case 2:
                            month = 'Mar';
                            break;
                          case 3:
                            month = 'Apr';
                            break;
                          case 4:
                            month = 'May';
                            break;
                          case 5:
                            month = 'Jun';
                            break;
                          case 6:
                            month = 'Jul';
                            break;
                          case 7:
                            month = 'Aug';
                            break;
                          case 8:
                            month = 'Sep';
                            break;
                          case 9:
                            month = 'Oct';
                            break;
                          case 10:
                            month = 'Nov';
                            break;
                          case 11:
                            month = 'Dec';
                            break;
                          default:
                            month = '';
                        }

                        return BarTooltipItem(
                          '$month\n${rod.toY.toInt()} signups',
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
                              text = 'Jan';
                              break;
                            case 1:
                              text = 'Feb';
                              break;
                            case 2:
                              text = 'Mar';
                              break;
                            case 3:
                              text = 'Apr';
                              break;
                            case 4:
                              text = 'May';
                              break;
                            case 5:
                              text = 'Jun';
                              break;
                            case 6:
                              text = 'Jul';
                              break;
                            case 7:
                              text = 'Aug';
                              break;
                            case 8:
                              text = 'Sep';
                              break;
                            case 9:
                              text = 'Oct';
                              break;
                            case 10:
                              text = 'Nov';
                              break;
                            case 11:
                              text = 'Dec';
                              break;
                            default:
                              text = '';
                              break;
                          }
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(text, style: style),
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
                  barGroups: List.generate(12, (index) {
                    String month;
                    switch (index) {
                      case 0:
                        month = 'Jan';
                        break;
                      case 1:
                        month = 'Feb';
                        break;
                      case 2:
                        month = 'Mar';
                        break;
                      case 3:
                        month = 'Apr';
                        break;
                      case 4:
                        month = 'May';
                        break;
                      case 5:
                        month = 'Jun';
                        break;
                      case 6:
                        month = 'Jul';
                        break;
                      case 7:
                        month = 'Aug';
                        break;
                      case 8:
                        month = 'Sep';
                        break;
                      case 9:
                        month = 'Oct';
                        break;
                      case 10:
                        month = 'Nov';
                        break;
                      case 11:
                        month = 'Dec';
                        break;
                      default:
                        month = '';
                    }

                    int signupCount = monthlySignupCounts[month] ?? 0;

                    return BarChartGroupData(
                      x: index,
                      barsSpace: barsSpace,
                      barRods: [
                        BarChartRodData(
                          toY: signupCount.toDouble(),
                          rodStackItems: [
                            BarChartRodStackItem(
                                0, signupCount.toDouble(), Colors.lightBlue),
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
}
