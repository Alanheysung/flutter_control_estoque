import 'package:flutter/material.dart';

class AlterarConsultar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alterar/Consultar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Alinha ao topo
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha os widgets à esquerda
          children: [
            // Texto de boas-vindas
            Text(
              'Alterar Alimentos',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),  // Espaçamento entre o texto e as caixas de texto

            // Caixa de texto para o "Nome"
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),  // Espaçamento entre as caixas de texto

            // Caixa de texto para o "Grupo"
            TextField(
              decoration: InputDecoration(
                labelText: 'Grupo',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

