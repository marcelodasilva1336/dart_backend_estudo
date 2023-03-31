import 'dart:convert';

class NoticiaModel {
  final int? id;
  final String titulo;
  final String descricao;
  final String imagem;
  final DateTime dtPublicacao;
  final DateTime? dtAtualizacao;
  NoticiaModel({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.imagem,
    required this.dtPublicacao,
    this.dtAtualizacao,
  });

  @override
  String toString() {
    return 'NoticiaModel(id: $id, titulo: $titulo, descricao: $descricao, imagem: $imagem, dtPublicacao: $dtPublicacao, dtAtualizacao: $dtAtualizacao)';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'titulo': titulo});
    result.addAll({'descricao': descricao});
    result.addAll({'imagem': imagem});
    result.addAll({'dtPublicacao': dtPublicacao.millisecondsSinceEpoch});
    if (dtAtualizacao != null) {
      result.addAll({'dtAtualizacao': dtAtualizacao!.millisecondsSinceEpoch});
    }

    return result;
  }

  factory NoticiaModel.fromMap(Map<String, dynamic> map) {
    return NoticiaModel(
      id: map['id'] ?? 0,
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
      imagem: map['imagem'] ?? '',
      dtPublicacao: DateTime.now(),
      dtAtualizacao: DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory NoticiaModel.fromJson(String source) =>
      NoticiaModel.fromMap(json.decode(source));
}
