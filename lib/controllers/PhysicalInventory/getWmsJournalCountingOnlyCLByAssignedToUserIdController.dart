import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../models/GetWmsJournalCountingOnlyCLByAssignedToUserIdModel.dart';
import '../../utils/Constants.dart';

class getWmsJournalCountingOnlyCLByAssignedToUserIdController {
  static Future<List<GetWmsJournalCountingOnlyCLByAssignedToUserIdModel>>
      getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url =
        "${Constants.baseUrl}getWmsJournalCountingOnlyCLByAssignedToUserId";
    print("url: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
    };

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");

        var data = json.decode(response.body) as List;
        List<GetWmsJournalCountingOnlyCLByAssignedToUserIdModel> shipmentData =
            data
                .map((e) =>
                    GetWmsJournalCountingOnlyCLByAssignedToUserIdModel.fromJson(
                        e))
                .toList();
        return shipmentData;
      } else {
        print("Status Code: ${response.statusCode}");
        var data = json.decode(response.body);
        var msg = data['message'];
        throw Exception(msg);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
