import 'package:flutter/material.dart';
import 'CadastrarAlimento.dart';
import 'Alterar_Consultaalimento.dart';
import 'Cadastrar_Grupoalimento.dart';
import 'Alterar_Grupoalimento.dart';
import 'alterar_fonte.dart';
import 'CadastrarFonte.dart';

class CadastroAlimentos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alimentos'),
        backgroundColor: Colors.green, // Cor da AppBar verde
      ),
      backgroundColor: Colors.white, // Cor de fundo da tela branca
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // Centraliza os itens horizontalmente
            children: [
              _buildButton(
                context, 
                'Cadastrar', 
                Cadastrar(), 
                Icons.add, 
                Colors.green // Cor verde para o botão
              ),
              SizedBox(height: 20),
              _buildButton(
                context, 
                'Alterar/Consultar', 
                AlterarConsultar(), 
                Icons.search, 
                Colors.green // Cor verde para o botão
              ),
              SizedBox(height: 20),
              _buildButton(
                context, 
                'Cadastrar Grupo', 
                CadastrarGrupo(), 
                Icons.group_add, 
                Colors.green // Cor verde para o botão
              ),
              SizedBox(height: 20),
              _buildButton(
                context, 
                'Alterar Grupo', 
                AlterarGrupo(), 
                Icons.group, 
                Colors.green // Cor verde para o botão
              ),
              SizedBox(height: 20),
              _buildButton(
                context, 
                'Cadastrar fonte', 
                Cadastrarfonte(), 
                Icons.edit, 
                Colors.green // Cor verde para o botão
              ),
               SizedBox(height: 20),
              _buildButton(
                context, 
                'Alterar fonte', 
                AlterarFonte(), 
                Icons.edit, 
                Colors.green
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para gerar os botões com estilo e ícone
  Widget _buildButton(
      BuildContext context, String text, Widget page, IconData icon, Color color) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        backgroundColor: color, // Cor verde para o botão
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Borda arredondada
        ),
        textStyle: TextStyle(fontSize: 18, color: Colors.white), // Cor do texto branco
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      icon: Icon(icon, size: 30, color: Colors.white), // Ícone branco
      label: Text(text),
    );
  }
}
