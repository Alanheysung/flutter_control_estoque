class Cardapio {
  final String nome;
  final String descricao;
  final String escola;
  final String modalidade;
  final String periodo;
  final List<String> diasSemana;
  final String tipoRefeicao;
  final String item;
  final String tipoItem;
  final double unidadeMedida;

  Cardapio({
    required this.unidadeMedida,
    required this.descricao,
    required this.diasSemana,
    required this.escola,
    required this.item,
    required this.modalidade,
    required this.nome,
    required this.periodo,
    required this.tipoItem,
    required this.tipoRefeicao,
  });

  // Conversão para JSON
  Map<String, dynamic> toJson() {
    return {
      'unidadeMedida': unidadeMedida,
      'descricao': descricao,
      'diasSemana': diasSemana,
      'escola': escola,
      'item': item,
      'modalidade': modalidade,
      'nome': nome,
      'periodo': periodo,
      'tipoItem': tipoItem,
      'tipoRefeicao': tipoRefeicao,
    };
  }

  // Criação a partir de JSON
  factory Cardapio.fromJson(Map<String, dynamic> json) {
    return Cardapio(
      unidadeMedida: json['unidadeMedida']?.toDouble() ?? 0.0,
      descricao: json['descricao'],
      diasSemana: List<String>.from(json['diasSemana'] ?? []),
      escola: json['escola'],
      item: json['item'],
      modalidade: json['modalidade'],
      nome: json['nome'],
      periodo: json['periodo'],
      tipoItem: json['tipoItem'],
      tipoRefeicao: json['tipoRefeicao'],
    );
  }
}
