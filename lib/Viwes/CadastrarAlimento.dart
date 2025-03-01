import 'package:flutter/material.dart';
import 'cadastrar_valores_nutricionais.dart';
import 'cadastrar_porcoes.dart';

class Cadastrar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tela de Cadastrar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campo de texto para o nome (maior)
              Container(
                width: double.infinity, // Aumenta a largura da caixa
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Digite seu nome',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0), // Aumenta o padding para deixar maior
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Campo de texto para o grupo (maior)
              Container(
                width: double.infinity, // Aumenta a largura da caixa
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Digite o nome do grupo',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Campo de texto para a fonte de informação nutricional (maior)
              Container(
                width: double.infinity, // Aumenta a largura da caixa
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Fonte de Informação Nutricional',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Campo de texto para a medida base (maior)
              Container(
                width: double.infinity, // Aumenta a largura da caixa
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Medida Base',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Campo de texto para o preço (maior)
              Container(
                width: double.infinity, // Aumenta a largura da caixa
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Preço',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Botões de navegação
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navegar para a tela "Cadastrar Valores Nutricionais"
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CadastrarValoresNutricionais(),
                        ),
                      );
                    },
                    child: Text('Cadastrar Valores Nutricionais'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navegar para a tela "Cadastrar Porções"
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CadastrarPorcoes(),
                        ),
                      );
                    },
                    child: Text('Cadastrar Porções'),
                  ),
                ],
              ),

              // Novo botão "Cadastrar" (maior)
              SizedBox(height: 20),
              Container(
                width: double.infinity, // Faz o botão ocupar toda a largura
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0), // Aumenta a altura do botão
                    textStyle: TextStyle(fontSize: 20), // Aumenta o tamanho do texto
                   // primary: Colors.blue, // Cor de fundo (opcional)
                  ),
                  onPressed: () {
                    // Aqui você pode adicionar a lógica para "Cadastrar" os dados
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Cadastro Realizado'),
                          content: Text('Os dados foram cadastrados com sucesso!'),
                          actions: [
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}



