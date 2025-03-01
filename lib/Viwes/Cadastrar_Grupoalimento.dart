import 'package:flutter/material.dart';

class CadastrarGrupo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Criando uma chave global para o formulário
    final _formKey = GlobalKey<FormState>();

    // Controladores para os campos de texto
    final TextEditingController _nomeController = TextEditingController();
    final TextEditingController _descricaoController = TextEditingController();

    // Função para cadastrar o grupo
    void _cadastrarGrupo(String nome, String descricao) {
      if (nome.isNotEmpty && descricao.isNotEmpty) {
        // Lógica de cadastro, você pode fazer algo com os dados aqui
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Grupo "$nome" cadastrado!')),
        );
      } else {
        // Caso os campos estejam vazios
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Preencha todos os campos!')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Grupo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            // Ajuste o alinhamento para que os widgets fiquem no topo
            mainAxisAlignment: MainAxisAlignment.start, // Coloca os itens no topo
            crossAxisAlignment: CrossAxisAlignment.stretch, // Expande os itens horizontalmente
            children: [
              // Caixa de texto para Nome
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Caixa de texto para Descrição
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Botão Cadastrar
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Se os campos forem válidos, chame a função para cadastrar
                    _cadastrarGrupo(
                      _nomeController.text,
                      _descricaoController.text,
                    );
                  }
                },
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



