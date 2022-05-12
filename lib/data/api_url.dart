import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = "https://ukk-smk-2022.rahmatwahyumaakbar.com/api/";

String baseAssetUrl = "https://ukk-smk-2022.rahmatwahyumaakbar.com/storage/";

String apiBearerToken = "Bearer 15|XTuhqGOipzmIb9j5t55fdbAQAyhVoDDMzJFtNLgp";

class Network {
  final String _url = 'https://ukk-smk-2022.rahmatwahyumaakbar.com/api/';
  var token;

  getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token').toString());
  }

  auth(data, apiURL) async {
    var fullUrl = Uri.parse(_url + apiURL);
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: setHeaders());
  }

  authUrl(data, apiURL) async {
    var fullUrl = Uri.parse(_url + apiURL + data);
    return await http.post(fullUrl, headers: setHeaders());
  }

  getData(apiURL) async {
    var fullUrl = Uri.parse(_url + apiURL);
    await getToken();
    return await http.get(
      fullUrl,
      headers: setHeaders(),
    );
  }

  setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
