import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PerformanceDashboard extends StatefulWidget {
  final String username;

  PerformanceDashboard({required this.username});

  @override
  _PerformanceDashboardState createState() => _PerformanceDashboardState();
}

class _PerformanceDashboardState extends State<PerformanceDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Map<String, List<int>> data = {
    'Daily': [10, 4, 6],
    'Monthly': [180, 25, 40],
    'Yearly': [2000, 150, 300],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  String getResultLabel(int complete) {
    if (complete >= 1000) return "Best";
    if (complete >= 500) return "Good";
    if (complete >= 100) return "Average";
    return "Poor";
  }

  Color getResultColor(String label) {
    switch (label) {
      case "Best":
        return Colors.green;
      case "Good":
        return Colors.lightGreen;
      case "Average":
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  BarChartGroupData makeGroup(int x, double value, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(toY: value, width: 20, color: color, borderRadius: BorderRadius.circular(4)),
      ],
    );
  }

  Widget buildChart(String type) {
    final values = data[type]!;
    final labels = ["Complete", "Pending", "Assigned"];
    final colors = [Colors.green, Colors.orange, Colors.blue];
    final result = getResultLabel(values[0]);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Text(
            '$type Issue Performance',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 1.4,
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        return Text(index < labels.length ? labels[index] : '');
                      },
                    ),
                  ),
                ),
                barGroups: List.generate(
                  values.length,
                      (i) => makeGroup(i, values[i].toDouble(), colors[i]),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Performance Result: $result',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: getResultColor(result),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Short Description:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            '$type report shows ${values[0]} issues completed, ${values[1]} pending, and ${values[2]} assigned. Performance is rated as "$result".',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.username}",style: TextStyle(fontWeight: FontWeight.w600),),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Daily"),
            Tab(text: "Monthly"),
            Tab(text: "Yearly"),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildChart("Daily"),
          buildChart("Monthly"),
          buildChart("Yearly"),
        ],
      ),
    );
  }
}

// class PerformanceDashboard extends StatelessWidget {
//   final String username;
//
//   PerformanceDashboard({required this.username});
//
//   final List<BarChartGroupData> issueData = [
//     BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 10, color: Colors.green)]), // Complete
//     BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 4, color: Colors.orange)]), // Pending
//     BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 6, color: Colors.blue)]),   // Assigned
//   ];
//
//   String getResultLabel(int complete, int pending, int assigned) {
//     if (complete >= 10) return "Best";
//     if (complete >= 7) return "Good";
//     if (complete >= 4) return "Average";
//     return "Poor";
//   }
//
//   Color getResultColor(String label) {
//     switch (label) {
//       case "Best":
//         return Colors.green;
//       case "Good":
//         return Colors.lightGreen;
//       case "Average":
//         return Colors.orange;
//       default:
//         return Colors.red;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final int complete = 10, pending = 4, assigned = 6;
//     final result = getResultLabel(complete, pending, assigned);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("$username"),
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Daily Issue Performance',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             AspectRatio(
//               aspectRatio: 1.4,
//               child: BarChart(
//                 BarChartData(
//                   borderData: FlBorderData(show: false),
//                   titlesData: FlTitlesData(
//                     leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         getTitlesWidget: (value, meta) {
//                           switch (value.toInt()) {
//                             case 0:
//                               return Text("Complete");
//                             case 1:
//                               return Text("Pending");
//                             case 2:
//                               return Text("Assigned");
//                             default:
//                               return Text("");
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                   barGroups: issueData,
//                 ),
//               ),
//             ),
//             SizedBox(height: 30),
//             Text(
//               'Performance Result: $result',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: getResultColor(result),
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Short Description:',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               'Completed 10 issues today. 4 are still pending and 6 are newly assigned. Excellent performance!',
//               style: TextStyle(fontSize: 15),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }