class Escola {
  final int id;
  final String nome;
  final String endereco;
  final String telefone;
  final int capacidadeAlunos;

  Escola({
    required this.id,
    required this.nome,
    required this.endereco,
    required this.telefone,
    required this.capacidadeAlunos,
  });

  // Conversão para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'endereco': endereco,
      'telefone': telefone,
      'capacidadeAlunos': capacidadeAlunos,
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
    );
  }
}
