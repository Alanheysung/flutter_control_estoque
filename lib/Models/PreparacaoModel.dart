class Preparacao {
  final String nome;
  final String medida;
  final double pcLiquido;
  final String grupo;
  final String fonteDeInformacoes;
  final double pcBruto;
  final int fc;
  final String item;

  Preparacao({
    required this.medida,
    required this.nome,
    required this.pcLiquido,
    required this.fc,
    required this.fonteDeInformacoes,
    required this.grupo,
    required this.item,
    required this.pcBruto,
  });

  //Conversão JSON
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'medida': medida,
      'pcLiquido': pcLiquido,
      'pcBruto': pcBruto,
      'fc': fc,
      'fonteDeInformacoes': fonteDeInformacoes,
      'grupo': grupo,
      'item': item,
    };
  }

  // Criação a partir de JSON
  factory Preparacao.fromJson(Map<String, dynamic> json) {
    return Preparacao(
      nome: json['nome'],
      medida: json['medida'],
      pcLiquido: json['pcLiquido'],
      pcBruto: json['pcBruto'],
      fc: json['fc'],
      grupo: json['grupo'],
      item: json['item'],
      fonteDeInformacoes: json['fonteDeInformacoes'],
    );
  }
}
