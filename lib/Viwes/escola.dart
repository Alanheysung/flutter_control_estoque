import 'package:flutter/material.dart';
import '../Controllers/EscolaController.dart';
import '../Models/EscolaModel.dart';

class EscolaView extends StatefulWidget {
  @override
  _EscolaViewState createState() => _EscolaViewState();
}

class _EscolaViewState extends State<EscolaView> {
  final EscolaController _controller = EscolaController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _capacidadeController = TextEditingController();
  final TextEditingController _faixaIdadeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _pesquisaController = TextEditingController();

  String? _periodoSelecionado;
  String? _modalidadeSelecionada;
  String? _referencialNutricionalSelecionado;
  int? _nRefeicoesSelecionado;

  int? _idEscolaAtualizar;

  final List<String> _periodos = ['Integral', 'Parcial'];
  final List<String> _modalidades = ['Creche', 'Pré-escola', 'Ensino Fundamental', 'EJA'];
  final List<String> _referenciaisNutricionais = ['20%', '25%', '30%', '35%'];
  final List<int> _nRefeicoes = [1, 2, 3, 4];

  void _adicionarEscola() {
    if (_nomeController.text.isEmpty ||
        _enderecoController.text.isEmpty ||
        _telefoneController.text.isEmpty ||
        _capacidadeController.text.isEmpty ||
        _faixaIdadeController.text.isEmpty ||
        _periodoSelecionado == null ||
        _modalidadeSelecionada == null ||
        _referencialNutricionalSelecionado == null ||
        _nRefeicoesSelecionado == null ||
        _descricaoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Todos os campos devem ser preenchidos!')),
      );
      return;
    }

    final escola = Escola(
      id: DateTime.now().millisecondsSinceEpoch,
      nome: _nomeController.text,
      endereco: _enderecoController.text,
      telefone: _telefoneController.text,
      capacidadeAlunos: int.parse(_capacidadeController.text),
      faixaIdade: int.parse(_faixaIdadeController.text),
      periodo: _periodoSelecionado!,
      nRefeicoesOfertados: _nRefeicoesSelecionado!,
      modalidade: _modalidadeSelecionada!,
      descricao: _descricaoController.text,
      referencialNutricional: _referencialNutricionalSelecionado!,
    );

    if (_controller.adicionarEscola(escola)) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Escola adicionada com sucesso!')),
      );
      _limparCampos(); // Limpa os campos após salvar
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar escola. ID já existente.')),
      );
    }
  }

  void _atualizarEscola() {
    if (_idEscolaAtualizar == null) return;

    if (_nomeController.text.isEmpty ||
        _enderecoController.text.isEmpty ||
        _telefoneController.text.isEmpty ||
        _capacidadeController.text.isEmpty ||
        _faixaIdadeController.text.isEmpty ||
        _periodoSelecionado == null ||
        _modalidadeSelecionada == null ||
        _referencialNutricionalSelecionado == null ||
        _nRefeicoesSelecionado == null ||
        _descricaoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Todos os campos devem ser preenchidos!')),
      );
      return;
    }

    final escolaAtualizada = Escola(
      id: _idEscolaAtualizar!,
      nome: _nomeController.text,
      endereco: _enderecoController.text,
      telefone: _telefoneController.text,
      capacidadeAlunos: int.parse(_capacidadeController.text),
      faixaIdade: int.parse(_faixaIdadeController.text),
      periodo: _periodoSelecionado!,
      nRefeicoesOfertados: _nRefeicoesSelecionado!,
      modalidade: _modalidadeSelecionada!,
      descricao: _descricaoController.text,
      referencialNutricional: _referencialNutricionalSelecionado!,
    );

    if (_controller.atualizarEscola(_idEscolaAtualizar!, escolaAtualizada)) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Escola atualizada com sucesso!')),
      );
      _limparCampos(); // Limpa os campos após atualizar
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar escola.')),
      );
    }
  }

  void _editarEscola(Escola escola) {
    setState(() {
      _nomeController.text = escola.nome;
      _enderecoController.text = escola.endereco;
      _telefoneController.text = escola.telefone;
      _capacidadeController.text = escola.capacidadeAlunos.toString();
      _faixaIdadeController.text = escola.faixaIdade.toString();
      _periodoSelecionado = escola.periodo;
      _modalidadeSelecionada = escola.modalidade;
      _referencialNutricionalSelecionado = escola.referencialNutricional;
      _nRefeicoesSelecionado = escola.nRefeicoesOfertados;
      _descricaoController.text = escola.descricao;
      _idEscolaAtualizar = escola.id;
    });
  }

  void _limparCampos() {
    setState(() {
      _nomeController.clear();
      _enderecoController.clear();
      _telefoneController.clear();
      _capacidadeController.clear();
      _faixaIdadeController.clear();
      _descricaoController.clear();
      _pesquisaController.clear();
      _periodoSelecionado = null;
      _modalidadeSelecionada = null;
      _referencialNutricionalSelecionado = null;
      _nRefeicoesSelecionado = null;
      _idEscolaAtualizar = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gerenciar Escolas')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  TextField(controller: _nomeController, decoration: InputDecoration(labelText: 'Nome')),
                  TextField(controller: _enderecoController, decoration: InputDecoration(labelText: 'Endereço')),
                  TextField(controller: _telefoneController, decoration: InputDecoration(labelText: 'Telefone')),
                  TextField(controller: _capacidadeController, decoration: InputDecoration(labelText: 'Capacidade de alunos'), keyboardType: TextInputType.number),
                  TextField(controller: _faixaIdadeController, decoration: InputDecoration(labelText: 'Faixa de idade'), keyboardType: TextInputType.number),
                  DropdownButtonFormField(
                    value: _periodoSelecionado,
                    items: _periodos.map((String periodo) {
                      return DropdownMenuItem(value: periodo, child: Text(periodo));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _periodoSelecionado = value as String?;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Período'),
                  ),
                  DropdownButtonFormField(
                    value: _modalidadeSelecionada,
                    items: _modalidades.map((String modalidade) {
                      return DropdownMenuItem(value: modalidade, child: Text(modalidade));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _modalidadeSelecionada = value as String?;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Modalidade'),
                  ),
                  DropdownButtonFormField(
                    value: _referencialNutricionalSelecionado,
                    items: _referenciaisNutricionais.map((String refNutri) {
                      return DropdownMenuItem(value: refNutri, child: Text(refNutri));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _referencialNutricionalSelecionado = value as String?;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Referencial Nutricional'),
                  ),
                  DropdownButtonFormField(
                    value: _nRefeicoesSelecionado,
                    items: _nRefeicoes.map((int refeicao) {
                      return DropdownMenuItem(value: refeicao, child: Text('$refeicao'));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _nRefeicoesSelecionado = value as int?;
                      });
                    },
                    decoration: InputDecoration(labelText: 'N° Refeições'),
                  ),
                  TextField(controller: _descricaoController, decoration: InputDecoration(labelText: 'Descrição')),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _adicionarEscola,
                        child: Text('Salvar'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _atualizarEscola,
                        child: Text('Alterar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  TextField(
                    controller: _pesquisaController,
                    decoration: InputDecoration(
                      labelText: 'Pesquisar',
                      suffixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Nome')),
                          DataColumn(label: Text('Endereço')),
                          DataColumn(label: Text('Telefone')),
                          DataColumn(label: Text('Capacidade')),
                          DataColumn(label: Text('Modalidade')),
                          DataColumn(label: Text('Ações')),
                        ],
                        rows: _controller.listarEscolas()
                            .where((escola) => escola.nome.toLowerCase().contains(_pesquisaController.text.toLowerCase()))
                            .map((escola) {
                          return DataRow(cells: [
                            DataCell(Text(escola.nome)),
                            DataCell(Text(escola.endereco)),
                            DataCell(Text(escola.telefone)),
                            DataCell(Text(escola.capacidadeAlunos.toString())),
                            DataCell(Text(escola.modalidade)),
                            DataCell(
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => _editarEscola(escola),
                              ),
                            ),
                          ]);
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