class ProfilesModel {
  int? id;
  String? avatar;
  String? nombre;
  String? apaterno;
  String? amaterno;
  int? telefono;
  String? email;

  ProfilesModel({this.id, this.avatar, this.nombre, this.apaterno, this.amaterno, this.telefono, this.email});

  //Map -> Object
  factory ProfilesModel.fromMap(Map<String,dynamic> map){
    return ProfilesModel(
      id: map['id'],
      avatar: map['avatar'],
      nombre: map['nombre'],
      apaterno: map['apaterno'],
      amaterno: map['amaterno'],
      telefono: map['telefono'],
      email: map['email']
    );
  }

  //Object -> Map
  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'avatar':avatar,
      'nombre':nombre,
      'apaterno':apaterno,
      'amaterno':amaterno,
      'telefono':telefono,
      'email':email
    };
  }
}