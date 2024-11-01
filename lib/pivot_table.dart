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
  }) : super(key: key);

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
            console.log('Hello');
            loadPivotTable(
              $jsonData,
              ${hiddenAttributes?.toFormattedString()},
              "$aggregatorName",
              ${vals.toFormattedString()},
              ${rows == null ? "[]" : rows!.toFormattedString()},
              ${cols == null ? "[]" : cols!.toFormattedString()},
              "$marginLabel"
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
  static const String max = "Max";
  static const String min = "Min";
}
