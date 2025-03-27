import 'package:flutter/material.dart';
import '../Controllers/AlimentosController.dart';
import '../Models/AlimentosModel.dart';

class AlimentosScreen extends StatefulWidget {
  @override
  _AlimentosScreenState createState() => _AlimentosScreenState();
}

class _AlimentosScreenState extends State<AlimentosScreen> {
  final AlimentosController _controller = AlimentosController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _grupoController = TextEditingController();
  final TextEditingController _fonteController = TextEditingController();
  final TextEditingController _medidaController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _pesquisaController = TextEditingController();
  final TextEditingController _precoMinController = TextEditingController();
  final TextEditingController _precoMaxController = TextEditingController();
  String _modoBusca = 'Todos';
  Alimentos? _alimentoEditando;

  List<Alimentos> _alimentosFiltrados = [];

  @override
  void initState() {
    super.initState();
    _alimentosFiltrados = _controller.listarAlimentos(); // Inicializa com todos os alimentos
  }

  void _adicionarAlimento() {
    final alimento = Alimentos(
      nome: _nomeController.text,
      grupo: _grupoController.text,
      fonteDeInformacoes: _fonteController.text,
      medidaBase: double.tryParse(_medidaController.text) ?? 0.0,
      preco: double.tryParse(_precoController.text) ?? 0.0,
    );

    bool sucesso = _controller.adicionarAlimento(alimento);
    if (sucesso) {
      setState(() {
        _limparCampos();
        _alimentosFiltrados = _controller.listarAlimentos(); // Atualiza a lista após adicionar
      });
    } else {
      _mostrarMensagemErro('Alimento já existe.');
    }
  }

  void _removerAlimento(String nome) {
    bool sucesso = _controller.removerAlimento(nome);
    if (sucesso) {
      setState(() {
        _alimentosFiltrados = _controller.listarAlimentos(); // Atualiza a lista após remoção
      });
    } else {
      _mostrarMensagemErro('Alimento não encontrado.');
    }
  }

  void _atualizarAlimento() {
    if (_alimentoEditando != null) {
      final alimentoAtualizado = Alimentos(
        nome: _nomeController.text,
        grupo: _grupoController.text,
        fonteDeInformacoes: _fonteController.text,
        medidaBase: double.tryParse(_medidaController.text) ?? 0.0,
        preco: double.tryParse(_precoController.text) ?? 0.0,
      );

      bool sucesso = _controller.atualizarAlimento(_alimentoEditando!.nome, alimentoAtualizado);
      if (sucesso) {
        setState(() {
          _limparCampos();
          _alimentoEditando = null;
          _alimentosFiltrados = _controller.listarAlimentos(); // Atualiza a lista após atualização
        });
      } else {
        _mostrarMensagemErro('Erro ao atualizar alimento.');
      }
    }
  }

  void _preencherCamposParaEdicao(Alimentos alimento) {
    setState(() {
      _alimentoEditando = alimento;
      _nomeController.text = alimento.nome;
      _grupoController.text = alimento.grupo;
      _fonteController.text = alimento.fonteDeInformacoes;
      _medidaController.text = alimento.medidaBase.toString();
      _precoController.text = alimento.preco.toString();
    });
  }

  void _buscarAlimento() {
    final alimento = _controller.buscarAlimento(_pesquisaController.text);
    if (alimento != null) {
      setState(() {
        _alimentoEditando = alimento;
        _nomeController.text = alimento.nome;
        _grupoController.text = alimento.grupo;
        _fonteController.text = alimento.fonteDeInformacoes;
        _medidaController.text = alimento.medidaBase.toString();
        _precoController.text = alimento.preco.toString();
      });
    } else {
      _mostrarMensagemErro('Alimento não encontrado.');
    }
  }

  
void _filtrarAlimentos() {
  List<Alimentos> alimentosFiltradosTemp = [];

  if (_modoBusca == 'Por Nome') {
    final alimento = _controller.buscarAlimento(_pesquisaController.text);
    if (alimento != null) {
      alimentosFiltradosTemp.add(alimento);
    }
  } else if (_modoBusca == 'Por Grupo') {
    alimentosFiltradosTemp = _controller.filtrarPorGrupo(_pesquisaController.text);
  } else if (_modoBusca == 'Por Preço') {
    double precoMax = double.tryParse(_precoMaxController.text) ?? -1;
    
    if (precoMax > 0) {
      alimentosFiltradosTemp = _controller.filtrarPorPrecoMaximo(precoMax);
    } else {
      _mostrarMensagemErro('Por favor, insira um preço válido.');
      return;
    }
  } else if (_modoBusca == 'Faixa de Preço') {
    double precoMin = double.tryParse(_precoMinController.text) ?? -1;
    double precoMax = double.tryParse(_precoMaxController.text) ?? -1;

    if (precoMin >= 0 && precoMax > precoMin) {
      alimentosFiltradosTemp = _controller.filtrarPorFaixaPreco(precoMin, precoMax);
    } else {
      _mostrarMensagemErro('Por favor, insira uma faixa de preço válida.');
    }
}
 else {
    alimentosFiltradosTemp = _controller.listarAlimentos();
  }

  setState(() {
    _alimentosFiltrados = alimentosFiltradosTemp;
  });
}



  void _limparCampos() {
    _nomeController.clear();
    _grupoController.clear();
    _fonteController.clear();
    _medidaController.clear();
    _precoController.clear();
    _pesquisaController.clear();
    _precoMinController.clear();
    _precoMaxController.clear();
  }

  void _mostrarMensagemErro(String mensagem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Erro'),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gerenciar Alimentos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  TextField(controller: _nomeController, decoration: InputDecoration(labelText: 'Nome')),
                  TextField(controller: _grupoController, decoration: InputDecoration(labelText: 'Grupo')),
                  TextField(controller: _fonteController, decoration: InputDecoration(labelText: 'Fonte de Informação')),
                  TextField(controller: _medidaController, decoration: InputDecoration(labelText: 'Medida Base'), keyboardType: TextInputType.number),
                  TextField(controller: _precoController, decoration: InputDecoration(labelText: 'Preço'), keyboardType: TextInputType.number),
                  SizedBox(height: 10),
                  ElevatedButton(onPressed: _adicionarAlimento, child: Text('Adicionar Alimento')),
                  if (_alimentoEditando != null)
                    ElevatedButton(onPressed: _atualizarAlimento, child: Text('Atualizar Alimento')),
                ],
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  DropdownButton<String>(
                    value: _modoBusca,
                    onChanged: (String? novoValor) {
                      setState(() {
                        _modoBusca = novoValor!;
                        _pesquisaController.clear();
                        
                        // Se o usuário selecionar "Todos", exibir a lista completa
                        if (_modoBusca == 'Todos') {
                          _alimentosFiltrados = _controller.listarAlimentos();
                        }
                      });
                    },
                    items: ['Todos', 'Por Nome', 'Por Grupo', 'Por Preço', 'Faixa de Preço']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  if (_modoBusca == 'Por Nome')
                    Column(
                      children: [
                        TextField(controller: _pesquisaController, decoration: InputDecoration(labelText: 'Nome do Alimento')),
                        ElevatedButton(onPressed: _filtrarAlimentos, child: Text('Buscar')),
                      ],
                    ),
                  if (_modoBusca == 'Por Grupo' || _modoBusca == 'Por Preço' || _modoBusca == 'Faixa de Preço')
                    Column(
                      children: [
                        TextField(controller: _pesquisaController, decoration: InputDecoration(labelText: 'Pesquisa')),
                        ElevatedButton(onPressed: _filtrarAlimentos, child: Text('Filtrar')),
                      ],
                    ),
                    
                  Expanded(
                    child: ListView.builder(
                      itemCount: _alimentosFiltrados.length,
                      itemBuilder: (context, index) {
                        final alimento = _alimentosFiltrados[index];
                        return ListTile(
                          title: Text(alimento.nome),
                          subtitle: Text('Grupo: ${alimento.grupo}, Preço: R\$${alimento.preco}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => _preencherCamposParaEdicao(alimento),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => _removerAlimento(alimento.nome),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}