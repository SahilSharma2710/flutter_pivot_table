import 'package:flutter/material.dart';
import 'package:pivot_table/pivot_table.dart';

String jsonData = '''
[
                {"Region": "North", "Product": "Laptop", "Sales": 1100, "Date": "2023-10-01", "Quantity": 5, "Customer": "01235667477 sfhsfslf", "Discount": 10},
                {"Region": "North", "Product": "Laptop", "Sales": 1100, "Date": "2023-10-01", "Quantity": 5, "Customer": "ABC3", "Discount": 10},
                {"Region": "North", "Product": "Tablet", "Sales": 350, "Date": "2023-10-02", "Quantity": 2, "Customer": "ABC", "Discount": 5},
                {"Region": "South", "Product": "Laptop", "Sales": 550, "Date": "2023-10-03", "Quantity": 3, "Customer": "LMN Inc", "Discount": 0},
                {"Region": "South", "Product": "Tablet", "Sales": 0, "Date": "2023-10-04", "Quantity": 0, "Customer": "ABC", "Discount": 0},
                {"Region": "West", "Product": "Smartphone", "Sales": 750, "Date": "2023-10-05", "Quantity": 4, "Customer": "AB", "Discount": 15},
                {"Region": "កម្ពុជា", "Product": "Monitor", "Sales": 500, "Date": "2023-10-06", "Quantity": 2, "Customer": "AB", "Discount": 7}
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
            hiddenAttributes: const ["Date", "Quantity"],
            cols: const ["Region", "Product"],
            rows: const ["Customer"],
            aggregatorName: AggregatorName.sum,
            vals: const ["Sales"],
            marginLabel: "Total",
            rendererName: RendererName.tableBarchart,
          ),
        ),
      ),
    );
  }
}
