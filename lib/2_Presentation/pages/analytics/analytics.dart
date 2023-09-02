import 'package:coinpulse2/2_Presentation/bloc/bill_bloc.dart';
import 'package:coinpulse2/2_Presentation/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsWrapper extends StatelessWidget {
  const AnalyticsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BillBloc(),
      child: const Analytics(),
    );
  }
}

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  void initState() {
    super.initState();
    context.read<BillBloc>().add(RetrieveBill());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coin Pulse'),
      ),
      body: BlocBuilder<BillBloc, BillState>(
        builder: (context, state) {
          if (state is BillRetrieving) {
            final amount = state.billRetrievedData
                .map((bill) => double.parse(bill.amount))
                .toList();
            final category =
                state.billRetrievedData.map((bill) => bill.title).toList();

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: <ChartSeries>[
                  ColumnSeries<ChartData, String>(
                      dataSource: _generateChartData(category, amount),
                      xValueMapper: (ChartData data, _) => data.category,
                      yValueMapper: (ChartData data, _) => data.amount,
                      color: ColorsUsed.primaryColor),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// List<ChartData> _generateChartData(List<BillData> billData, Map<String, double> cumulativeTotals) {
//   final List<ChartData> chartData = [];

//   for (final bill in billData) {
//     final category = bill.title;
//     final amount = bill.amount;

//     // Initialize cumulative total if it's not in the map
//     cumulativeTotals[category] ??= 0;

//     // Calculate cumulative total for the current category
//     cumulativeTotals[category] += amount;

//     // Create chart data with the cumulative total
//     chartData.add(ChartData(category, cumulativeTotals[category]!));
//   }

//   return chartData;
// }

class BillData {
  final String title;
  final double amount;

  BillData(this.title, this.amount);
}

List<ChartData> _generateChartData(
    List<String> categories, List<double> amounts) {
  final List<ChartData> chartData = [];

  for (int i = 0; i < categories.length; i++) {
    chartData.add(ChartData(categories[i], amounts[i]));
  }

  return chartData;
}

class ChartData {
  final String category;
  final double amount;

  ChartData(this.category, this.amount);
}
