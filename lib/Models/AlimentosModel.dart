class Alimentos {
  final String nome;
  final String grupo;
  final String fonteDeInformacoes;
  final double medidaBase;
  final double preco;

  Alimentos({
    required this.fonteDeInformacoes,
    required this.grupo,
    required this.medidaBase,
    required this.nome,
    required this.preco,
  });

  //Conversão JSON
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'grupo': grupo,
      'medidaBase': medidaBase,
      'fonteDeInformacoes': fonteDeInformacoes,
      'preco': preco,
    };
  }

  // Criação a partir de JSON
  factory Alimentos.fromJson(Map<String, dynamic> json) {
    return Alimentos(
      nome: json['nome'],
      grupo: json['grupo'],
      medidaBase: json['medidaBase'],
      fonteDeInformacoes: json['fonteDeInformacoes'],
      preco: json['preco'],
    );
  }
}
