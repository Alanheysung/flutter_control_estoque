import 'package:flutter/material.dart';

// Tela Cardápio
class Cardapio extends StatelessWidget {
  DateTime? dataInicial;
  DateTime? dataFinal;

  // Função para exibir o DatePicker para selecionar a Data Inicial
  Future<void> _selecionarDataInicial(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      // Atualize a UI aqui (você pode passar um retorno para outro widget)
    }
  }

  // Função para exibir o DatePicker para selecionar a Data Final
  Future<void> _selecionarDataFinal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      // Atualize a UI aqui (você pode passar um retorno para outro widget)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tela Cardápio")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Novo Cardápio",
              style: TextStyle(
                fontSize: 22, 
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _buildCampoTexto("Nome:"),
            _buildCampoTexto("Descrição:"),
            _buildCampoTexto("Destino:"),
            SizedBox(height: 10),
            Text("Data Inicial:", style: TextStyle(fontSize: 18)),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _selecionarDataInicial(context),
                  child: Text(dataInicial == null ? "Selecionar Data" : "${dataInicial!.day}/${dataInicial!.month}/${dataInicial!.year}"),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text("Data Final:", style: TextStyle(fontSize: 18)),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _selecionarDataFinal(context),
                  child: Text(dataFinal == null ? "Selecionar Data" : "${dataFinal!.day}/${dataFinal!.month}/${dataFinal!.year}"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Função para construir os campos de texto
  Widget _buildCampoTexto(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 18)),
        TextField(
          decoration: InputDecoration(
            hintText: "Digite $label",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
