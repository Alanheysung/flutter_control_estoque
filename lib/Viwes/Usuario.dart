import 'package:flutter/material.dart';
import  '../Controllers/ProdutoController.dart';


class UsuarioScreen extends StatefulWidget {
  @override
  _UsuarioScreenState createState() => _UsuarioScreenState();
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController = TextEditingController();
  String? profissaoSelecionada;
  String? escolaSelecionada;

  //CadastroUsuario u = CadastroUsuario();



  final List<String> profissoes = [
    'Cozinheira',
    'Nutricionista',
    'Gestora'
  ];

  final List<String> escolas = [
    'Escola A',
    'Escola B',
    'Escola C',
    'Escola D',
    'Escola E'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Usuário')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: usuarioController,
              decoration: InputDecoration(labelText: 'Nome de usuário'),
            ),
            TextField(
              controller: cpfController,
              decoration: InputDecoration(labelText: 'CPF'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
             TextField(
              controller: telefoneController,
              decoration: InputDecoration(labelText: 'Telefone'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            TextField(
              controller: confirmarSenhaController,
              decoration: InputDecoration(labelText: 'Confirmar Senha'),
              obscureText: true,
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Profissão'),
              value: profissaoSelecionada,
              items: profissoes.map((profissao) {
                return DropdownMenuItem(
                  value: profissao,
                  child: Text(profissao),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  profissaoSelecionada = value;
                });
              },
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Escola onde trabalha'),
              value: escolaSelecionada,
              items: escolas.map((escola) {
                return DropdownMenuItem(
                  value: escola,
                  child: Text(escola),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  escolaSelecionada = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //u.cadastro(nomeController.text, usuarioController.text, cpfController.text, senhaController.text, 
                //telefoneController.text, emailController.text/, profissaoSelecionada, escolaSelecionada/);
                
                // print('Nome: ${nomeController.text}');
                // print('Usuário: ${usuarioController.text}');
                // print('CPF: ${cpfController.text}');
                // print('Email: ${emailController.text}');
                // print('Senha: ${senhaController.text}');
                // print('Telefone: ${telefoneController.text}');
                // print('Profissão: $profissaoSelecionada');
                // print('Escola: $escolaSelecionada');
                
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}