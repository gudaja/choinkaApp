class WiFiAp {
  final String SSID;
  final bool Encryption;
  final String Quality;

  WiFiAp._({this.SSID, this.Encryption,this.Quality});

  factory WiFiAp.fromJson(Map<String, dynamic> json) {
    return new WiFiAp._(
      SSID: json['SSID'],
      Encryption: json['Encryption'],
      Quality: json['Quality'],
    );
  }
}
