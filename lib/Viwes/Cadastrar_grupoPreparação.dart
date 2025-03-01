import 'package:flutter/material.dart';

class CadastrarGrupoScreen extends StatefulWidget {
  @override
  _CadastrarGrupoScreenState createState() => _CadastrarGrupoScreenState();
}

class _CadastrarGrupoScreenState extends State<CadastrarGrupoScreen> {
  String nome = '';
  String descricao = '';

  void _cadastrarGrupo() {
    // Lógica para cadastro do grupo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Grupo "$nome" cadastrado!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela Cadastrar Grupo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  nome = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Nome do Grupo',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) {
                setState(() {
                  descricao = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Descrição do Grupo',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _cadastrarGrupo,
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}

