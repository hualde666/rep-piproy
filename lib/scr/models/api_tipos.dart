class ApiTipos {
  final int id;
  final String tipo;
  final String nombreApi;
  ApiTipos({this.id, this.tipo, this.nombreApi});

  Map<String, dynamic> toJson() =>
      {"id": id, "tipo": tipo, "nombreApi": nombreApi};
  factory ApiTipos.fromJson(Map<String, dynamic> json) => ApiTipos(
        id: json["id"],
        tipo: json["tipo"],
        nombreApi: json["nombreApi"],
      );
}
