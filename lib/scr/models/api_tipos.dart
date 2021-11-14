class ApiTipos {
  final int id;
  final String
      tipo; // 1 = grupo app; 2= grupo de contactos; 3= grupo menu principal
  final String grupo; // Nombre del grupo
  final String nombre; // Nombre del elemento grupo
  ApiTipos({this.id, this.tipo, this.grupo, this.nombre});

  Map<String, dynamic> toJson() =>
      {"id": id, "tipo": tipo, "grupo": grupo, "nombre": nombre};
  factory ApiTipos.fromJson(Map<String, dynamic> json) => ApiTipos(
        id: json["id"],
        tipo: json["tipo"],
        grupo: json["grupo"],
        nombre: json["nombre"],
      );
}
