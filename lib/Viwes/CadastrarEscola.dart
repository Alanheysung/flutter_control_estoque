import 'package:flutter/material.dart';

class Cadastrarescola extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela Alterar/Consultar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(  // Adicionando para poder rolar a tela se houver muitos campos
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cadastrar Escola",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              
              // Campo Nome
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nome da Escola',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              
              // Campo Descrição
              TextField(
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              
              // Campo Adicionar Modalidade
              TextField(
                decoration: InputDecoration(
                  labelText: 'Adicionar Modalidade',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              
              // Campo Faixa de Idade
              TextField(
                decoration: InputDecoration(
                  labelText: 'Faixa de Idade',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              
              // Campo Período
              TextField(
                decoration: InputDecoration(
                  labelText: 'Período',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              
              // Campo Número de Refeições Ofertadas
              TextField(
                decoration: InputDecoration(
                  labelText: 'Número de Refeições Ofertadas',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,  // Espera um número
              ),
              SizedBox(height: 10),
              
              // Campo Referência Nutricional
              TextField(
                decoration: InputDecoration(
                  labelText: 'Referência Nutricional',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              
              // Campo Número de Alunos
              TextField(
                decoration: InputDecoration(
                  labelText: 'Número de Alunos',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,  // Espera um número
              ),
              SizedBox(height: 20),
              
              // Botão de Enviar
              ElevatedButton(
                onPressed: () {
                  // Lógica para processar as informações do formulário
                },
                child: Text("Adicionar a lista"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
