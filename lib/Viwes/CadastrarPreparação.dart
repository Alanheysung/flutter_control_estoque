import 'package:flutter/material.dart';

class CadastrarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título da tela
            Text(
              'Cadastrar Preparação',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16), // Espaço entre o título e os campos de entrada

            // Row para colocar os campos de texto lado a lado
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Descrição',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Grupo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // Espaço antes das opções de caixinhas de texto

            // Texto para instruir o usuário a escolher as opções
            Text(
              'Adicionar ingredientes:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),

            // Row para agrupar as caixinhas de texto em dois por linha
            Column(
              children: [
                // Primeira linha de caixinhas de texto
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Fonte de Informações Nutricionais',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // Espaço entre as caixinhas
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Item',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10), // Espaço entre as linhas

                // Segunda linha de caixinhas de texto
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Medida',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // Espaço entre as caixinhas
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'PC Bruto',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20), // Espaço antes das caixinhas "PC Líquido" e "FC"

            // Row para agrupar as caixinhas de texto "PC Líquido" e "FC"
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'PC Líquido',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10), // Espaço entre as caixinhas
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'FC',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // Espaço antes do botão "Adicionar à Lista"

            // Botão "Adicionar à Lista"
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Aqui você pode adicionar a lógica para adicionar à lista
                  print("Adicionado à lista");
                },
                child: Text('Adicionar à Lista'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
