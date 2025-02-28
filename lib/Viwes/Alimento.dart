import 'package:flutter/material.dart';


class CadastroAlimentos extends StatefulWidget {
  @override
  _CadastroAlimentosState createState() => _CadastroAlimentosState();
}

class _CadastroAlimentosState extends State<CadastroAlimentos> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _gramasController = TextEditingController();

  List<String> grupos = [];
  String? grupoSelecionado;
  List<String> fontesNutricionais = [];
  String? fonteNutricionalSelecionada;

  void _abrirCadastroGrupo() async {
    final novoGrupo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CadastroGrupoScreen()),
    );
    if (novoGrupo != null) {
      setState(() {
        grupos.add(novoGrupo);
      });
    }
  }

  void _abrirCadastroFonteNutricional() async {
    final novaFonte = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CadastroFonteNutricionalScreen()),
    );
    if (novaFonte != null) {
      setState(() {
        fontesNutricionais.add(novaFonte);
      });
    }
  }

  void _excluirGrupo() async {
    final grupoRemovido = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ExcluirItemScreen(itens: grupos)),
    );
    if (grupoRemovido != null) {
      setState(() {
        grupos.remove(grupoRemovido);
        if (grupoSelecionado == grupoRemovido) {
          grupoSelecionado = null;
        }
      });
    }
  }

  void _excluirFonteNutricional() async {
    final fonteRemovida = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ExcluirItemScreen(itens: fontesNutricionais)),
    );
    if (fonteRemovida != null) {
      setState(() {
        fontesNutricionais.remove(fonteRemovida);
        if (fonteNutricionalSelecionada == fonteRemovida) {
          fonteNutricionalSelecionada = null;
        }
      });
    }
  }

  void _salvarDados() {
    String nome = _nomeController.text;
    String preco = _precoController.text;
    String gramas = _gramasController.text;

    if (nome.isNotEmpty && preco.isNotEmpty && gramas.isNotEmpty && grupoSelecionado != null && fonteNutricionalSelecionada != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Dados salvos com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Alimentos')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome do Alimento'),
            ),
            TextField(
              controller: _precoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Preço (R\$)'),
            ),
            TextField(
              controller: _gramasController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Medida Base:'),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: grupoSelecionado,
                    hint: Text('Selecione um grupo'),
                    items: grupos.map((grupo) {
                      return DropdownMenuItem(value: grupo, child: Text(grupo));
                    }).toList(),
                    onChanged: (valor) {
                      setState(() => grupoSelecionado = valor);
                    },
                  ),
                ),
                IconButton(icon: Icon(Icons.add), onPressed: _abrirCadastroGrupo),
                IconButton(icon: Icon(Icons.delete), onPressed: _excluirGrupo),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: fonteNutricionalSelecionada,
                    hint: Text('Selecione uma fonte nutricional'),
                    items: fontesNutricionais.map((fonte) {
                      return DropdownMenuItem(value: fonte, child: Text(fonte));
                    }).toList(),
                    onChanged: (valor) {
                      setState(() => fonteNutricionalSelecionada = valor);
                    },
                  ),
                ),
                IconButton(icon: Icon(Icons.add), onPressed: _abrirCadastroFonteNutricional),
                IconButton(icon: Icon(Icons.delete), onPressed: _excluirFonteNutricional),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvarDados,
              child: Text('Salvar Alimento'),
            ),
          ],
        ),
      ),
    );
  }
}


class CadastroGrupoScreen extends StatelessWidget {
  final TextEditingController _nomeGrupoController = TextEditingController();
  final TextEditingController _descricaoGrupoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Grupo')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeGrupoController,
              decoration: InputDecoration(labelText: 'Nome do Grupo'),
            ),
            TextField(
              controller: _descricaoGrupoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_nomeGrupoController.text.isNotEmpty) {
                  Navigator.pop(context, _nomeGrupoController.text);
                }
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}

class CadastroFonteNutricionalScreen extends StatelessWidget {
  final TextEditingController _nomeFonteController = TextEditingController();
  final TextEditingController _descricaoFonteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Fonte Nutricional')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeFonteController,
              decoration: InputDecoration(labelText: 'Nome da Fonte Nutricional'),
            ),
            TextField(
              controller: _descricaoFonteController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_nomeFonteController.text.isNotEmpty) {
                  Navigator.pop(context, _nomeFonteController.text);
                }
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}

class ExcluirItemScreen extends StatelessWidget {
  final List<String> itens;

  ExcluirItemScreen({required this.itens});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Excluir Item')),
      body: ListView.builder(
        itemCount: itens.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(itens[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Navigator.pop(context, itens[index]);
              },
            ),
          );
        },
      ),
    );
  }
}