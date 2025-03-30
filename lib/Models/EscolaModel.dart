class Escola {
  final int id;
  final String nome;
  final String endereco;
  final String telefone;
  final int capacidadeAlunos;
  final String faixaIdade;
  final String periodo;
  final int nRefeicoesOfertados;
  final String modalidade;
  final String descricao;
  final String referencialNutricional;


  Escola({
    required this.id,
    required this.nome,
    required this.endereco,
    required this.telefone,
    required this.capacidadeAlunos,
    required this.descricao,
    required this.modalidade,
    required this.faixaIdade,
    required this.nRefeicoesOfertados,
    required this.periodo,
    required this.referencialNutricional,
  });

  // Conversão para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'endereco': endereco,
      'telefone': telefone,
      'capacidadeAlunos': capacidadeAlunos,
      'descricao': descricao,
      'modalidade': modalidade,
      'faixaIdade': faixaIdade,
      'nRefeicoesOfertadas': nRefeicoesOfertados,
      'periodo': periodo,
      'referencialNutricional': referencialNutricional,
    };
  }

  // Criação a partir de JSON
  factory Escola.fromJson(Map<String, dynamic> json) {
    return Escola(
      id: json['id'],
      nome: json['nome'],
      endereco: json['endereco'],
      telefone: json['telefone'],
      capacidadeAlunos: json['capacidadeAlunos'],
      descricao: json['descricao'],
      modalidade: json['modalidade'],
      faixaIdade: json['faixaIdade'],
      nRefeicoesOfertados: json['nRefeicoesOfertados'],
      periodo: json['periodo'],
      referencialNutricional: json['referencipalNutricional'],
    );
  }
}
