# Pivot Table for Flutter

A Flutter package for creating customizable pivot tables with support for data aggregation, sorting, filtering, and grouping. This package is ideal for displaying and analyzing large datasets in a structured way.

![Desktop Pivot Table Demo](doc/desktop_pivottable.gif)
![Mobile Pivot Table Demo](doc/mobile_pivottable.gif)
![Web Pivot Table Demo](doc/mobile_pivottable.gif)

## Features

- Dynamic data pivoting based on rows and columns
- can use with string of json array
- Support for aggregation functions like sum, count.
- Customizable cell renderers and formatting

## Getting Started

### Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  pivot_table:
    git:
      url: https://github.com/BoyPhanna/flutter_pivot_table.git
```

### Example Code

Add the following to your `main.dart` file:

```dart
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
];
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
          padding: EdgeInsets.only(top: 30),
          child: PivotTable(
            jsonData: jsonData,
            hiddenAttributes: ["Date", "Quantity"],
            // cols: ["Region", "Product"],
            // rows: ["Customer"],
            aggregatorName: AggregatorName.count,
            vals: ["Sales"],
            marginLabel: "Total",
          ),
        ),
      ),
    );
  }
}


```
