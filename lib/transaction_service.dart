import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:square_in_app_payments/models.dart';
import 'package:http/http.dart' as http;

String chargeServerHost = "REPLACE_ME";
String chargeUrl = "$chargeServerHost/chargeForCookie";

class ChargeException implements Exception {
  String errorMessage;
  ChargeException(this.errorMessage);
}

Future<void> chargeCard(CardDetails result) async {
  var body = jsonEncode({"nonce": result.nonce});
  http.Response response;
  try {
    response = await http.post(chargeUrl, body: body, headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    });
  } on SocketException catch (ex) {
    throw ChargeException(ex.message);
  }

  var responseBody = json.decode(response.body);
  if (response.statusCode == 200) {
    return;
  } else {
    throw ChargeException(responseBody["errorMessage"]);
  }
}