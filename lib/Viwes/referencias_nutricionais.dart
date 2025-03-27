import 'package:flutter/material.dart';
import '../Controllers/ReferenciasNutricionaisController.dart'; // Importe o controlador
import '../Models/ReferenciasNutricionaisModel.dart'; // Importe o modelo
import 'CadastrarValoresNutricionais.dart'; // Importe a tela de Cadastrar Valores Nutricionais

class ReferenciasNutricionaisTela extends StatefulWidget {
  @override
  _ReferenciasNutricionaisTelaState createState() =>
      _ReferenciasNutricionaisTelaState();
}

class _ReferenciasNutricionaisTelaState
    extends State<ReferenciasNutricionaisTela> {
  final _formKey = GlobalKey<FormState>();
  final _nomeKey = GlobalKey<FormFieldState>();
  final _descricaoKey = GlobalKey<FormFieldState>();

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
      body: Padding(
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
                      faixaIdade: int.tryParse(_faixaIdade ?? '') ?? 0,
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

              // Tabela de referências nutricionais cadastradas
              DataTable(
                columns: [
                  DataColumn(label: Text('Nome')),
                  DataColumn(label: Text('Descrição')),
                  DataColumn(label: Text('N° Refeições')),
                  DataColumn(label: Text('Categoria')),
                  DataColumn(label: Text('Faixa Idade')),
                  DataColumn(label: Text('Período')),
                ],
                rows: _referenciasCadastradas
                    .map((referencia) => DataRow(cells: [
                          DataCell(Text(referencia.nome)),
                          DataCell(Text(referencia.descricao)),
                          DataCell(Text(referencia.nRefeicoes.toString())),
                          DataCell(Text(referencia.categoriaEnsino)),
                          DataCell(Text(referencia.faixaIdade.toString())),
                          DataCell(Text(referencia.periodo)),
                        ]))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
