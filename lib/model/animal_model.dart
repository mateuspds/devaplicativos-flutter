// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AnimalModel {
  final String tipoDoAnimal;
  final String sexo;
  final String nome;
  final String idade;
  final String porte;
  final String dono;
  final String id;
  final bool doacao;
  AnimalModel({
    required this.tipoDoAnimal,
    required this.sexo,
    required this.nome,
    required this.idade,
    required this.porte,
    required this.dono,
    required this.doacao,
    required this.id
  });

  AnimalModel copyWith({
    String? tipoDoAnimal,
    String? sexo,
    String? nome,
    String? idade,
    String? porte,
    String? dono,
    bool? doacao,
    String? id
  }) {
    return AnimalModel(
      tipoDoAnimal: tipoDoAnimal ?? this.tipoDoAnimal,
      sexo: sexo ?? this.sexo,
      nome: nome ?? this.nome,
      idade: idade ?? this.idade,
      porte: porte ?? this.porte,
      dono: dono ?? this.dono,
      doacao: doacao ?? this.doacao,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tipoDoAnimal': tipoDoAnimal,
      'sexo': sexo,
      'nome': nome,
      'idade': idade,
      'porte': porte,
      'dono': dono,
      'doacao': doacao,
      'id':id
    };
  }

  factory AnimalModel.fromMap(Map<String, dynamic> map) {
    return AnimalModel(
      tipoDoAnimal: map['tipoDoAnimal'] as String,
      sexo: map['sexo'] as String,
      nome: map['nome'] as String,
      idade: map['idade'] as String,
      porte: map['porte'] as String,
      dono: map['dono'] as String,
      doacao: map['doacao'] as bool,
      id: map['id'] as String
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimalModel.fromJson(String source) =>
      AnimalModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AnimalModel(tipoDoAnimal: $tipoDoAnimal, id:$id, sexo: $sexo, nome: $nome, idade: $idade, porte: $porte, dono: $dono, doacao: $doacao)';
  }

  @override
  bool operator ==(covariant AnimalModel other) {
    if (identical(this, other)) return true;

    return other.tipoDoAnimal == tipoDoAnimal &&
        other.sexo == sexo &&
        other.nome == nome &&
        other.idade == idade &&
        other.porte == porte &&
        other.dono == dono &&
        other.id == id &&
        other.doacao == doacao;
  }

  @override
  int get hashCode {
    return tipoDoAnimal.hashCode ^
        sexo.hashCode ^
        nome.hashCode ^
        idade.hashCode ^
        porte.hashCode ^
        dono.hashCode ^
        id.hashCode ^
        doacao.hashCode;
  }
}
