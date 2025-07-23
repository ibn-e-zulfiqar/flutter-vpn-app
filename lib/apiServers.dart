import 'dart:convert';
import 'dart:developer';
import 'Vpn.dart';

import'package:http/http.dart' ;
import 'package:csv/csv.dart';


class call {
  static Future<List<Vpn>> getServers() async {
    final List<Vpn> vpnlist = [];

    final res = await get(Uri.parse('https://www.vpngate.net/api/iphone/'));

    if (res.statusCode == 200) {
      final csvString = res.body.split('#')[1].replaceAll('*', '');
      List<List<dynamic>> list = const CsvToListConverter().convert(csvString);

      final header = list[0];

      for (int i = 1; i < list.length; ++i) {
        Map<String, dynamic> tempJson = {};
        for (int j = 0; j < header.length && j < list[i].length; ++j) {
          tempJson[header[j].toString()] = list[i][j];
        }
        vpnlist.add(Vpn.fromJson(tempJson));
      }
    }

    return vpnlist;
  }
}
