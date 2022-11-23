import 'dart:convert';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';

const String reweBaseUrl = 'https://www.rewe.de';
const String reweCouponsPath = '/service/app-couponing/';
const String ocrApiKey = String.fromEnvironment('OCR_API_KEY');
const String ocrApiUri =
    'https://api.ocr.space/parse/imageurl?apikey=$ocrApiKey&url=';
const String scrapingBeeApiKey = String.fromEnvironment('SCRAPING_BEE_API_KEY');
const String scrapingBeeUri =
    'https://app.scrapingbee.com/api/v1/?api_key=$scrapingBeeApiKey&url=$reweBaseUrl$reweCouponsPath';

Future<List<Map<String, String>>> scrapeCoupons() async {
  final List<Map<String, String>> coupons = [];

  try {
    Response response = await get(Uri.parse(scrapingBeeUri));
    Document document = parse(response.body);

    print('Response HTTP Status Code: ${response.statusCode}');

    List<Element> couponContainers = document
        .getElementsByClassName('payback-product-teaser__tile-container');

    for (var couponContainer in couponContainers) {
      String title =
          couponContainer.getElementsByClassName('teaser-content')[0].text;
      String? imageUrl =
          couponContainer.getElementsByTagName('img')[0].attributes['data-src'];
      coupons.add({
        'title': formatProductName(title),
        'price': await readPriceFromImage(reweBaseUrl + imageUrl!),
      });
    }
  } catch (error) {
    print(error);
  }

  print(coupons);
  return coupons;
}

String formatProductName(String name) =>
    name.substring(11, name.indexOf('sparen!') - 1);

Future<String> readPriceFromImage(String imageUrl) async {
  try {
    Response response = await get(Uri.parse(ocrApiUri + imageUrl));
    Map<String, dynamic> results = jsonDecode(response.body);

    String parsedText = results['ParsedResults'][0]['ParsedText'];
    LineSplitter splitter = const LineSplitter();
    List<String> lines = splitter.convert(parsedText);

    for (String line in lines) {
      if (line.contains('€')) {
        return line;
      }
    }
  } catch (error) {
    print(error);
  }

  return '';
}
