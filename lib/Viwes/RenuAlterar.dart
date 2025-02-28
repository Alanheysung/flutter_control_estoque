import 'package:flutter/material.dart';

class AlterarTela extends StatefulWidget {
  @override
  _AlterarTelaState createState() => _AlterarTelaState();
}

class _AlterarTelaState extends State<AlterarTela> {
  String? selectedValue = '10'; // valor inicial para o dropdown

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Alteração'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha à esquerda
          children: [
            // Linha de "Mostrar" e "Filtrar"
            Row(
              children: [
                // Exibindo "Mostrar" e a seta ao lado
                Text(
                  'Mostrar:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 10), // Espaçamento entre o texto e o dropdown
                DropdownButton<String>(
                  value: selectedValue,
                  icon: Icon(Icons.arrow_drop_down),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue;
                    });
                  },
                  items: <String>['10', '25', '50', '100']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Spacer(), // Para empurrar "Filtrar" para a direita
                // Texto "Filtrar"
                Text(
                  'Filtrar:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 10), // Espaçamento entre "Filtrar" e o TextField
                // TextField para o filtro
                Container(
                  width: 120, // Ajuste a largura do TextField
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Digite...',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // Espaçamento entre as seções
            // Exibindo "Nome" com um botão estreito abaixo
            Text(
              'Nome:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10), // Espaçamento entre o texto "Nome" e o botão
            ElevatedButton(
              onPressed: () {},
              child: Container(), // Botão vazio, sem texto
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Cor do botão
                minimumSize: Size(50, 30), // Botão estreito (largura de 50 e altura de 30)
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6), // Padding estreito
              ),
            ),
          ],
        ),
      ),
    );
  }
}









