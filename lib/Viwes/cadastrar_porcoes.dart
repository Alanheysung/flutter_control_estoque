import 'package:flutter/material.dart';

class CadastrarPorcoes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Porções')),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adiciona um padding ao redor
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha os elementos à esquerda
          children: [
            Container(
              alignment: Alignment.topLeft, // Alinha "Adicionar porções" à esquerda
              padding: const EdgeInsets.only(bottom: 16.0),  // Adiciona espaço abaixo do título
              child: Text(
                'Adicionar porções',
                style: TextStyle(
                  fontSize: 24,  // Ajuste o tamanho da fonte conforme necessário
                  fontWeight: FontWeight.bold,  // Torna o texto em negrito
                ),
              ),
            ),
            // Caixinha "Nome da medida"
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome da medida',
                border: OutlineInputBorder(), // Borda para a caixinha
              ),
            ),
            SizedBox(height: 16), // Espaço entre os campos
            // Caixinha "Quantidade"
            TextField(
              decoration: InputDecoration(
                labelText: 'Quantidade',
                border: OutlineInputBorder(), // Borda para a caixinha
              ),
              keyboardType: TextInputType.number, // Tipo de entrada numérica
            ),
            SizedBox(height: 16), // Espaço entre os campos e o botão
            // Botão "Adicionar à lista"
            ElevatedButton(
              onPressed: () {
                // Ação do botão pode ser definida aqui
                print('Porção adicionada à lista!');
              },
              child: Text('Adicionar à lista'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Define a largura e altura do botão
                textStyle: TextStyle(fontSize: 18), // Ajusta o tamanho do texto do botão
              ),
            ),
          ],
        ),
      ),
    );
  }
}



