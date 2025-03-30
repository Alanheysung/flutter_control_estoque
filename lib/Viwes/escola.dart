import 'package:flutter/material.dart';
import '../Controllers/EscolaController.dart';
import '../Models/EscolaModel.dart';

class EscolaView extends StatefulWidget {
  @override
  _EscolaViewState createState() => _EscolaViewState();
}

class _EscolaViewState extends State<EscolaView> {
  final EscolaController _controller = EscolaController();
  final _formKey = GlobalKey<FormState>();

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
    if (_formKey.currentState!.validate()) {
      final escola = Escola(
        id: DateTime.now().millisecondsSinceEpoch,
        nome: _nomeController.text,
        endereco: _enderecoController.text,
        telefone: _telefoneController.text,
        capacidadeAlunos: int.parse(_capacidadeController.text),
        faixaIdade: _faixaIdadeController.text,
        periodo: _periodoSelecionado!,
        nRefeicoesOfertados: _nRefeicoesSelecionado!,
        modalidade: _modalidadeSelecionada!,
        descricao: _descricaoController.text,
        referencialNutricional: _referencialNutricionalSelecionado!,
      );

      _controller.adicionarEscola(escola);

      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Escola adicionada com sucesso!')),
      );
      _limparCampos();
    }
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

  void _removerEscola(int id) {
    _controller.removerEscola(id);
    setState(() {});
  }

  Future<void> _confirmarRemocao(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Não permite fechar clicando fora do diálogo
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar exclusão'),
          content: Text('Você tem certeza que deseja excluir essa escola?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Excluir'),
              onPressed: () {
                _removerEscola(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gerenciar Escolas')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Formulário de cadastro
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nomeController,
                        decoration: InputDecoration(labelText: 'Nome'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _enderecoController,
                        decoration: InputDecoration(labelText: 'Endereço'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _telefoneController,
                        decoration: InputDecoration(labelText: 'Telefone'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          if (!RegExp(r'^\d{10,11}$').hasMatch(value)) {
                            return 'Telefone inválido';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _capacidadeController,
                        decoration: InputDecoration(labelText: 'Capacidade de alunos'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Capacidade inválida';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _faixaIdadeController,
                        decoration: InputDecoration(labelText: 'Faixa de idade'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;  // Permite qualquer string
                        },
                      ),

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
                        validator: (value) {
                          if (value == null) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
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
                        validator: (value) {
                          if (value == null) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
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
                        validator: (value) {
                          if (value == null) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
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
                        validator: (value) {
                          if (value == null) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _descricaoController,
                        decoration: InputDecoration(labelText: 'Descrição'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _adicionarEscola,
                        child: Text('Adicionar Escola'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Tabela de escolas
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
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Nome')),
                    DataColumn(label: Text('Endereço')),
                    DataColumn(label: Text('Telefone')),
                    DataColumn(label: Text('Capacidade')),
                    DataColumn(label: Text('Faixa de Idade')),
                    DataColumn(label: Text('Período')),
                    DataColumn(label: Text('Modalidade')),
                    DataColumn(label: Text('Referencial Nutricional')),
                    DataColumn(label: Text('Excluir')),
                  ],
                  rows: _controller.listarEscolas()
                      .where((escola) =>
                          escola.nome.contains(_pesquisaController.text))
                      .map((escola) {
                    return DataRow(cells: [
                      DataCell(Text(escola.nome)),
                      DataCell(Text(escola.endereco)),
                      DataCell(Text(escola.telefone)),
                      DataCell(Text(escola.capacidadeAlunos.toString())),
                      DataCell(Text(escola.faixaIdade)),
                      DataCell(Text(escola.periodo)),
                      DataCell(Text(escola.modalidade)),
                      DataCell(Text(escola.referencialNutricional)),
                      DataCell(IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _confirmarRemocao(escola.id);
                        },
                      )),
                    ]);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
