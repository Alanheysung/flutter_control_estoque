import 'package:flutter/material.dart';
import '../Controllers/CardapioController.dart';
import '../Models/CardapioModel.dart';

class CadastrarCardapio extends StatefulWidget {
  @override
  _CadastrarCardapioState createState() => _CadastrarCardapioState();
}

class _CadastrarCardapioState extends State<CadastrarCardapio> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController modalidadeController = TextEditingController();
  final TextEditingController tipoRefeicaoController = TextEditingController();
  final TextEditingController tipoItemController = TextEditingController();
  final TextEditingController itemController = TextEditingController();
  final TextEditingController unidadeMedidaController = TextEditingController();
  final TextEditingController periodoController = TextEditingController();
  final TextEditingController pesquisaController = TextEditingController(); // Controlador da pesquisa

  final CardapioController cardapioController = CardapioController();

  Map<String, bool> diasSelecionados = {
    "Seg": false,
    "Ter": false,
    "Qua": false,
    "Qui": false,
    "Sex": false,
    "Sáb": false,
  };

  String? _escolaSelecionada;
  String? _modalidadeSelecionada;
  String? _tipoRefeicaoSelecionado;
  String? _tipoItemSelecionado;

  DateTimeRange? _selectedDateRange;

  // Lista para armazenar os cardápios cadastrados
  List<Cardapio> cardapiosCadastrados = [];
  // Lista para armazenar os cardápios visíveis (pós-pesquisa)
  List<Cardapio> cardapiosVisiveis = [];

  // Variável para armazenar o cardápio sendo editado
  Cardapio? _cardapioEditando;

  // Função para limpar os campos
  void _limparCampos() {
    nomeController.clear();
    descricaoController.clear();
    modalidadeController.clear();
    tipoRefeicaoController.clear();
    tipoItemController.clear();
    itemController.clear();
    unidadeMedidaController.clear();
    periodoController.clear();
    pesquisaController.clear();  // Limpar o campo de pesquisa
    setState(() {
      diasSelecionados.updateAll((key, value) => false);
      _escolaSelecionada = null;
      _modalidadeSelecionada = null;
      _selectedDateRange = null;
      _tipoRefeicaoSelecionado = null;
      _tipoItemSelecionado = null;
      _cardapioEditando = null;  // Limpa o cardápio em edição
      cardapiosVisiveis = List.from(cardapiosCadastrados); // Restaura a lista de cardápios visíveis
    });
  }

  // Função para adicionar ou editar o cardápio
  void _adicionarOuEditarCardapio() {
    final nome = nomeController.text;
    final descricao = descricaoController.text;
    final escola = _escolaSelecionada;
    final modalidade = _modalidadeSelecionada;
    final periodo = periodoController.text;
    final tipoRefeicao = _tipoRefeicaoSelecionado;
    final tipoItem = _tipoItemSelecionado;
    final item = itemController.text;
    final unidadeMedida = unidadeMedidaController.text;

    // Verificação de campos obrigatórios
    String erro = '';

    if (nome.isEmpty) erro += 'O nome do cardápio não pode estar vazio. \n';
    if (descricao.isEmpty) erro += 'A descrição não pode estar vazia. \n';
    if (escola == null) erro += 'A escola deve ser selecionada. \n';
    if (modalidade == null) erro += 'A modalidade deve ser selecionada. \n';
    if (tipoRefeicao == null) erro += 'O tipo de refeição deve ser selecionado. \n';
    if (tipoItem == null) erro += 'O tipo de item deve ser selecionado. \n';
    if (item.isEmpty) erro += 'O item não pode estar vazio. \n';
    if (unidadeMedida.isEmpty) erro += 'A unidade de medida não pode estar vazia. \n';
    if (diasSelecionados.containsValue(true) == false) erro += 'Pelo menos um dia da semana deve ser selecionado. \n';

    if (erro.isNotEmpty) {
      // Exibindo a mensagem de erro com os campos inválidos
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(erro)),
      );
      return; // Retorna sem adicionar o cardápio
    }

    try {
      List<String> diasAtivos = diasSelecionados.entries
          .where((element) => element.value)
          .map((e) => e.key)
          .toList();

      final cardapio = Cardapio(
        nome: nome,
        descricao: descricao,
        escola: escola!,
        modalidade: modalidade!,
        periodo: periodo,
        tipoRefeicao: tipoRefeicao!,
        tipoItem: tipoItem!,
        item: item,
        unidadeMedida: unidadeMedida,
        diasSemana: diasAtivos,
      );

      setState(() {
        if (_cardapioEditando != null) {
          // Edita o cardápio existente, comparando os valores para ver se houve alterações
          int index = cardapiosCadastrados.indexOf(_cardapioEditando!);
          cardapiosCadastrados[index] = cardapio;
        } else {
          // Adiciona um novo cardápio
          cardapiosCadastrados.add(cardapio);
        }
        cardapiosVisiveis = List.from(cardapiosCadastrados); // Atualiza a lista visível
      });

      _limparCampos(); // Limpa os campos após adicionar ou editar o cardápio
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cardápio ${cardapio.nome} ${_cardapioEditando != null ? 'editado' : 'adicionado'} com sucesso!')),
      );
    } catch (e) {
      // Exibindo uma mensagem de erro caso ocorra algum problema inesperado
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar/editar o cardápio: ${e.toString()}')),
      );
    }
  }

  // Função para selecionar o intervalo de datas
  Future<void> _selecionarPeriodo(BuildContext context) async {
    DateTimeRange? pickedDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDateRange: _selectedDateRange ?? DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(Duration(days: 7)),
      ),
    );

    if (pickedDateRange != null && pickedDateRange.start != pickedDateRange.end) {
      setState(() {
        _selectedDateRange = pickedDateRange;
        periodoController.text =
            "${_formatarData(pickedDateRange.start)} - ${_formatarData(pickedDateRange.end)}";
      });

      // Atualiza os dias da semana conforme o intervalo selecionado
      _atualizarDiasSelecionados(pickedDateRange);
    }
  }

  // Função para formatar a data
  String _formatarData(DateTime data) {
    return "${data.day}/${data.month}/${data.year}";
  }

  // Função para atualizar os dias selecionados conforme o intervalo de datas
  void _atualizarDiasSelecionados(DateTimeRange pickedDateRange) {
    diasSelecionados.updateAll((key, value) => false);

    DateTime startDate = pickedDateRange.start;
    DateTime endDate = pickedDateRange.end;

    for (DateTime date = startDate; date.isBefore(endDate.add(Duration(days: 1))); date = date.add(Duration(days: 1))) {
      int weekday = date.weekday;
      String diaSemana = _obterDiaSemana(weekday);

      if (diasSelecionados.containsKey(diaSemana)) {
        setState(() {
          diasSelecionados[diaSemana] = true;
        });
      }
    }
  }

  String _obterDiaSemana(int weekday) {
    switch (weekday) {
      case 1: return "Seg";
      case 2: return "Ter";
      case 3: return "Qua";
      case 4: return "Qui";
      case 5: return "Sex";
      case 6: return "Sáb";
      case 7: return "Dom";
      default: return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastrar Cardápio")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Cadastrar Cardápio", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),

              // Campos de entrada para dados do cardápio
              _buildTextField(nomeController, 'Nome do Cardápio'),
              _buildTextField(descricaoController, 'Descrição'),

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: "Escola",
                    border: OutlineInputBorder(),
                  ),
                  child: DropdownButton<String>(
                    value: _escolaSelecionada,
                    hint: Text("Selecione a Escola"),
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        _escolaSelecionada = newValue;
                      });
                    },
                    items: _gerarMenuEscolar(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: "Modalidade",
                    border: OutlineInputBorder(),
                  ),
                  child: DropdownButton<String>(
                    value: _modalidadeSelecionada,
                    hint: Text("Selecione a Modalidade"),
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        _modalidadeSelecionada = newValue;
                      });
                    },
                    items: [
                      'Selecione uma opção',
                      'Creche',
                      'Pré-escola',
                      'Fundamental',
                      'EJA',
                    ].map((modalidade) {
                      return DropdownMenuItem<String>(
                        value: modalidade == 'Selecione uma opção' ? null : modalidade,
                        child: Text(modalidade),
                      );
                    }).toList(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: "Tipo de Refeição",
                    border: OutlineInputBorder(),
                  ),
                  child: DropdownButton<String>(
                    value: _tipoRefeicaoSelecionado,
                    hint: Text("Selecione uma opção"),
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        _tipoRefeicaoSelecionado = newValue;
                      });
                    },
                    items: [
                      'Selecione uma opção',
                      'Desjejum',
                      'Jantar',
                      'Lanche',
                      'Reforço',
                    ].map((tipoRefeicao) {
                      return DropdownMenuItem<String>(
                        value: tipoRefeicao == 'Selecione uma opção' ? null : tipoRefeicao,
                        child: Text(tipoRefeicao),
                      );
                    }).toList(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: "Tipo de Item",
                    border: OutlineInputBorder(),
                  ),
                  child: DropdownButton<String>(
                    value: _tipoItemSelecionado,
                    hint: Text("Selecione uma opção"),
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        _tipoItemSelecionado = newValue;
                      });
                    },
                    items: [
                      'Selecione uma opção',
                      'Alimento',
                      'Preparação',
                    ].map((tipoItem) {
                      return DropdownMenuItem<String>(
                        value: tipoItem == 'Selecione uma opção' ? null : tipoItem,
                        child: Text(tipoItem),
                      );
                    }).toList(),
                  ),
                ),
              ),

              _buildTextField(itemController, 'Item'),
              _buildTextField(unidadeMedidaController, 'Unidade de Medida'),

              GestureDetector(
                onTap: () => _selecionarPeriodo(context),
                child: AbsorbPointer(
                  child: _buildTextField(periodoController, 'Período'),
                ),
              ),

              // Seletor de dias da semana
              Wrap(
                spacing: 10,
                children: diasSelecionados.keys.map((dia) {
                  return ChoiceChip(
                    label: Text(dia),
                    selected: diasSelecionados[dia]!,
                    onSelected: (bool selected) {
                      setState(() {
                        diasSelecionados[dia] = selected;
                      });
                    },
                  );
                }).toList(),
              ),

              SizedBox(height: 20),

              // Botão para salvar ou editar cardápio
              ElevatedButton(
                onPressed: _adicionarOuEditarCardapio,
                child: Text(_cardapioEditando != null ? 'Editar Cardápio' : 'Adicionar Cardápio'),
              ),

              // Pesquisa
              TextField(
                controller: pesquisaController,
                decoration: InputDecoration(labelText: 'Pesquisar Cardápio'),
                onChanged: (query) {
                  setState(() {
                    cardapiosVisiveis = cardapiosCadastrados
                        .where((cardapio) => cardapio.nome
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                        .toList();
                  });
                },
              ),

              SizedBox(height: 20),

              // Tabela de cardápios
              _buildTabelaCardapios(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  List<DropdownMenuItem<String>> _gerarMenuEscolar() {
    return [
      'Selecione uma opção',
      'Escola A',
      'Escola B',
      'Escola C',
    ].map((escola) {
      return DropdownMenuItem<String>(
        value: escola == 'Selecione uma opção' ? null : escola,
        child: Text(escola),
      );
    }).toList();
  }

 // Função para construir a tabela de cardápios (exibição vertical)
Widget _buildTabelaCardapios() {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical, // Mudando a direção para vertical
    child: Column(
      children: cardapiosVisiveis.map((cardapio) {
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTableRow('Nome', cardapio.nome),
              _buildTableRow('Descrição', cardapio.descricao),
              _buildTableRow('Escola', cardapio.escola ?? 'Não especificado'),
              _buildTableRow('Modalidade', cardapio.modalidade ?? 'Não especificado'),
              _buildTableRow('Tipo de Refeição', cardapio.tipoRefeicao ?? 'Não especificado'),
              _buildTableRow('Tipo de Item', cardapio.tipoItem ?? 'Não especificado'),
              _buildTableRow('Item', cardapio.item ?? 'Não especificado'),
              _buildTableRow('Unidade de Medida', cardapio.unidadeMedida ?? 'Não especificado'),
              _buildTableRow('Período', cardapio.periodo ?? 'Não especificado'),
              _buildTableRow('Dias', cardapio.diasSemana.join(", ")),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        // Inicia o modo de edição
                        _cardapioEditando = cardapio;
                        nomeController.text = cardapio.nome;
                        descricaoController.text = cardapio.descricao;
                        _escolaSelecionada = cardapio.escola;
                        _modalidadeSelecionada = cardapio.modalidade;
                        periodoController.text = cardapio.periodo ?? '';
                        _tipoRefeicaoSelecionado = cardapio.tipoRefeicao;
                        _tipoItemSelecionado = cardapio.tipoItem;
                        itemController.text = cardapio.item ?? '';
                        unidadeMedidaController.text = cardapio.unidadeMedida ?? '';
                        diasSelecionados.updateAll((key, value) => cardapio.diasSemana.contains(key));
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Exibe o diálogo de confirmação
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirmar Exclusão'),
                            content: Text('Você tem certeza que deseja excluir este cardápio?'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Cancelar'),
                                onPressed: () {
                                  // Fecha o diálogo sem excluir
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Confirmar'),
                                onPressed: () {
                                  setState(() {
                                    // Exclui o cardápio
                                    cardapiosCadastrados.remove(cardapio);
                                    cardapiosVisiveis = List.from(cardapiosCadastrados); // Atualiza a lista visível
                                  });
                                  Navigator.of(context).pop(); // Fecha o diálogo após a exclusão
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
}

// Método auxiliar para construir cada linha de dados
Widget _buildTableRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('$label: ', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(width: 10),
      Text(value),
    ],
  );
}
}