import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  final String _ckIpv4 = 'http://192.168.0.103:8000';
  // final String _emulator = 'http://10.0.2.2:8000/api/';
  // final String _imgUrl = 'https://drive.google.com/uc?export=view&id=';
  // final String _host = 'http://192.168.0.104:8000/';
  getHost() async {
    var domain = await _loadSavedDomainName();
    return '$domain/';
  }

  // getImage() {
  //   return _imgUrl;
  // }

  postData(data, apiUrl) async {
    // var fullUrl = _ckIpv4 + apiUrl;
    // return await http.post(Uri.parse(fullUrl),
    //     body: jsonEncode(data), headers: _setHeaders());
  }

  login(data, apiUrl) async {
    var domain = await _loadSavedDomainName();
    if (domain.isNotEmpty) {
      var fullUrl = '$domain/api/$apiUrl';
      return await http.post(Uri.parse(fullUrl),
          body: jsonEncode(data), headers: _setHeaders());
    }
  }

  // getData(apiUrl) async {
  //   var fullUrl = _ckIpv4 + apiUrl + await _getToken();
  //   return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  // }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }

  _loadSavedDomainName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var savedDomainName = prefs.getString('domainname') ?? '';
    return savedDomainName;
  }

  getPublicData(apiUrl) async {
    var domain = await _loadSavedDomainName();
    var fullUrl = '$domain/api/$apiUrl';
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }
}
