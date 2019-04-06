import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'contact_data.dart';

class RandomUserRepository implements ContactRepository{
  
  static const _kRandomUserUrl = 'https://api.randomuser.me/?result=15';
  final JsonDecoder _decoder = new JsonDecoder();

  @override
  Future<List<Contact>> fetch() async {
    final responses = await http.get(_kRandomUserUrl);
    final jsonBody = responses.body;
    final statusCode = responses.statusCode;
    if(statusCode < 200 || statusCode >= 300 || jsonBody == null){
      throw new FetchDataException("error While getting data [Status code : $statusCode, Error: ${responses.reasonPhrase}]");
    }

    final contactContainer = _decoder.convert(jsonBody);
    final List contactItems = contactContainer['results'];

    // return contactItems.map((contactRaw) => Contact.(contactRaw)).toList();
    return contactItems.map((contactRaw) => Contact.fromMap(contactRaw)).toList();
  }

}