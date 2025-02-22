import '../Models/EscolaModel.dart';

class EscolaController {
  List<Escola> _escolas = [];

  // Adicionar uma escola
  void adicionarEscola(Escola escola) {
    _escolas.add(escola);
    print("Escola '${escola.nome}' adicionada com sucesso!");
  }

  // Listar todas as escolas
  List<Escola> listarEscolas() {
    return _escolas;
  }
}
