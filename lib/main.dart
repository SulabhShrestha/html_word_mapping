import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
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

  AudioHandler handler = AudioHandler("ad.mp3");

  final ValueNotifier _htmlModified = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();

    _htmlModified.value = widget.html;

    handler.onProgress.listen((event) {
      debugPrint("event: $event");

      _htmlModified.value = hightlight(event);
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                if (handler.audioPlayer.state == PlayerState.playing) {
                  handler.pause();
                } else {
                  handler.play();
                }
              },
              child: Text('Play Audio'),
            ),
            ValueListenableBuilder(
                valueListenable: _htmlModified,
                builder: (_, html, __) {
                  return HtmlWidget(
                    html,
                    customStylesBuilder: (element) {
                      if (element.classes.contains('highlight')) {
                        return {'background-color': 'red'};
                      }

                      return null;
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }

  hightlight(Duration audioCurrentTimestamp) {
    var document = parser
        .parse(widget.html); // This line is added to parse the HTML string
    var mappedItems = document.querySelectorAll('ag-mapped-word');

    mappedItems.forEach((elem) {
      var elemTimestamp = elem.attributes['time_stamp'];

      if (elemTimestamp != null) {
        if (audioCurrentTimestamp.inMilliseconds / 1000 >=
            double.parse(elemTimestamp)) {
          debugPrint("elem: ${double.parse(elemTimestamp)}, ${audioCurrentTimestamp.inMicroseconds / 1000}");
          elem.classes.add("highlight");
        }
        else{
          elem.classes.remove("highlight");
        }
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
        <p class="tw-text-center tw-break-words">
          <ag-mapped-word
            id="mapped-word-4"
            tabindex="4"
            class=""
            time_stamp="1.79844"
            >बुद्ध</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-5"
            tabindex="5"
            class=""
            time_stamp="1.79844"
            >बने,
          </ag-mapped-word>
        </p>
        <p class="tw-text-center tw-break-words">
          <ag-mapped-word
            id="mapped-word-6"
            tabindex="6"
            class=""
            time_stamp="3.408571"
            >क्रायिष्टले</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-7"
            tabindex="7"
            class=""
            time_stamp="3.941572"
            >थाहा</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-8"
            tabindex="8"
            class=""
            time_stamp="5.264789"
            >पाएर</ag-mapped-word
          >
        </p>
        <p class="tw-text-center tw-break-words">
          <ag-mapped-word
            id="mapped-word-9"
            tabindex="9"
            class=""
            time_stamp="6.06195"
            >क्रायिष्ट</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-10"
            tabindex="10"
            class=""
            time_stamp="7.391293"
            >बने</ag-mapped-word
          >
        </p>
        <p class="tw-text-center tw-break-words">
          <ag-mapped-word
            id="mapped-word-11"
            tabindex="11"
            class=""
            time_stamp="7.971502"
            >संसारका</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-12"
            tabindex="12"
            class=""
            time_stamp="8.546485"
            >सब</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-13"
            tabindex="13"
            class=""
            time_stamp="9.080544"
            >मानिस</ag-mapped-word
          >
        </p>
        <p class="tw-text-center tw-break-words">
          <ag-mapped-word
            id="mapped-word-14"
            tabindex="14"
            class=""
            time_stamp="9.874121"
            >थाहाका</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-15"
            tabindex="15"
            class=""
            time_stamp="10.137052"
            >उपज</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-16"
            tabindex="16"
            class=""
            time_stamp="11.512834"
            >हुन्,</ag-mapped-word
          >
        </p>
        <p class="tw-text-center tw-break-words">
          <ag-mapped-word
            id="mapped-word-17"
            tabindex="17"
            class=""
            time_stamp="12.064308"
            >सप्रेको</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-18"
            tabindex="18"
            class=""
            time_stamp="12.590718"
            >देश</ag-mapped-word
          >
        </p>
        <p class="tw-text-center tw-break-words">
          <ag-mapped-word
            id="mapped-word-19"
            tabindex="19"
            class=""
            time_stamp="12.857527"
            >थाहा</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-20"
            tabindex="20"
            class=""
            time_stamp="13.438208"
            >पाएर</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-21"
            tabindex="21"
            class=""
            time_stamp="14.763628"
            >सप्रे,</ag-mapped-word
          >
        </p>
        <p class="tw-text-center tw-break-words">
          <ag-mapped-word
            id="mapped-word-22"
            tabindex="22"
            class=""
            time_stamp="15.342759"
            >बिग्रेका</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-23"
            tabindex="23"
            class=""
            time_stamp="15.875927"
            >देश
          </ag-mapped-word>
        </p>
        <p class="tw-text-center tw-break-words">
          <ag-mapped-word
            id="mapped-word-24"
            tabindex="24"
            class=""
            time_stamp="16.688679"
            >भ्रममा</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-25"
            tabindex="25"
            class=""
            time_stamp="16.957456"
            >परेर</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-26"
            tabindex="26"
            class=""
            time_stamp="18.309356"
            >बिग्रे
          </ag-mapped-word>
        </p>
        <p class="tw-text-center tw-break-words">
          <ag-mapped-word
            id="mapped-word-27"
            tabindex="27"
            class=""
            time_stamp="18.842138"
            >भ्रमैभ्रममा</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-28"
            tabindex="28"
            class=""
            time_stamp="20.173878"
            >बाँचेर</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-29"
            tabindex="29"
            class=""
            time_stamp="20.440907"
            >बिग्रेको
          </ag-mapped-word>
        </p>
        <p class="tw-text-center tw-break-words">
          <ag-mapped-word
            id="mapped-word-30"
            tabindex="30"
            class=""
            time_stamp="20.707937"
            >यो</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-31"
            tabindex="31"
            class=""
            time_stamp="21.497415"
            >देशको</ag-mapped-word
          >
        </p>
        <p class="tw-text-center tw-break-words">
          <ag-mapped-word
            id="mapped-word-32"
            tabindex="32"
            class=""
            time_stamp="22.031186"
            >एउटा</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-33"
            tabindex="33"
            class=""
            time_stamp="22.297294"
            >नागरिक</ag-mapped-word
          ><ag-mapped-word
            id="mapped-word-34"
            tabindex="34"
            class=""
            time_stamp="23.389457"
            >तपाईं</ag-mapped-word
          >
        </p>
        <p class="tw-text-center tw-break-words">
          <ag-mapped-word
            id="mapped-word-35"
            tabindex="35"
            class=""
            time_stamp="23.9239"
            >थाहा</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-36"
            tabindex="36"
            class=""
            time_stamp="24.724762"
            >पाउनुस्,
          </ag-mapped-word>
        </p>
        <p class="tw-text-center tw-break-words">
          <ag-mapped-word
            id="mapped-word-37"
            tabindex="37"
            class=""
            time_stamp="25.514467"
            >देश</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-38"
            tabindex="38"
            class=""
            time_stamp="25.779274"
            >सप्रिन</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-39"
            tabindex="39"
            class=""
            time_stamp="26.309751"
            >थालिहाल्छ</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-40"
            tabindex="40"
            class=""
            time_stamp="26.026305"
            >।</ag-mapped-word
          >
        </p>
        <p class="tw-text-center tw-break-words">
          <b
            ><ag-mapped-word id="mapped-word-41" tabindex="41" class=""
              >–</ag-mapped-word
            >
            <ag-mapped-word
              id="mapped-word-42"
              tabindex="42"
              class=""
              time_stamp="28.440181"
              >रूदाने</ag-mapped-word
            >
            <ag-mapped-word
              id="mapped-word-43"
              tabindex="43"
              class=""
              time_stamp="29.516632"
              >(</ag-mapped-word
            >
            <ag-mapped-word
              id="mapped-word-44"
              tabindex="44"
              class=""
              time_stamp="29.763719"
              >टंक</ag-mapped-word
            >
            <ag-mapped-word
              id="mapped-word-45"
              tabindex="45"
              class=""
              time_stamp="30.088798"
              >चौलागाईं</ag-mapped-word
            >
            <ag-mapped-word
              id="mapped-word-46"
              tabindex="46"
              class=""
              time_stamp="30.314467"
              >)</ag-mapped-word
            ></b
          >
        </p>
        <h1 class="tw-text-center">
          <ag-mapped-word
            id="mapped-word-47"
            tabindex="47"
            class=""
            time_stamp="34.647075"
            >सिङ</ag-mapped-word
          >
        </h1>
        <p class="tw-text-left tw-break-words">
          <ag-mapped-word id="mapped-word-48" tabindex="48" class="">
          </ag-mapped-word>
          <ag-mapped-word id="mapped-word-49" tabindex="49" class="">
          </ag-mapped-word>
          <ag-mapped-word
            id="mapped-word-50"
            tabindex="50"
            class=""
            time_stamp="39.168823"
          >
            कालो</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-51"
            tabindex="51"
            class=""
            time_stamp="39.435021"
            >टोपीमा</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-52"
            tabindex="52"
            class=""
            time_stamp="39.958639"
            >दुईओटा</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-53"
            tabindex="53"
            class=""
            time_stamp="40.272109"
            >सिन्का</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-54"
            tabindex="54"
            class=""
            time_stamp="40.840998"
            >बाधेँ</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-55"
            tabindex="55"
            class=""
            time_stamp="41.375057"
            >।</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-56"
            tabindex="56"
            class=""
            time_stamp="41.909116"
            >आकाशतिर</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-57"
            tabindex="57"
            class=""
            time_stamp="42.430449"
            >फर्किएका</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-58"
            tabindex="58"
            class=""
            time_stamp="42.696807"
            >ठाडा</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-59"
            tabindex="59"
            class=""
            time_stamp="42.965375"
            >ठाडा</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-60"
            tabindex="60"
            class=""
            time_stamp="43.226848"
            >थिए</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-61"
            tabindex="61"
            class=""
            time_stamp="43.511293"
            >ती</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-62"
            tabindex="62"
            class=""
            time_stamp="44.055772"
            >।</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-63"
            tabindex="63"
            class=""
            time_stamp="45.390468"
            >टोपीको</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-64"
            tabindex="64"
            class=""
            time_stamp="45.651811"
            >दायाँबायाँ</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-65"
            tabindex="65"
            class=""
            time_stamp="46.181587"
            >लामा</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-66"
            tabindex="66"
            class=""
            time_stamp="46.448617"
            >लामा</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-67"
            tabindex="67"
            class=""
            time_stamp="46.715646"
            >दुईओटा</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-68"
            tabindex="68"
            class=""
            time_stamp="46.976871"
            >सिन्का</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-69"
            tabindex="69"
            class=""
            time_stamp="47.509404"
            >।</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-70"
            tabindex="70"
            class=""
            time_stamp="48.801088"
            >टोपी</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-71"
            tabindex="71"
            class=""
            time_stamp="49.323537"
            >लगाउँदा</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-72"
            tabindex="72"
            class=""
            time_stamp="50.124451"
            >ती</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-73"
            tabindex="73"
            class=""
            time_stamp="50.39016"
            >ठ्याक्कै</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-74"
            tabindex="74"
            class=""
            time_stamp="50.983764"
            >कानको</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-75"
            tabindex="75"
            class=""
            time_stamp="51.250794"
            >छेउ</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-76"
            tabindex="76"
            class=""
            time_stamp="51.859676"
            >छेउमा</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-77"
            tabindex="77"
            class=""
            time_stamp="52.654985"
            >पर्थे</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-78"
            tabindex="78"
            class=""
            time_stamp="53.187542"
            >।</ag-mapped-word
          >
        </p>
        <p class="tw-text-left tw-break-words">
          <ag-mapped-word
            id="mapped-word-79"
            tabindex="79"
            class=""
            time_stamp="54.251973"
          >
          </ag-mapped-word>
          <ag-mapped-word
            id="mapped-word-80"
            tabindex="80"
            class=""
            time_stamp="54.582857"
          >
          </ag-mapped-word>
          <ag-mapped-word
            id="mapped-word-81"
            tabindex="81"
            class=""
            time_stamp="54.836949"
          >
            ‘केटाको</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-82"
            tabindex="82"
            class=""
            time_stamp="55.093696"
            >लामो</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-83"
            tabindex="83"
            class=""
            time_stamp="55.093696"
            >लामो</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-84"
            tabindex="84"
            class=""
            time_stamp="55.383946"
            >सिङ</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-85"
            tabindex="85"
            class=""
            time_stamp="55.383946"
            >पलाएछ</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-86"
            tabindex="86"
            class=""
            time_stamp="56.463673"
            >!’</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-87"
            tabindex="87"
            class=""
            time_stamp="56.736389"
            >गोबर</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-88"
            tabindex="88"
            class=""
            time_stamp="57.088279"
            >सोहोरेको</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-89"
            tabindex="89"
            class=""
            time_stamp="57.42502"
            >हात</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-90"
            tabindex="90"
            class=""
            time_stamp="57.937417"
            >पखाल्दै</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-91"
            tabindex="91"
            class=""
            time_stamp="58.470342"
            >दिदीले</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-92"
            tabindex="92"
            class=""
            time_stamp="59.000454"
            >जिस्क्याइन्</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-93"
            tabindex="93"
            class=""
            time_stamp="59.800003"
            >।</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-94"
            tabindex="94"
            class=""
            time_stamp="60.85805"
            >‘टाउकोमा</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-95"
            tabindex="95"
            class=""
            time_stamp="61.658043"
            >घाँस</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-96"
            tabindex="96"
            class=""
            time_stamp="61.920363"
            >कसरी</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-97"
            tabindex="97"
            class=""
            time_stamp="62.222222"
            >उमारिस्</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-98"
            tabindex="98"
            class=""
            time_stamp="62.800431"
            >?’</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-99"
            tabindex="99"
            class=""
            time_stamp="64.21807"
            >हात</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-100"
            tabindex="100"
            class=""
            time_stamp="64.483277"
            >धोइसकेपछि</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-101"
            tabindex="101"
            class=""
            time_stamp="64.786943"
            >टोपी</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-102"
            tabindex="102"
            class=""
            time_stamp="65.093647"
            >निकालेर</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-103"
            tabindex="103"
            class=""
            time_stamp="65.876788"
            >हेरिन्</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-104"
            tabindex="104"
            class=""
            time_stamp="66.401814"
            >।</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-105"
            tabindex="105"
            class=""
            time_stamp="67.735069"
            >जिस्क्याएर</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-106"
            tabindex="106"
            class=""
            time_stamp="68.286179"
            >हाँसिन्</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-107"
            tabindex="107"
            class=""
            time_stamp="68.816351"
            >।</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-108"
            tabindex="108"
            class=""
            time_stamp="69.873197"
            >म</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-109"
            tabindex="109"
            class=""
            time_stamp="70.140227"
            >पनि</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-110"
            tabindex="110"
            class=""
            time_stamp="70.406774"
            >हाँसेँ</ag-mapped-word
          >
          <ag-mapped-word
            id="mapped-word-111"
            tabindex="111"
            class=""
            time_stamp="70.673007"
            >।</ag-mapped-word
          >
        </p>
</div>
''';
