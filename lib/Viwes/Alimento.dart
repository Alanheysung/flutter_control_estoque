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
  Alimentos? _alimentoEditando;
  List<Alimentos> _alimentosFiltrados = [];

  String? _nomeErro;
  String? _grupoErro;
  String? _fonteErro;
  String? _medidaErro;
  String? _precoErro;

  @override
  void initState() {
    super.initState();
    _alimentosFiltrados = _controller.listarAlimentos();
  }

  void _limparCampos() {
    _nomeController.clear();
    _grupoController.clear();
    _fonteController.clear();
    _medidaController.clear();
    _precoController.clear();
    setState(() {
      _alimentoEditando = null;
    });
  }

  bool _validarCampos() {
    bool valido = true;

    if (_nomeController.text.isEmpty) {
      setState(() {
        _nomeErro = 'Nome não pode ser vazio';
      });
      valido = false;
    } else {
      setState(() {
        _nomeErro = null;
      });
    }

    if (_grupoController.text.isEmpty) {
      setState(() {
        _grupoErro = 'Grupo não pode ser vazio';
      });
      valido = false;
    } else {
      setState(() {
        _grupoErro = null;
      });
    }

    if (_fonteController.text.isEmpty) {
      setState(() {
        _fonteErro = 'Fonte não pode ser vazia';
      });
      valido = false;
    } else {
      setState(() {
        _fonteErro = null;
      });
    }

    if (_medidaController.text.isEmpty || double.tryParse(_medidaController.text) == null) {
      setState(() {
        _medidaErro = 'Medida deve ser um número válido';
      });
      valido = false;
    } else {
      setState(() {
        _medidaErro = null;
      });
    }

    if (_precoController.text.isEmpty || double.tryParse(_precoController.text) == null) {
      setState(() {
        _precoErro = 'Preço deve ser um número válido';
      });
      valido = false;
    } else {
      setState(() {
        _precoErro = null;
      });
    }

    return valido;
  }

  void _mostrarConfirmacaoRemocao(String nome) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar Remoção'),
        content: Text('Tem certeza que deseja excluir "$nome"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              _removerAlimento(nome);
              Navigator.of(context).pop();
            },
            child: Text('Excluir'),
          ),
        ],
      ),
    );
  }

  void _adicionarAlimento() {
    if (!_validarCampos()) return;

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
        _alimentosFiltrados = _controller.listarAlimentos();
      });
      _limparCampos();
    } else {
      _mostrarMensagemErro('Alimento já existe.');
    }
  }

  void _removerAlimento(String nome) {
    bool sucesso = _controller.removerAlimento(nome);
    if (sucesso) {
      setState(() {
        _alimentosFiltrados = _controller.listarAlimentos();
      });
    }
  }

  void _atualizarAlimento() {
    if (!_validarCampos()) return;

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
          _alimentosFiltrados = _controller.listarAlimentos();
        });
        _limparCampos();
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
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _nomeController,
                            decoration: InputDecoration(
                              labelText: 'Nome',
                              errorText: _nomeErro,
                            ),
                          ),
                          TextField(
                            controller: _grupoController,
                            decoration: InputDecoration(
                              labelText: 'Grupo',
                              errorText: _grupoErro,
                            ),
                          ),
                          TextField(
                            controller: _fonteController,
                            decoration: InputDecoration(
                              labelText: 'Fonte de Informações',
                              errorText: _fonteErro,
                            ),
                          ),
                          TextField(
                            controller: _medidaController,
                            decoration: InputDecoration(
                              labelText: 'Medida',
                              errorText: _medidaErro,
                            ),
                          ),
                          TextField(
                            controller: _precoController,
                            decoration: InputDecoration(
                              labelText: 'Preço',
                              errorText: _precoErro,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _alimentoEditando == null
                                ? _adicionarAlimento
                                : _atualizarAlimento,
                            child: Text(_alimentoEditando == null
                                ? 'Salvar'
                                : 'Atualizar'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Nome')),
                          DataColumn(label: Text('Grupo')),
                          DataColumn(label: Text('Fonte')),
                          DataColumn(label: Text('Medida')),
                          DataColumn(label: Text('Preço')),
                          DataColumn(label: Text('Ações')),
                        ],
                        rows: _alimentosFiltrados.map((alimento) {
                          return DataRow(
                            cells: [
                              DataCell(Text(alimento.nome)),
                              DataCell(Text(alimento.grupo)),
                              DataCell(Text(alimento.fonteDeInformacoes)),
                              DataCell(Text(alimento.medidaBase.toString())),
                              DataCell(Text('R\$${alimento.preco.toStringAsFixed(2)}')),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () => _preencherCamposParaEdicao(alimento),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () => _mostrarConfirmacaoRemocao(alimento.nome),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
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
