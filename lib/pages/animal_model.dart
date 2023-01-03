// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class AnimalModel {
  final String tipoAnimal;
  final String sexo;
  final String nome;
  final String idade;
  final String idUsuario;
  final String foto;

  AnimalModel({
    required this.tipoAnimal,
    required this.sexo,
    required this.nome,
    required this.idade,
    required this.idUsuario,
    required this.foto
  });

  AnimalModel copyWith({
    String? tipoAnimal,
    String? sexo,
    String? nome,
    String? idade,
    String? idUsuario,
    String? foto,
  }) {
    return AnimalModel(
      tipoAnimal: tipoAnimal ?? this.tipoAnimal,
      sexo: sexo ?? this.sexo,
      nome: nome ?? this.nome,
      idade: idade ?? this.idade,
      idUsuario: idUsuario ?? this.idUsuario,
      foto: foto ?? this.foto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tipoAnimal': tipoAnimal,
      'sexo': sexo,
      'nome': nome,
      'idade': idade,
      'idUsuario': idUsuario,
      'foto': foto
    };
  }

  factory AnimalModel.fromMap(Map<String, dynamic> map) {
    return AnimalModel(
      tipoAnimal: map['tipoAnimal'] as String,
      sexo: map['sexo'] as String,
      nome: map['nome'] as String,
      idade: map['idade'] as String,
      idUsuario: map['idUsuario'] as String,
      foto: map['foto'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimalModel.fromJson(String source) =>
      AnimalModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AnimalModel(tipoAnimal: $tipoAnimal, sexo: $sexo, nome: $nome, idade: $idade, idUsuario: $idUsuario, foto: $foto)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AnimalModel &&
        other.tipoAnimal == tipoAnimal &&
        other.sexo == sexo &&
        other.nome == nome &&
        other.idade == idade &&
        other.idUsuario == idUsuario &&
        other.foto == foto;
  }

  @override
  int get hashCode {
    return tipoAnimal.hashCode ^
        sexo.hashCode ^
        nome.hashCode ^
        idade.hashCode ^
        idUsuario.hashCode ^
        foto.hashCode;
  }
}
