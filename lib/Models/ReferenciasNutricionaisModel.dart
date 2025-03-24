class ReferenciasNutricionais{
  final String nome;
  final String descricao;
  final int nRefeicoes;
  final int faixaIdade;
  final String categoriaEnsino;
  final String periodo;

  ReferenciasNutricionais({
    required this.categoriaEnsino,
    required this.descricao,
    required this.faixaIdade,
    required this.nRefeicoes,
    required this.nome,
    required this.periodo,
  });

  //Conversão para JSON
  Map<String, dynamic> toJson(){
    return{
      'nome': nome,
      'descricao': descricao,
      'nRefeicoes': nRefeicoes,
      'faixaIdade': faixaIdade,
      'categoriaEnsino': categoriaEnsino,
      'periodo': periodo,
    };
  }

  //Criação a ártir de JSON
  factory ReferenciasNutricionais.fromJson(Map<String, dynamic> json){
    return ReferenciasNutricionais(
      nome: json['nome'],
      descricao: json['descricao'],
      nRefeicoes: json['nRefeicoes'],
      faixaIdade: json['faixaIdade'],
      categoriaEnsino: json['categoriaEnsino'],
      periodo: json['periodo']
    );
  }

}