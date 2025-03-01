import 'package:flutter/material.dart';

class CadastrarRefeicao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Variáveis para armazenar os valores dos campos
    String nome = '';
    String descricao = '';
    String horario = '';

    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Refeição')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Caixa de texto para o nome
            TextField(
              onChanged: (value) {
                nome = value; // Atualiza o valor de 'nome' quando o usuário digita
              },
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            
            // Caixa de texto para a descrição
            TextField(
              onChanged: (value) {
                descricao = value; // Atualiza o valor de 'descricao' quando o usuário digita
              },
              decoration: InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            
            // Caixa de texto para o horário
            TextField(
              onChanged: (value) {
                horario = value; // Atualiza o valor de 'horario' quando o usuário digita
              },
              decoration: InputDecoration(
                labelText: 'Horário',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            
            // Botão para cadastrar
            ElevatedButton(
              onPressed: () {
                // Exemplo de lógica para "Cadastrar" sem usar TextEditingController
                print('Nome: $nome');
                print('Descrição: $descricao');
                print('Horário: $horario');
                
                // Exemplo de exibição de mensagem
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Cadastro Realizado'),
                    content: Text('Refeição $nome cadastrada com sucesso!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
