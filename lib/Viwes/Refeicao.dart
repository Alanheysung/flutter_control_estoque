import 'package:flutter/material.dart';
import '../Controllers/RefeicaoController.dart';
import '../Models/RefeicaoModel.dart';

class RefeicoesPage extends StatefulWidget {
  @override
  _RefeicoesPageState createState() => _RefeicoesPageState();
}

class _RefeicoesPageState extends State<RefeicoesPage> {
  final RefeicaoController controller = RefeicaoController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController horarioController = TextEditingController();
  String pesquisa = '';
  String tipoPesquisa = 'Nome';

  @override
  Widget build(BuildContext context) {
    List<Refeicao> refeicoes = controller.listarRefeicoes();
    if (pesquisa.isNotEmpty) {
      if (tipoPesquisa == 'Nome') {
        refeicoes = refeicoes.where((r) => r.nome.contains(pesquisa)).toList();
      } else if (tipoPesquisa == 'Descrição') {
        refeicoes = controller.filtrarPorDescricao(pesquisa);
      } else if (tipoPesquisa == 'Data') {
        try {
          DateTime data = DateTime.parse(pesquisa);
          refeicoes = controller.filtrarPorData(data);
        } catch (_) {
          // Mantém a lista original se a data for inválida
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Gerenciar Refeições')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campos para cadastro de refeição
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome', border: OutlineInputBorder()),
            ),
            SizedBox(height: 8),
            TextField(
              controller: descricaoController,
              decoration: InputDecoration(labelText: 'Descrição', border: OutlineInputBorder()),
            ),
            SizedBox(height: 8),
            TextField(
              controller: horarioController,
              decoration: InputDecoration(labelText: 'Horário (HH:mm)', border: OutlineInputBorder()),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                String nome = nomeController.text;
                String descricao = descricaoController.text;
                String horario = horarioController.text;

                if (nome.isEmpty || descricao.isEmpty || horario.isEmpty) {
                  return;
                }
                try {
                  DateTime horarioDateTime = DateTime.now().copyWith(
                    hour: int.parse(horario.split(':')[0]),
                    minute: int.parse(horario.split(':')[1]),
                  );
                  Refeicao refeicao = Refeicao(nome: nome, descricao: descricao, horario: horarioDateTime);
                  setState(() {
                    controller.adicionarRefeicao(refeicao);
                    nomeController.clear();
                    descricaoController.clear();
                    horarioController.clear();
                  });
                } catch (e) {}
              },
              child: Text('Cadastrar'),
            ),
            SizedBox(height: 16),
            // Barra de pesquisa
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) => setState(() => pesquisa = value),
                    decoration: InputDecoration(labelText: 'Pesquisar', border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(width: 8),
                DropdownButton<String>(
                  value: tipoPesquisa,
                  onChanged: (value) => setState(() => tipoPesquisa = value!),
                  items: ['Nome', 'Descrição', 'Data']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Tabela de refeições
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Nome')),
                    DataColumn(label: Text('Descrição')),
                    DataColumn(label: Text('Horário')),
                    DataColumn(label: Text('Ações')),
                  ],
                  rows: refeicoes.map<DataRow>((refeicao) {
                    return DataRow(cells: [
                      DataCell(Text(refeicao.nome)),
                      DataCell(Text(refeicao.descricao)),
                      DataCell(Text(refeicao.horario.toString().substring(11, 16))),
                      DataCell(Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editarRefeicao(refeicao);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Exibe o diálogo de confirmação
                      _confirmarRemocao(refeicao);
                    },
                  ),
                ],
              ))

                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editarRefeicao(Refeicao refeicao) {
    TextEditingController nomeCtrl = TextEditingController(text: refeicao.nome);
    TextEditingController descCtrl = TextEditingController(text: refeicao.descricao);
    TextEditingController horarioCtrl = TextEditingController(text: refeicao.horario.toString().substring(11, 16));

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Refeição'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nomeCtrl, decoration: InputDecoration(labelText: 'Nome')),
              TextField(controller: descCtrl, decoration: InputDecoration(labelText: 'Descrição')),
              TextField(controller: horarioCtrl, decoration: InputDecoration(labelText: 'Horário (HH:mm)')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                try {
                  DateTime horarioDateTime = DateTime.now().copyWith(
                    hour: int.parse(horarioCtrl.text.split(':')[0]),
                    minute: int.parse(horarioCtrl.text.split(':')[1]),
                  );
                  Refeicao novaRefeicao = Refeicao(
                    nome: nomeCtrl.text,
                    descricao: descCtrl.text,
                    horario: horarioDateTime,
                  );
                  setState(() {
                    controller.atualizarRefeicao(refeicao.nome, novaRefeicao);
                  });
                  Navigator.of(context).pop();
                } catch (e) {}
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

void _confirmarRemocao(Refeicao refeicao) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirmar Exclusão'),
        content: Text('Você tem certeza que deseja excluir a refeição "${refeicao.nome}"?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo sem excluir
            },
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                controller.removerRefeicao(refeicao.nome); // Remove a refeição
              });
              Navigator.of(context).pop(); // Fecha o diálogo
            },
            child: Text('Confirmar'),
          ),
        ],
      );
    },
  );
}


}