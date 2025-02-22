class Produto {
  final int id;
  final String nome;
  final String unidade;
  final num precoEstimado;
  final num quantidadeEstoque;
  final num quantidadeInicial;
  final bool isPerecivel;
  final DateTime? dataValidade;

  Produto({
    required this.id,
    required this.nome,
    required this.unidade,
    required this.precoEstimado,
    required this.quantidadeEstoque,
    required this.quantidadeInicial,
    required this.isPerecivel,
    this.dataValidade,
  });

  // Conversão para JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'unidade': unidade,
        'precoEstimado': precoEstimado,
        'quantidadeEstoque': quantidadeEstoque,
        'quantidadeInicial': quantidadeInicial,
        'isPerecivel': isPerecivel,
        'dataValidade': dataValidade?.toIso8601String(),
      };

  // Criação a partir de JSON
  factory Produto.fromJson(Map<String, dynamic> json) => Produto(
        id: json['id'],
        nome: json['nome'],
        unidade: json['unidade'],
        precoEstimado: json['precoEstimado'],
        quantidadeEstoque: json['quantidadeEstoque'],
        quantidadeInicial: json['quantidadeInicial'],
        isPerecivel: json['isPerecivel'],
        dataValidade: json['dataValidade'] != null
            ? DateTime.parse(json['dataValidade'])
            : null,
      );
}
