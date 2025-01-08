import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:html/parser.dart' as parser;
import 'package:html_parser_audio/audio_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HtmlView(
        html: htmls,
      ),
    );
  }
}

class HtmlView extends StatefulWidget {
  final String html;
  const HtmlView({
    super.key,
    required this.html,
  });

  @override
  State<HtmlView> createState() => _HtmlViewState();
}

class _HtmlViewState extends State<HtmlView> {
  String changedHtml = '';

  AudioHandler handler = AudioHandler("assets/ad.mp3");

  @override
  void initState() {
    super.initState();


    handler.onProgress.listen((event) {
    changedHtml = hightlight(event) ?? '';
     
    });

    log(changedHtml);
  }

  @override
  Widget build(BuildContext context) {
    // log("itm: $mappedItems, ${}");

    return Scaffold(
      appBar: AppBar(
        title: Text('HTML Parser Example'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              handler.play();
            },
            child: Text('Play Audio'),
          ),
          Expanded(
            child: HtmlWidget(
              changedHtml,
              customStylesBuilder: (element) {
                if (element.classes.contains('highlight')) {
                  return {'background-color': 'red'};
                }

                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  hightlight(Duration audioCurrentTimestamp) {
    var document = parser
        .parse(widget.html); // This line is added to parse the HTML string
    var mappedItems = document.querySelectorAll('ag-mapped-word');

    mappedItems.forEach((elem) {
      var elemTimestamp = elem.attributes['time_stamp'];

      if(audioCurrentTimestamp.inMilliseconds >= int.parse(elemTimestamp!)) {
      elem.classes.add("highlight");

      }
    });
    return document.body?.innerHtml;
  }
}

String htmls = '''
<div>
    <p class="tw-text-center tw-break-words">
        <ag-mapped-word id="mapped-word-1" tabindex="1" class=""
            time_stamp="0.645034">बुद्धले</ag-mapped-word> <ag-mapped-word id="mapped-word-2" tabindex="2" class=""
            time_stamp="1.26652">थाहा</ag-mapped-word> <ag-mapped-word id="mapped-word-3" tabindex="3" class=""
            time_stamp="1.532405">पाएर</ag-mapped-word>
        </p>
</div>
''';
