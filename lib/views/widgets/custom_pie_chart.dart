import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPieChartData {
  final String label;
  final double value;

  CustomPieChartData({required this.label, required this.value});
}

class CustomPieChart extends StatefulWidget {
  final List<CustomPieChartData> data;
  final Function(int)? onTouched;

  const CustomPieChart({super.key, required this.data, this.onTouched});
  @override
  State<StatefulWidget> createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<CustomPieChart> {
  List<Color> randomColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.indigoAccent,
    Colors.purple,
    Colors.grey,
  ];

  int touchIndex = -1;
  double totalAmount = 12000;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 6,
              child: SizedBox(
                width: 200,
                height: 200,
                child: PieChart(
                  curve: Curves.easeInSine,
                  duration: const Duration(milliseconds: 10),
                  PieChartData(
                    titleSunbeamLayout: true,
                    centerSpaceRadius: 40,
                    sectionsSpace: 0.5,
                    sections: widget.data.asMap().entries.map(
                      (mapentry) {
                        return PieChartSectionData(
                          value: mapentry.value.value,
                          color:
                              randomColors[mapentry.key % randomColors.length],
                          title:
                              "${((mapentry.value.value / totalAmount) * 100).toStringAsFixed(0)} %",
                          radius: touchIndex == mapentry.key ? 45 : 40,
                          titleStyle: const TextStyle(
                            fontSize: 10,
                          ),
                        );
                      },
                    ).toList(),
                    pieTouchData: PieTouchData(
                      touchCallback: (touchEvent, touchResponse) {
                        var touchIndex =
                            touchResponse?.touchedSection?.touchedSectionIndex;
                        setState(
                          () {
                            this.touchIndex = touchIndex ?? -1;
                          },
                        );
                        widget.onTouched?.call(this.touchIndex);
                      },
                    ),
                  ),
                ),
              ),
            ),
            //Spacer(flex: 1,),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.data.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        ColoredBox(
                          color: randomColors[index],
                          child: const SizedBox(height: 10, width: 10),
                        ),
                        Text(
                          " ${widget.data[index].label}",
                          style: TextStyle(
                              fontWeight: touchIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        Text((touchIndex != -1 ? widget.data[touchIndex].value.toStringAsFixed(2) : ""))
      ],
    );
  }
}
