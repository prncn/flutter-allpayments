import 'dart:convert';
import 'package:http/http.dart';

const String accessKey = 'thEZ20OyHFDkAE24Fkg8va-yVBSZBpBaEI86BV2WZ5g';
const String baseUrl = 'api.unsplash.com';
const String imageNotFoundFallback =
    'https://images.unsplash.com/photo-1610337673044-720471f83677?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1072&q=80';

Future<String> searchImage() async {
  Uri uri = Uri.https(baseUrl, '/search/photos', {'query': 'supermarket'});
  String imageUrl = imageNotFoundFallback;

  try {
    Response response = await get(uri, headers: {
      'Authorization': 'Client-ID $accessKey',
    });
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> results = json['results'];
    imageUrl = results[0]['urls']['regular'];
  } catch (error) {
    print(error);
  }

  return imageUrl;
}

const List<String> marketImages = [
  'https://images.unsplash.com/photo-1601600576337-c1d8a0d1373c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c3VwZXJtYXJrZXR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1628102491629-778571d893a3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8c3VwZXJtYXJrZXR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8c3VwZXJtYXJrZXR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1568626913161-c4ac1e5ae186?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHN1cGVybWFya2V0fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1612776561584-394d456a751d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fHN1cGVybWFya2V0fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
];
