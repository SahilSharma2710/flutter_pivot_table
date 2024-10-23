import 'package:example/item_drag.dart';
import 'package:example/tab_taget_widget.dart';
import 'package:flutter/material.dart';
import 'package:pivot_table/aggregator_functions.dart';
import 'package:pivot_table/pivot_table.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pivot Table',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home Page Pivot Table'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String jsonString = '''
                             [
                              {"name": "Alice", "age": 30, "gender": "Female", "region": "North", "sales": 150, "cost": 100, "profit": 50, "products": "Electronics", "quarter": "Q1"},
                              {"name": "Bob", "age": 25, "gender": "Male", "region": "South", "sales": 200, "cost": 120, "profit": 80, "products": "Clothing", "quarter": "Q2"},
                              {"name": "Charlie", "age": 30, "gender": "Male", "region": "North", "sales": 100, "cost": 70, "profit": 30, "products": "Electronics", "quarter": "Q1"},
                              {"name": "David", "age": 25, "gender": "Male", "region": "West", "sales": 120, "cost": 80, "profit": 40, "products": "Furniture", "quarter": "Q3"},
                              {"name": "Eve", "age": 30, "gender": "Female", "region": "South", "sales": 300, "cost": 180, "profit": 120, "products": "Clothing", "quarter": "Q2"},
                              {"name": "Fay", "age": 25, "gender": "Female", "region": "West", "sales": 180, "cost": 100, "profit": 80, "products": "Electronics", "quarter": "Q3"},
                              {"name": "Grace", "age": 25, "gender": "Female", "region": "South", "sales": 170, "cost": 90, "profit": 80, "products": "Furniture", "quarter": "Q1"},
                              {"name": "Henry", "age": 28, "gender": "Male", "region": "East", "sales": 250, "cost": 150, "profit": 100, "products": "Groceries", "quarter": "Q2"},
                              {"name": "Isabella", "age": 27, "gender": "Female", "region": "West", "sales": 190, "cost": 110, "profit": 80, "products": "Clothing", "quarter": "Q3"},
                              {"name": "Jack", "age": 35, "gender": "Male", "region": "North", "sales": 300, "cost": 200, "profit": 100, "products": "Electronics", "quarter": "Q4"},
                              {"name": "Kathy", "age": 32, "gender": "Female", "region": "South", "sales": 120, "cost": 70, "profit": 50, "products": "Furniture", "quarter": "Q4"},
                              {"name": "Leo", "age": 29, "gender": "Male", "region": "East", "sales": 220, "cost": 130, "profit": 90, "products": "Groceries", "quarter": "Q1"},
                              {"name": "Mona", "age": 26, "gender": "Female", "region": "West", "sales": 160, "cost": 90, "profit": 70, "products": "Electronics", "quarter": "Q2"}
      ]
''';
  List<String> allFields = [
    'region',
    'products',
    'quarter',
    'age',
    'gender',
    'name',
    'profit'
  ];
  List<String> rowFields = [];
  List<String> columnFields = [];
  void changeField(data, List<String> type) {
    if (rowFields.contains(data))
      rowFields.remove(data);
    else if (columnFields.contains(data))
      columnFields.remove(data);
    else if (allFields.contains(data)) allFields.remove(data);
    if (!type.contains(data)) {
      type.add(data);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabTagetWidget(
                child: Row(
                  children: [
                    ...allFields.map((e) {
                      return DraggableWidget(data: e);
                    }).toList(),
                  ],
                ),
                title: "Fields",
                onAccept: (data) {
                  changeField(data, allFields);
                },
                width: double.infinity,
                height: 80),
            TabTagetWidget(
                child: Row(
                  children: [
                    ...columnFields.map((e) {
                      return DraggableWidget(data: e);
                    }).toList(),
                  ],
                ),
                title: "Columns",
                color: Colors.green,
                onAccept: (data) {
                  changeField(data, columnFields);
                },
                width: double.infinity,
                height: 80),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabTagetWidget(
                    child: Column(
                      children: [
                        ...rowFields.map((e) {
                          return DraggableWidget(data: e);
                        }).toList(),
                      ],
                    ),
                    color: Colors.blue,
                    title: "Rows",
                    onAccept: (data) {
                      changeField(data, rowFields);
                    },
                    width: 150,
                    height: 400),
                Flexible(
                  child: PivotTable(
                    marginname: 'Total Profit',
                    jsonString: jsonString,
                    rowFields: rowFields,
                    columnFields: columnFields,
                    valueFields: ['profit'],
                    valueAggregator: AggregatorFunctions.sumAggregator,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
