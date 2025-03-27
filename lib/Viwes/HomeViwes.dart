import 'package:flutter/material.dart';
import 'package:flutter_control_estoque/Viwes/Usuario.dart';
import 'cardapio.dart';
import 'escola.dart';
import 'referencias_nutricionais.dart';
import 'preparacao.dart';
import 'Alimento.dart';
import 'Relatorio.dart';
import 'Refeicao.dart';

class HomeViews extends StatefulWidget {
  @override
  _HomeViewsState createState() => _HomeViewsState();
}

class _HomeViewsState extends State<HomeViews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf1f8e9), // Cor de fundo mais suave
      appBar: AppBar(
        backgroundColor: Colors.green[700], // Cor mais forte para o AppBar
        title: Text(
          'Nutri',
          style: TextStyle(
            fontSize: 22,  
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView( // Permite rolar caso o conteúdo ultrapasse a tela
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Espaço nas laterais
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton('Escola', EscolaView(), Icons.school),
                  _buildButton('Cardápio', CadastrarCardapio(), Icons.restaurant_menu),
                  _buildButton('Referências Nutricionais', ReferenciasNutricionaisTela(), Icons.library_books),
                  _buildButton('Preparação', PreparacaoPage(), Icons.kitchen),
                  _buildButton('Alimentos', AlimentosScreen(), Icons.fastfood),
                  _buildButton('Refeição', RefeicoesPage(), Icons.restaurant),
                  _buildButton('Relatório', Relatorio(), Icons.analytics),
                  _buildButton('Usuário', UsuarioScreen(), Icons.person),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String title, Widget screen, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 24, color: Colors.green[700]), // Ícone estilizado
        label: Text(
          title,
          style: TextStyle(
            fontSize: 18,  
            fontWeight: FontWeight.w600,
            color: Colors.green[700], // Cor do texto
            letterSpacing: 1.2,
          ),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 60), // Tamanho fixo, largura ocupando a tela
          backgroundColor: Colors.white, // Cor de fundo dos botões
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Bordas mais arredondadas
          ),
          elevation: 5, // Adiciona sombra para dar destaque
          foregroundColor: Colors.green[700], // Cor do texto e ícone
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        },
      ),
    );
  }
}
