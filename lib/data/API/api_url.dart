import 'dart:convert';
// import 'dart:html';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = "https://ukk-smk-2022.rahmatwahyumaakbar.com/api/";

String baseAssetUrl = "https://ukk-smk-2022.rahmatwahyumaakbar.com/storage/";

String apiBearerToken = "Bearer 15|XTuhqGOipzmIb9j5t55fdbAQAyhVoDDMzJFtNLgp";

class Network {
  final String _url = 'https://ukk-smk-2022.rahmatwahyumaakbar.com/api/';
  var token;
  var user;

  getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token').toString());
  }

  getUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    user = jsonDecode(localStorage.getString('user') ?? '');
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

  logout(apiURL) async {
    var fullUrl = Uri.parse(_url + apiURL);
    await getToken();
    return await http.post(fullUrl, headers: setHeaders());
  }

  postMultipartRental(
      apiURL, String dtStart, String dtEnd, String amount, File file) async {
    var fullUrl = Uri.parse(_url + apiURL);
    await getToken();
    var pic = await http.MultipartFile.fromPath('guarante_rent_1', file.path);
    var request = http.MultipartRequest("POST", fullUrl)
      ..headers.addAll(setHeadersMultipart())
      ..fields['start_rent_date'] = dtStart
      ..fields['end_rent_date'] = dtEnd
      ..files.add(pic)
      ..fields['totalAmount'] = amount;
    return await request.send();

    // return await response.stream.toBytes();
    // return await = http
  }

  postMultipartPay(
      apiURL, String? name, String? bank, String? amount, File file) async {
    var fullUrl = Uri.parse(_url + apiURL);
    await getToken();
    var pic = await http.MultipartFile.fromPath('payment_proof', file.path);
    var request = http.MultipartRequest("POST", fullUrl)
      ..headers.addAll(setHeadersMultipart())
      ..fields['payer_name'] = name.toString()
      ..fields['bank'] = bank.toString()
      ..files.add(pic)
      ..fields['amount'] = amount.toString();
    return await request.send();

    // return await response.stream.toBytes();
    // return await = http
  }

  setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
  setHeadersMultipart() => {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data'
      };
}
