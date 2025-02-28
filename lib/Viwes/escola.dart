import 'package:flutter/material.dart';

class Escola extends StatefulWidget {
  @override
  _EscolaState createState() => _EscolaState();
}

class _EscolaState extends State<Escola> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController numeroAlunosController = TextEditingController();

  String? categoria;
  String? faixaEtaria;
  String? periodo;
  String? refeicoes;
  String? referenciaNutricional;

  List<Map<String, String>> escolas = [];

  void salvarEscola() {
    if (nomeController.text.isEmpty ||
        descricaoController.text.isEmpty ||
        numeroAlunosController.text.isEmpty ||
        categoria == null ||
        faixaEtaria == null ||
        periodo == null ||
        refeicoes == null ||
        referenciaNutricional == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos antes de salvar.')),
      );
      return;
    }
    
    setState(() {
      escolas.add({
        'Nome': nomeController.text,
        'Descrição': descricaoController.text,
        'Categoria': categoria!,
        'Faixa Etária': faixaEtaria!,
        'Período': periodo!,
        'Refeições': refeicoes!,
        'Referência Nutricional': referenciaNutricional!,
        'Nº de Alunos': numeroAlunosController.text,
      });
      nomeController.clear();
      descricaoController.clear();
      numeroAlunosController.clear();
      categoria = null;
      faixaEtaria = null;
      periodo = null;
      refeicoes = null;
      referenciaNutricional = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Escola')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome da Escola'),
            ),
            TextField(
              controller: descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            DropdownButtonFormField(
              value: categoria,
              items: ['Creche', 'Fundamental', 'Ensino Médio', 'Superior']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => categoria = value as String?),
              decoration: InputDecoration(labelText: 'Categoria'),
            ),
            DropdownButtonFormField(
              value: faixaEtaria,
              items: ['2-5', '5-11', '11-15', '15-18']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => faixaEtaria = value as String?),
              decoration: InputDecoration(labelText: 'Faixa de Idade'),
            ),
            DropdownButtonFormField(
              value: periodo,
              items: [
                'Matutino',
                'Vespertino',
                'Noturno',
                'Matutino e Vespertino',
                'Integral'
              ].map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => periodo = value as String?),
              decoration: InputDecoration(labelText: 'Período'),
            ),
            DropdownButtonFormField(
              value: refeicoes,
              items: ['Uma', 'Duas', 'Três', 'Quatro']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => refeicoes = value as String?),
              decoration: InputDecoration(labelText: 'Nº de Refeições'),
            ),
            DropdownButtonFormField(
              value: referenciaNutricional,
              items: ['A', 'B', 'C', 'D']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => referenciaNutricional = value as String?),
              decoration: InputDecoration(labelText: 'Referência Nutricional'),
            ),
            TextField(
              controller: numeroAlunosController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Nº de Alunos'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: salvarEscola,
              child: Text('Salvar Escola'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Nome')),
                    DataColumn(label: Text('Descrição')),
                    DataColumn(label: Text('Categoria')),
                    DataColumn(label: Text('Faixa Etária')),
                    DataColumn(label: Text('Período')),
                    DataColumn(label: Text('Refeições')),
                    DataColumn(label: Text('Referência Nutricional')),
                    DataColumn(label: Text('Nº de Alunos')),
                  ],
                  rows: escolas
                      .map(
                        (e) => DataRow(cells: [
                          DataCell(Text(e['Nome']!)),
                          DataCell(Text(e['Descrição']!)),
                          DataCell(Text(e['Categoria']!)),
                          DataCell(Text(e['Faixa Etária']!)),
                          DataCell(Text(e['Período']!)),
                          DataCell(Text(e['Refeições']!)),
                          DataCell(Text(e['Referência Nutricional']!)),
                          DataCell(Text(e['Nº de Alunos']!)),
                        ]),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}