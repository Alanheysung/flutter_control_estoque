import 'package:flutter/material.dart';
import 'CadastrarPreparação.dart';
import 'Alterar_consultarPreparação.dart';
import 'Cadastrar_grupoPreparação.dart';
import 'Alterar_grupoPreparacao.dart';

class Preparacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green, // Cor de fundo do AppBar
        title: Text("Tela Preparação", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true, // Centraliza o título
        elevation: 10, // Adiciona uma sombra no AppBar
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Cor de fundo do botão
                  minimumSize: Size(250, 60), // Tamanho do botão
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Estilo do texto
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // Bordas arredondadas
                  shadowColor: Colors.black.withOpacity(0.4), // Cor da sombra
                  elevation: 5, // Sombra
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastrarScreen()),
                  );
                },
                icon: Icon(Icons.add, size: 24), // Ícone para o botão
                label: Text("Cadastrar"),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Cor de fundo
                  minimumSize: Size(250, 60),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  shadowColor: Colors.black.withOpacity(0.4),
                  elevation: 5,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AlterarConsultarScreen()),
                  );
                },
                icon: Icon(Icons.search, size: 24),
                label: Text("Alterar/Consultar"),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Cor de fundo
                  minimumSize: Size(250, 60),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  shadowColor: Colors.black.withOpacity(0.4),
                  elevation: 5,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastrarGrupoScreen()),
                  );
                },
                icon: Icon(Icons.group_add, size: 24),
                label: Text("Cadastrar Grupo"),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700], // Cor de fundo
                  minimumSize: Size(250, 60),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  shadowColor: Colors.black.withOpacity(0.4),
                  elevation: 5,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AlterarGrupoScreen()),
                  );
                },
                icon: Icon(Icons.group, size: 24),
                label: Text("Alterar Grupo"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
