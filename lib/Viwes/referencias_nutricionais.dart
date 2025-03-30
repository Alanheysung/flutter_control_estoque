import 'package:flutter/material.dart';
import '../Controllers/ReferenciasNutricionaisController.dart';
import '../Models/ReferenciasNutricionaisModel.dart';
import 'CadastrarValoresNutricionais.dart';

class ReferenciasNutricionaisTela extends StatefulWidget {
  @override
  _ReferenciasNutricionaisTelaState createState() =>
      _ReferenciasNutricionaisTelaState();
}

class _ReferenciasNutricionaisTelaState
  extends State<ReferenciasNutricionaisTela> {


    TextEditingController nomeController = TextEditingController();
TextEditingController descricaoController = TextEditingController();
TextEditingController nRefeicoesController = TextEditingController();
TextEditingController faixaIdadeController = TextEditingController();
TextEditingController periodoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _nomeKey = GlobalKey<FormFieldState>();
  final _descricaoKey = GlobalKey<FormFieldState>();

String _filtroPesquisa = ''; // Variável para armazenar o termo de pesquisa

  String? _numeroRefeicoes;
  String? _categoriaEnsino;
  String? _faixaIdade;
  String? _periodo;

  // Instância do controller
  final ReferenciasNutricionaisController _controller =
      ReferenciasNutricionaisController();

  // Lista para armazenar os dados cadastrados
  List<ReferenciasNutricionais> _referenciasCadastradas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Referência Nutricional'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Cadastrar referência nutricional',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                TextFormField(
                  key: _nomeKey,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome é obrigatório';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  key: _descricaoKey,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Descrição é obrigatória';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _numeroRefeicoes,
                        decoration: InputDecoration(
                          labelText: 'N° min de refeição',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          DropdownMenuItem(value: '1', child: Text('1')),
                          DropdownMenuItem(value: '2', child: Text('2')),
                          DropdownMenuItem(value: '3', child: Text('3')),
                          DropdownMenuItem(value: '4', child: Text('4')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _numeroRefeicoes = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Selecione uma opção';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _categoriaEnsino,
                        decoration: InputDecoration(
                          labelText: 'Categoria de Ensino',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          DropdownMenuItem(value: 'Creche', child: Text('Creche')),
                          DropdownMenuItem(
                              value: 'Pré-escola', child: Text('Pré-escola')),
                          DropdownMenuItem(
                              value: 'Ensino Fundamental',
                              child: Text('Ensino Fundamental')),
                          DropdownMenuItem(value: 'Ensino Médio', child: Text('Ensino Médio')),
                          DropdownMenuItem(value: 'EJAI', child: Text('EJAI')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _categoriaEnsino = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Selecione uma opção';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _faixaIdade,
                        decoration: InputDecoration(
                          labelText: 'Faixa de idade dos alunos',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          DropdownMenuItem(value: '1 - 3 anos', child: Text('1 - 3 anos')),
                          DropdownMenuItem(value: '4 - 5 anos', child: Text('4 - 5 anos')),
                          DropdownMenuItem(value: '6 - 10 anos', child: Text('6 - 10 anos')),
                          DropdownMenuItem(value: '7 - 11 anos', child: Text('7 - 11 anos')),
                          DropdownMenuItem(value: '11 - 15 anos', child: Text('11 - 15 anos')),
                          DropdownMenuItem(value: '16 - 18 anos', child: Text('16 - 18 anos')),
                          DropdownMenuItem(value: '19 - 70 anos', child: Text('19 - 70 anos')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _faixaIdade = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Selecione uma opção';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _periodo,
                        decoration: InputDecoration(
                          labelText: 'Período',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          DropdownMenuItem(value: 'Manhã', child: Text('Manhã')),
                          DropdownMenuItem(value: 'Tarde', child: Text('Tarde')),
                          DropdownMenuItem(value: 'Parcial', child: Text('Parcial')),
                          DropdownMenuItem(value: 'Integral', child: Text('Integral')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _periodo = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Selecione uma opção';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),

                // Botão "Cadastrar valores nutricionais"
                ElevatedButton(
                  onPressed: () {
                    // Navega para a tela "CadastrarValoresNutricionaisTela"
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CadastrarValoresNutricionaisTela(),
                      ),
                    );
                  },
                  child: Text('Cadastrar valores nutricionais'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),

                SizedBox(height: 12),

                // Botão "Cadastrar"
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Criação do modelo
                      final referencia = ReferenciasNutricionais(
                        nome: _nomeKey.currentState?.value ?? '',
                        descricao: _descricaoKey.currentState?.value ?? '',
                        nRefeicoes: int.tryParse(_numeroRefeicoes ?? '') ?? 0,
                        faixaIdade: _faixaIdade ?? '',
                        categoriaEnsino: _categoriaEnsino ?? '',
                        periodo: _periodo ?? '',
                      );

                      // Chama o controlador para adicionar a referência
                      bool sucesso = _controller.adicionarReferencia(referencia);

                      if (sucesso) {
                        setState(() {
                          _referenciasCadastradas.add(referencia);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Referência cadastrada com sucesso!')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Já existe uma referência com esse nome.')),
                        );
                      }
                    }
                  },
                  child: Text('Cadastrar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),

                SizedBox(height: 20),
// Campo de busca
TextFormField(
  decoration: InputDecoration(
    labelText: 'Pesquisar',
    prefixIcon: Icon(Icons.search),
    border: OutlineInputBorder(),
  ),
  onChanged: (value) {
    setState(() {
      _filtroPesquisa = value;
    });
  },
),
SizedBox(height: 12),

                // Tabela de referências nutricionais cadastradas
                // Tabela de referências nutricionais cadastradas


                DataTable(
                  columns: [
                    DataColumn(label: Text('Nome')),
                    DataColumn(label: Text('Descrição')),
                    DataColumn(label: Text('N° Refeições')),
                    DataColumn(label: Text('Categoria')),
                    DataColumn(label: Text('Faixa Idade')),
                    DataColumn(label: Text('Período')),
                    DataColumn(label: Text('Ações')), // Coluna de Ações (Botões)
                  ],
                  rows: _referenciasCadastradas
    .where((referencia) =>
        referencia.nome.toLowerCase().contains(_filtroPesquisa.toLowerCase()) ||
        referencia.descricao.toLowerCase().contains(_filtroPesquisa.toLowerCase()))
    .map((referencia) {

                    return DataRow(cells: [
                      DataCell(Text(referencia.nome)),
                      DataCell(Text(referencia.descricao)),
                      DataCell(Text(referencia.nRefeicoes.toString())),
                      DataCell(Text(referencia.categoriaEnsino)),
                      DataCell(Text(referencia.faixaIdade)),
                      DataCell(Text(referencia.periodo)),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                // Lógica para editar a referência
                                // Exemplo: Abre a tela de edição
                                _editarReferencia(referencia);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // Lógica para excluir a referência
                                _excluirReferencia(referencia);
                              },
                            ),
                          ],
                        ),
                      ),
                    ]);
                  }).toList(),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
  // Função para excluir a referência
void _excluirReferencia(ReferenciasNutricionais referencia) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Confirmar Exclusão'),
        content: Text('Tem certeza de que deseja excluir esta referência nutricional?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Fecha o diálogo sem fazer nada
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // Remove a referência após confirmação
              bool sucesso = _controller.removerReferencia(referencia.nome);
              if (sucesso) {
                setState(() {
                  _referenciasCadastradas.remove(referencia); // Remove da lista
                });

                Navigator.pop(context); // Fecha o diálogo
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Referência excluída com sucesso!')),
                );
              } else {
                Navigator.pop(context); // Fecha o diálogo
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Falha ao excluir a referência!')),
                );
              }
            },
            child: Text('Confirmar'),
          ),
        ],
      );
    },
  );
}


void _editarReferencia(ReferenciasNutricionais referencia) {
  // Variáveis temporárias para os campos de edição
  String nomeTemp = referencia.nome;
  String descricaoTemp = referencia.descricao;
  String? numeroRefeicoesTemp = referencia.nRefeicoes.toString();
  String? categoriaEnsinoTemp = referencia.categoriaEnsino;
  String? faixaIdadeTemp = referencia.faixaIdade.toString();  // Verifique aqui, convertendo para string
  String? periodoTemp = referencia.periodo;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Editar Referência'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Nome
              TextFormField(
                initialValue: referencia.nome,
                decoration: InputDecoration(labelText: 'Nome'),
                onChanged: (value) => nomeTemp = value,
              ),
              // Descrição
              TextFormField(
                initialValue: referencia.descricao,
                decoration: InputDecoration(labelText: 'Descrição'),
                onChanged: (value) => descricaoTemp = value,
              ),
              // Número de refeições
              DropdownButtonFormField<String>(
                value: numeroRefeicoesTemp,
                decoration: InputDecoration(labelText: 'Número de Refeições'),
                items: [
                  DropdownMenuItem(value: '1', child: Text('1')),
                  DropdownMenuItem(value: '2', child: Text('2')),
                  DropdownMenuItem(value: '3', child: Text('3')),
                  DropdownMenuItem(value: '4', child: Text('4')),
                ],
                onChanged: (value) {
                  numeroRefeicoesTemp = value;
                },
              ),
              // Faixa de idade
              DropdownButtonFormField<String>(
                value: faixaIdadeTemp,
                decoration: InputDecoration(labelText: 'Faixa de Idade'),
                items: [
                  DropdownMenuItem(value: '1 - 3 anos', child: Text('1 - 3 anos')),
                  DropdownMenuItem(value: '4 - 5 anos', child: Text('4 - 5 anos')),
                  DropdownMenuItem(value: '6 - 10 anos', child: Text('6 - 10 anos')),
                  DropdownMenuItem(value: '7 - 11 anos', child: Text('7 - 11 anos')),
                  DropdownMenuItem(value: '11 - 15 anos', child: Text('11 - 15 anos')),
                  DropdownMenuItem(value: '16 - 18 anos', child: Text('16 - 18 anos')),
                  DropdownMenuItem(value: '19 - 70 anos', child: Text('19 - 70 anos')),
                ],
                onChanged: (value) {
                  faixaIdadeTemp = value;
                },
              ),
              // Categoria de Ensino
              DropdownButtonFormField<String>(
                value: categoriaEnsinoTemp,
                decoration: InputDecoration(labelText: 'Categoria de Ensino'),
                items: [
                  DropdownMenuItem(value: 'Creche', child: Text('Creche')),
                  DropdownMenuItem(value: 'Pré-escola', child: Text('Pré-escola')),
                  DropdownMenuItem(value: 'Ensino Fundamental', child: Text('Ensino Fundamental')),
                  DropdownMenuItem(value: 'Ensino Médio', child: Text('Ensino Médio')),
                  DropdownMenuItem(value: 'EJAI', child: Text('EJAI')),
                ],
                onChanged: (value) {
                  categoriaEnsinoTemp = value;
                },
              ),
              // Período
              DropdownButtonFormField<String>(
                value: periodoTemp,
                decoration: InputDecoration(labelText: 'Período'),
                items: [
                  DropdownMenuItem(value: 'Manhã', child: Text('Manhã')),
                  DropdownMenuItem(value: 'Tarde', child: Text('Tarde')),
                  DropdownMenuItem(value: 'Parcial', child: Text('Parcial')),
                  DropdownMenuItem(value: 'Integral', child: Text('Integral')),
                ],
                onChanged: (value) {
                  periodoTemp = value;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Cria o novo objeto de referência com os dados alterados
              ReferenciasNutricionais referenciaAtualizada = ReferenciasNutricionais(
                nome: nomeTemp,
                descricao: descricaoTemp,
                nRefeicoes: int.tryParse(numeroRefeicoesTemp ?? '') ?? 0,
                faixaIdade: faixaIdadeTemp ?? '',  // Alterado para string
                categoriaEnsino: categoriaEnsinoTemp ?? '',
                periodo: periodoTemp ?? '',
              );

              // Chama o método de atualização no controlador
              bool sucesso = _controller.atualizarReferencia(
                referencia.nome, // Nome original para identificar
                referenciaAtualizada,
              );

              if (sucesso) {
                setState(() {
                  // Atualiza a referência na lista
                  var index = _referenciasCadastradas.indexWhere((r) => r.nome == referencia.nome);
                  if (index != -1) {
                    _referenciasCadastradas[index] = referenciaAtualizada;
                  }
                });

                Navigator.pop(context); // Fecha o diálogo
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Referência atualizada com sucesso!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Falha ao atualizar a referência!')),
                );
              }
            },
            child: Text('Salvar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Fecha o diálogo
            },
            child: Text('Cancelar'),
          ),
        ],
      );
    },
  );
}

}