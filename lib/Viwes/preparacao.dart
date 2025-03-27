import 'package:flutter/material.dart';
import '../Controllers/PreparacaoController.dart';
import '../Models/PreparacaoModel.dart';

class PreparacaoPage extends StatefulWidget {
  @override
  _PreparacaoPageState createState() => _PreparacaoPageState();
}

class _PreparacaoPageState extends State<PreparacaoPage> {
  final PreparacaoController controller = PreparacaoController();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _grupoController = TextEditingController();
  final _fonteDeInformacoesController = TextEditingController();
  final _pcBrutoController = TextEditingController();
  final _pcLiquidoController = TextEditingController();
  final _fcController = TextEditingController();

  String? _itemSelecionado;
  String? _medidaSelecionada = 'g'; // Valor inicial para Medida

  // Função para validar se todos os campos estão preenchidos
  String? _validarCampos() {
    if (_nomeController.text.isEmpty) {
      return "Nome";
    }
    if (_descricaoController.text.isEmpty) {
      return "Descrição";
    }
    if (_grupoController.text.isEmpty) {
      return "Grupo";
    }
    if (_fonteDeInformacoesController.text.isEmpty) {
      return "Fonte de Informações";
    }
    if (_pcBrutoController.text.isEmpty) {
      return "PC Bruto";
    }
    if (_pcLiquidoController.text.isEmpty) {
      return "PC Líquido";
    }
    if (_fcController.text.isEmpty) {
      return "FC";
    }
    if (_itemSelecionado == null) {
      return "Item";
    }
    if (_medidaSelecionada == null) {
      return "Medida";
    }
    return null; // Todos os campos estão preenchidos
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar e Listar Preparações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Formulário de Cadastro
              Text(
                'Cadastrar Preparação',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _descricaoController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _grupoController,
                decoration: InputDecoration(
                  labelText: 'Grupo',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _fonteDeInformacoesController,
                decoration: InputDecoration(
                  labelText: 'Fonte de Informações',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Dropdown para selecionar o Item
              DropdownButtonFormField<String>(
                value: _itemSelecionado,
                decoration: InputDecoration(
                  labelText: 'Item',
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem<String>(
                    value: null,
                    child: Text('Selecione uma opção'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'a',
                    child: Text('a'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'b',
                    child: Text('b'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'c',
                    child: Text('c'),
                  ),
                ],
                onChanged: (String? novoValor) {
                  setState(() {
                    _itemSelecionado = novoValor;
                  });
                },
              ),
              SizedBox(height: 16),
              // Dropdown para selecionar a Medida
              DropdownButtonFormField<String>(
                value: _medidaSelecionada,
                decoration: InputDecoration(
                  labelText: 'Medida',
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem<String>(
                    value: null,
                    child: Text('Selecione uma opção'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'g',
                    child: Text('g (gramas)'),
                  ),
                ],
                onChanged: (String? novoValor) {
                  setState(() {
                    _medidaSelecionada = novoValor;
                  });
                },
              ),
              SizedBox(height: 16),
              TextField(
                controller: _pcBrutoController,
                decoration: InputDecoration(
                  labelText: 'PC Bruto',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _pcLiquidoController,
                decoration: InputDecoration(
                  labelText: 'PC Líquido',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _fcController,
                decoration: InputDecoration(
                  labelText: 'FC',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 32),

              // Botão de adicionar
              ElevatedButton(
                onPressed: () {
                  // Verifica se todos os campos estão preenchidos
                  String? campoFaltando = _validarCampos();
                  if (campoFaltando != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Por favor, preencha o campo: $campoFaltando."),
                    ));
                    return;
                  }

                  // Cria a preparação com os dados fornecidos
                  final preparacao = Preparacao(
                    nome: _nomeController.text,
                    grupo: _grupoController.text,
                    fonteDeInformacoes: _fonteDeInformacoesController.text,
                    item: _itemSelecionado ?? '',
                    medida: _medidaSelecionada == 'g' ? 0.0 : 0.0,
                    pcBruto: double.tryParse(_pcBrutoController.text) ?? 0.0,
                    pcLiquido: double.tryParse(_pcLiquidoController.text) ?? 0.0,
                    fc: int.tryParse(_fcController.text) ?? 0,
                  );

                  bool sucesso = controller.adicionarPreparacao(preparacao);

                  if (sucesso) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Preparação adicionada com sucesso!"),
                    ));

                    // Limpa os campos após o sucesso
                    _nomeController.clear();
                    _descricaoController.clear();
                    _grupoController.clear();
                    _fonteDeInformacoesController.clear();
                    _pcBrutoController.clear();
                    _pcLiquidoController.clear();
                    _fcController.clear();
                    setState(() {
                      _itemSelecionado = null;
                      _medidaSelecionada = 'g';
                    });

                    setState(() {}); // Atualiza a lista após adicionar
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Já existe uma preparação com esse nome."),
                    ));
                  }
                },
                child: Text('Adicionar à Lista'),
              ),

              SizedBox(height: 32),

              // Título da lista
              Text(
                'Preparações Cadastradas',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              // Lista vertical com os preparações cadastradas
              ListView.builder(
                shrinkWrap: true,  // Para que a ListView ocupe apenas o espaço necessário
                physics: NeverScrollableScrollPhysics(), // Desabilita a rolagem interna
                itemCount: controller.listarPreparacoes().length,
                itemBuilder: (context, index) {
                  final preparacao = controller.listarPreparacoes()[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 5,
                    child: ListTile(
                      title: Text(preparacao.nome),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Grupo: ${preparacao.grupo}'),
                          Text('Item: ${preparacao.item}'),
                          Text('PC Bruto: ${preparacao.pcBruto}'),
                          Text('PC Líquido: ${preparacao.pcLiquido}'),
                          Text('FC: ${preparacao.fc}'),
                          Text('Medida: ${preparacao.medida}'),
                          Text('Fonte de Informações: ${preparacao.fonteDeInformacoes}'),
                          // Text('Descrição: ${preparacao.descricao}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
