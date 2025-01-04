class Produto {
  final int id;
  final String nome;
  final String unidade;
  final double precoEstimado;
  final double quantidadeEstoque;
  final double quantidadeInicial;
  final bool isPerecivel; // Indica se o produto é perecível
  final DateTime? dataValidade; // Validade apenas para perecíveis

  Produto({
    required this.id,
    required this.nome,
    required this.unidade,
    required this.precoEstimado,
    required this.quantidadeEstoque,
    required this.quantidadeInicial,
    required this.isPerecivel, // Inicializado como verdadeiro ou falso
    this.dataValidade,
  }); 

  // Conversão para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'unidade': unidade,
      'precoEstimado': precoEstimado,
      'quantidadeEstoque': quantidadeEstoque,
      'quantidadeInicial': quantidadeInicial,
      'isPerecivel': isPerecivel,
      'dataValidade': dataValidade?.toIso8601String(),
    };
  }

  // Criação a partir de JSON
  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
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
}
