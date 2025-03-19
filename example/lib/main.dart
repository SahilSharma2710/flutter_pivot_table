import 'package:flutter/material.dart';
import 'package:pivot_table/pivot_table.dart';

String jsonData = '''
[
  {"SL": "1", "Mon": "2025-Jan", "Qtr": "04Qtr-2024", "Date": "1/1/25", "Organization": "Projense", "Location": "Nagpur", "SKU Group": "Monitor", "SKUs": "Keyboard", "Server Type-1": 100, "Server Type-2": 150, "Server Type-3": 250, "Server Type-4": 340},
  {"SL": "2", "Mon": "2025-Jan", "Qtr": "04Qtr-2024", "Date": "1/5/25", "Organization": "Projense", "Location": "Amrawati", "SKU Group": "Monitor", "SKUs": "Mouse", "Server Type-1": 50, "Server Type-2": 55, "Server Type-3": 45, "Server Type-4": 38},
  {"SL": "3", "Mon": "2024-Dec", "Qtr": "04Qtr-2024", "Date": "12/12/24", "Organization": "Projense", "Location": "Delhi", "SKU Group": "Monitor", "SKUs": "Monitor", "Server Type-1": 2500, "Server Type-2": 4500, "Server Type-3": 8500, "Server Type-4": 10200},
  {"SL": "4", "Mon": "2024-Jan", "Qtr": "01Qtr-2024", "Date": "1/30/24", "Organization": "Projense", "Location": "Nagpur", "SKU Group": "Monitor", "SKUs": "Mouse-Pad", "Server Type-1": 75, "Server Type-2": 125, "Server Type-3": 6500, "Server Type-4": 210},
  {"SL": "5", "Mon": "2024-Mar", "Qtr": "01Qtr-2024", "Date": "3/31/24", "Organization": "Projense", "Location": "Amrawati", "SKU Group": "CUP", "SKUs": "CPU", "Server Type-1": 8000, "Server Type-2": 9500, "Server Type-3": 15000, "Server Type-4": 25000},
  {"SL": "6", "Mon": "2024-May", "Qtr": "2Qtr-2024", "Date": "5/31/24", "Organization": "Projense", "Location": "Delhi", "SKU Group": "CUP", "SKUs": "UPS", "Server Type-1": 780, "Server Type-2": 1280, "Server Type-3": 4580, "Server Type-4": 2514}
]
''';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: PivotTable(
            jsonData: jsonData,
            hiddenAttributes: const [
              "SL",
              "Date",
              "SKU Group",
              "SKUs",
              "Server Type-2",
              "Server Type-3",
              "Server Type-4"
            ],
            cols: const ["Organization"],
            rows: const ["Mon", "Qtr"],
            aggregatorName: AggregatorName.sum,
            vals: const [
              "Server Type-1",
            ],
            marginLabel: "Total",
            rendererName: RendererName.table,
          ),
        ),
      ),
    );
  }
}
