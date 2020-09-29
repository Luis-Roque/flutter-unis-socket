class Uni{

  String id;
  String nombre;
  int votos;

  Uni({
    this.id,
    this.nombre,
    this.votos
  });

  factory Uni.fromMap(Map<String,dynamic> obj)
  => Uni(
    id:     obj.containsKey('id')     ? obj['id']     :'sin id',
    nombre: obj.containsKey('nombre') ? obj['nombre'] :'sin nombre',
    votos:  obj.containsKey('votos')  ? obj['votos']  :'sin votos'
  );
  
}