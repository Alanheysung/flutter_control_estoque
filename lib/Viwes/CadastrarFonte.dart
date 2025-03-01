import 'package:flutter/material.dart';

class Cadastrarfonte extends StatefulWidget {
  @override
  _Cadastrarfonte createState() => _Cadastrarfonte();
}

class _Cadastrarfonte extends State<Cadastrarfonte> {
  String _nome = '';
  String _descricao = '';
 // String _fontFamily = 'Roboto';  // Fonte padrão

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Fonte')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Mensagem de cabeçalho
              Text(
                'Cadastrar fonte de informações nutricionais',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),

              // Caixa de texto para o "Nome"
              TextField(
                onChanged: (text) {
                  setState(() {
                    _nome = text; // Atualiza o nome conforme o texto
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Nome',
                  hintText: 'Digite o nome da fonte',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Caixa de texto para a "Descrição"
              TextField(
                onChanged: (text) {
                  setState(() {
                    _descricao = text; // Atualiza a descrição conforme o texto
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  hintText: 'Digite a descrição da fonte',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Botão para aplicar as alterações
              ElevatedButton(
                onPressed: () {
                  // Ação para alterar ou salvar os dados (por enquanto só exibe)
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Informações Cadastradas'),
                        content: Text(
                          'Nome: $_nome\nDescrição: $_descricao',
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Fechar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Cadastrar'),
              ),
              SizedBox(height: 20),

              // Texto de exemplo com a fonte alterada
              
                
              
            ],
          ),
        ),
      ),
    );
  }
}
