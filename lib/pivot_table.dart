import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PivotTable extends StatelessWidget {
  const PivotTable({
    Key? key,
    required this.jsonData,
    this.cols,
    this.rows,
    required this.aggregatorName,
    required this.vals,
    this.hiddenAttributes,
    this.marginLabel = "Total",
    this.rendererName = "Table",
  }) : super(key: key);
  final String rendererName;
  final String jsonData;
  final List<String>? cols;
  final List<String>? rows;
  final String aggregatorName;
  final List<String> vals;
  final List<String>? hiddenAttributes;
  final String marginLabel;
//loadPivotTable(data,hiddenAttributes,aggregatorName,vals,rows,cols,marginLabel)
  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialFile: "packages/pivot_table/assets/index.html",
      initialSettings: InAppWebViewSettings(iframeName: "flutter_inappwebview"),
      onWebViewCreated: (controller) async {},
      onLoadStop: (InAppWebViewController controller, url) async {
        await controller.evaluateJavascript(source: """
            loadPivotTable(
              $jsonData,
              ${hiddenAttributes == null ? [] : hiddenAttributes?.toFormattedString()},
              "$aggregatorName",
              ${vals.toFormattedString()},
              ${rows == null ? [] : rows!.toFormattedString()},
              ${cols == null ? [] : cols!.toFormattedString()},
              "$marginLabel",
              "$rendererName"
            );
          """);
      },
    );
  }
}

extension ListStringExtension on List<String> {
  String toFormattedString() {
    return '["${join('", "')}"]';
  }
}

class AggregatorName {
  static const String sum = "Sum";
  static const String count = "Count";
  static const String avg = "Average";
  static const String max = "Maximum";
  static const String min = "Minimum";
}

class RendererName {
  static const String table = "Table";
  static const String tableBarchart = "Table Barchart";
  static const String heatmap = "Heatmap";
  static const String rowHeatmap = "Row Heatmap";
  static const String colHeatmap = "Col Heatmap";
  static const String horizontalBarChart = "Horizontal Bar Chart";
  static const String barChart = "Bar Chart";
  static const String lineChart = "Line Chart";
  static const String areaChart = "Area Chart";
}
