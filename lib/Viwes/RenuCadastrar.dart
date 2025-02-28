
import 'package:flutter/material.dart';
import 'CadastrarValoresNutricionais.dart'; // Não se esqueça de importar a nova tela

class CadastrarTela extends StatefulWidget {
  @override
  _CadastrarTelaState createState() => _CadastrarTelaState();
}

class _CadastrarTelaState extends State<CadastrarTela> {
  final _formKey = GlobalKey<FormState>(); // Para gerenciar a validação do formulário
  final _nomeKey = GlobalKey<FormFieldState>(); // Para validar o campo nome
  final _descricaoKey = GlobalKey<FormFieldState>(); // Para validar o campo descrição

  String? _numeroRefeicoes; // Variável para armazenar o número de refeições selecionado
  String? _categoriaEnsino; // Variável para armazenar a categoria de ensino selecionada
  String? _faixaIdade; // Variável para armazenar a faixa de idade selecionada
  String? _periodo; // Variável para armazenar o período selecionado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Cadastro'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0), // Reduzi o padding geral para diminuir o espaço
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Alinhar os widgets no topo
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Cadastrar referência nutricional',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Reduzi o tamanho da fonte
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12), // Reduzi o espaço entre os elementos
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
              SizedBox(height: 12), // Reduzi o espaço entre os campos
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
              SizedBox(height: 12), // Reduzi o espaço entre os campos

              // Row para colocar "N° min de refeição" ao lado de "Categoria de Ensino"
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
                        DropdownMenuItem(
                          value: '1',
                          child: Text('1'),
                        ),
                        DropdownMenuItem(
                          value: '2',
                          child: Text('2'),
                        ),
                        DropdownMenuItem(
                          value: '3',
                          child: Text('3'),
                        ),
                        DropdownMenuItem(
                          value: '4',
                          child: Text('4'),
                        ),
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
                  SizedBox(width: 12), // Espaço entre os dois campos
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _categoriaEnsino,
                      decoration: InputDecoration(
                        labelText: 'Categoria de Ensino', 
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'Creche',
                          child: Text('Creche'),
                        ),
                        DropdownMenuItem(
                          value: 'Pré-escola',
                          child: Text('Pré-escola'),
                        ),
                        DropdownMenuItem(
                          value: 'Ensino Fundamental',
                          child: Text('Ensino Fundamental'),
                        ),
                        DropdownMenuItem(
                          value: 'Ensino Médio',
                          child: Text('Ensino Médio'),
                        ),
                        DropdownMenuItem(
                          value: 'EJAI',
                          child: Text('EJAI'),
                        ),
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
              SizedBox(height: 12), // Reduzi o espaço entre os campos
              
              // Row para colocar "Faixa de idade" e "Período" lado a lado
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _faixaIdade,
                      decoration: InputDecoration(
                        labelText: 'Faixa de idade dos Alunos', 
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: '6 - 10 anos',
                          child: Text('6 - 10 anos'),
                        ),
                        DropdownMenuItem(
                          value: '11 - 15 anos',
                          child: Text('11 - 15 anos'),
                        ),
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
                  SizedBox(width: 12), // Espaço entre os dois campos
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _periodo,
                      decoration: InputDecoration(
                        labelText: 'Período', 
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'Parcial',
                          child: Text('Parcial'),
                        ),
                        DropdownMenuItem(
                          value: 'Integral',
                          child: Text('Integral'),
                        ),
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
              SizedBox(height: 12), // Reduzi o espaço entre os campos
              
              // Botão "Cadastrar valores nutricionais" agora abre outra tela
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
                  backgroundColor: Colors.blue, // Cor diferente para o botão
                  padding: EdgeInsets.symmetric(vertical: 10), // Altura do botão
                ),
              ),
              
              SizedBox(height: 12), // Espaço entre os botões
              
              // Botão "Cadastrar"
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Aqui você pode pegar os valores diretamente
                    final nome = _nomeKey.currentState?.value;
                    final descricao = _descricaoKey.currentState?.value;
                    // Tratar o processo de cadastro aqui
                    print('Nome: $nome');
                    print('Descrição: $descricao');
                    print('Número de refeições: $_numeroRefeicoes');
                    print('Categoria de ensino: $_categoriaEnsino');
                    print('Faixa de idade: $_faixaIdade');
                    print('Período: $_periodo');
                  }
                },
                child: Text('Cadastrar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 10), // Reduzi a altura do botão
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
