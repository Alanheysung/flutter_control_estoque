class Refeicao {
  final String nome;
  final String descricao;
  final DateTime horario;

  Refeicao({
    required this.descricao,
    required this.nome,
    required this.horario,
  });

  // Conversão para JSON
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'descricao': descricao,
      'horario': horario.toIso8601String(), // Converte DateTime para String ISO
    };
  }

  // Criação a partir de JSON
  factory Refeicao.fromJson(Map<String, dynamic> json) {
    return Refeicao(
      nome: json['nome'],
      descricao: json['descricao'],
      horario: DateTime.parse(json['horario']), // Converte String ISO para DateTime
    );
  }
}
