library pivot_table;

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PivotTable extends StatelessWidget {
  ///Create a [PivotTable] with [jsonData], [cols], [rows], [aggregatorName], [vals], [hiddenAttributes],[marginLabel]
  ///
  ///Example    PivotTable(
  ///    jsonData: jsonData,
  ///    cols: ["Region", "Product"],
  ///    rows: ["Customer"],
  ///    aggregatorName: AggregatorName.count,
  ///    vals: ["Sales"],
  ///  );
  ///
  ///

  const PivotTable(
      {required this.jsonData,
      this.cols,
      this.rows,
      required this.aggregatorName,
      required this.vals,
      this.hiddenAttributes,
      this.marginLabel = "Total"});
  final String jsonData;
  final List<String>? cols;
  final List<String>? rows;
  final String aggregatorName;
  final List<String> vals;
  final List<String>? hiddenAttributes;
  final String marginLabel;

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialData: InAppWebViewInitialData(
          data: html
              .replaceAll(
                RegExp(r'{JSON_DATA}'),
                jsonData,
              )
              .replaceAll(
                  RegExp(r'{HIDDEN_ATTRIBUTES}'),
                  hiddenAttributes == null
                      ? "[]"
                      : hiddenAttributes!.toFormattedString())
              .replaceAll(RegExp(r'{COLS}'),
                  cols == null ? "[]" : cols!.toFormattedString())
              .replaceAll(RegExp(r'{ROWS}'),
                  rows == null ? "[]" : rows!.toFormattedString())
              .replaceAll(RegExp(r'{AGGREGATOR_NAME}'), aggregatorName)
              .replaceAll(RegExp(r'{VALS}'), vals.toFormattedString())
              .replaceAll(RegExp(r'{MARGIN_LABEL}'), marginLabel)),
    );
  }
}

extension ListStringExtension on List<String> {
  String toFormattedString() {
    return '["${this.join('", "')}"]';
  }
}

String html = '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Ensures proper scaling on mobile devices -->
    <title>PivotTable.js with JSON</title>
    
    <!-- Link to C3.js styles -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.css">
    
    <!-- JavaScript libraries -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.5/d3.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    
    <!-- Include jQuery UI Touch Punch -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.3/jquery.ui.touch-punch.min.js"></script>
    
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/pivottable/2.19.0/pivot.min.css">
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pivottable/2.19.0/pivot.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pivottable/2.19.0/d3_renderers.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pivottable/2.19.0/c3_renderers.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pivottable/2.19.0/export_renderers.min.js"></script>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+Khmer:wght@100..900&display=swap" rel="stylesheet">
    
    <style>
        body {
            font-family: "Noto Serif Khmer", serif; /* Fallback to serif if the font fails to load */
        }
        /* Make the output container responsive */
        #output {
            overflow-x: auto; /* Enables horizontal scrolling on smaller screens */
        }
        /* Optional: You can add some padding */
        .pvtTable {
            margin: 0 auto; /* Center the table */
        }
    </style>
</head>
<body>
    <script type="text/javascript">
        \$(function(){
            const jsonData = {JSON_DATA}; // Placeholder for your JSON data

            \$("#output").pivotUI(
                jsonData,
                {
                    renderers: \$.extend(
                        \$.pivotUtilities.renderers,
                        \$.pivotUtilities.c3_renderers,
                        \$.pivotUtilities.d3_renderers,
                        \$.pivotUtilities.export_renderers
                    ),
                    hiddenAttributes: {HIDDEN_ATTRIBUTES}, // Placeholder for hidden attributes
                    
                    aggregatorName: "{AGGREGATOR_NAME}", // Placeholder for aggregator name
                    vals: {VALS}, // Placeholder for values
                    rows: {ROWS}, // Placeholder for rows
                    cols: {COLS}, // Placeholder for columns    
                    onRefresh: function(config) {
                        \$("th.pvtTotalLabel").each(function() {
                            \$(this).text("{MARGIN_LABEL}");
                        });
                    }
                }
            );
        });
    </script>
    
    <div id="output"></div> <!-- Output container for the PivotTable -->
</body>
</html>


''';

class AggregatorName {
  static const String sum = "Sum";
  static const String count = "Count";
  static const String avg = "Average";
  static const String max = "Max";
  static const String min = "Min";
}
