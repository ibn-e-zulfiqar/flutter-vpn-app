class Vpn {
  String? hostName;
  String? iP;
  String? ping;
  String? speed;
  String? countryLong;
  String? countryShort;
  String? numVpnSessions;
  String? openVPNConfigDataBase64;

  Vpn({this.hostName,
    this.iP, this.ping, this.speed,
    this.countryLong, this.countryShort, this.numVpnSessions,
    this.openVPNConfigDataBase64});

  Vpn.fromJson(Map<String, dynamic> json) {
    hostName = json['HostName']?.toString() ?? '';
    iP = json['IP']?.toString() ?? '';
    ping = json['Ping']?.toString() ?? '';
    speed = json['Speed']?.toString() ?? '';
    countryLong = json['CountryLong']?.toString() ?? '';
    countryShort = json['CountryShort']?.toString() ?? '';
    numVpnSessions = json['NumVpnSessions']?.toString() ?? '';
    openVPNConfigDataBase64 = json['OpenVPN_ConfigData_Base64']?.toString() ?? '';
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HostName'] = this.hostName;
    data['IP'] = this.iP;
    data['Ping'] = this.ping;
    data['Speed'] = this.speed;
    data['CountryLong'] = this.countryLong;
    data['CountryShort'] = this.countryShort;
    data['NumVpnSessions'] = this.numVpnSessions;
    data['OpenVPN_ConfigData_Base64'] = this.openVPNConfigDataBase64;
    return data;
  }
}
