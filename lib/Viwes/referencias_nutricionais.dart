import 'package:flutter/material.dart';
import 'RenuCadastrar.dart';
import 'RenuAlterar.dart';

class ReferenciasNutricionais extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Referências Nutricionais'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Botão "Cadastrar"
            ElevatedButton(
              onPressed: () {
                // Navegação para a tela de Cadastro
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CadastrarTela()),
                );
              },
              child: Text('Cadastrar'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
            SizedBox(height: 10), // Espaço entre os botões
            // Botão "Alterar"
            ElevatedButton(
              onPressed: () {
                // Navegação para a tela de Alteração
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AlterarTela()),
                );
              },
              child: Text('Alterar'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


