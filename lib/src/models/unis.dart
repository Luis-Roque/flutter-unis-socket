class Unis{

  String id;
  String nombre;
  int votos;

  Unis({
    this.id,
    this.nombre,
    this.votos
  });

  factory Unis.fromMap(Map<String,dynamic> obj)
  => Unis(
    id:     obj['id'],
    nombre: obj['nombre'],
    votos:  obj['votos']
  );
  
}