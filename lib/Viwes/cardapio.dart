import 'package:flutter/material.dart';
import '../Controllers/CardapioController.dart';
import '../Models/CardapioModel.dart';

class CadastrarCardapio extends StatefulWidget {
  @override
  _CadastrarCardapioState createState() => _CadastrarCardapioState();
}

class _CadastrarCardapioState extends State<CadastrarCardapio> {
  final _formKey = GlobalKey<FormState>();
  bool _diasSelecionadosValidos = true; // Variável para validar os dias

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController modalidadeController = TextEditingController();
  final TextEditingController periodoController = TextEditingController();
  final TextEditingController tipoRefeicaoController = TextEditingController();
  final TextEditingController tipoItemController = TextEditingController();
  final TextEditingController itemController = TextEditingController();
  final TextEditingController unidadeMedidaController = TextEditingController();

  final CardapioController cardapioController = CardapioController();

  Map<String, bool> diasSelecionados = {
    "Seg": false,
    "Ter": false,
    "Qua": false,
    "Qui": false,
    "Sex": false,
    "Sáb": false,
  };

  String? _escolaSelecionada; // Variável para armazenar a escola selecionada

  void _limparCampos() {
    nomeController.clear();
    descricaoController.clear();
    modalidadeController.clear();
    periodoController.clear();
    tipoRefeicaoController.clear();
    tipoItemController.clear();
    itemController.clear();
    unidadeMedidaController.clear();
    setState(() {
      diasSelecionados.updateAll((key, value) => false);
      _diasSelecionadosValidos = true;
      _escolaSelecionada = null; // Limpar a seleção da escola
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastrar Cardápio")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Cadastrar Cardápio", style: TextStyle(fontSize: 20)),
                SizedBox(height: 20),

                _buildTextField(nomeController, 'Nome do Cardápio'),
                _buildTextField(descricaoController, 'Descrição'),

                // Dropdown para selecionar a escola
                DropdownButtonFormField<String>(
                  value: _escolaSelecionada,
                  hint: Text("Selecione a Escola"),
                  items: _gerarMenuEscolar(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _escolaSelecionada = newValue;
                    });
                  },
                  validator: (value) => value == null ? 'Selecione uma escola' : null,
                ),

                _buildTextField(modalidadeController, 'Modalidade'),
                _buildTextField(periodoController, 'Período'),
                SizedBox(height: 20),

                Text("Selecione os dias da semana:"),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: diasSelecionados.keys.map((dia) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(dia),
                        Checkbox(
                          value: diasSelecionados[dia],
                          onChanged: (bool? value) {
                            setState(() {
                              diasSelecionados[dia] = value ?? false;
                              _diasSelecionadosValidos = diasSelecionados.containsValue(true);
                            });
                          },
                        ),
                      ],
                    );
                  }).toList(),
                ),
                if (!_diasSelecionadosValidos)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "Selecione pelo menos um dia!",
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),
                SizedBox(height: 20),

                _buildTextField(tipoRefeicaoController, 'Tipo de Refeição'),
                _buildTextField(tipoItemController, 'Tipo de Item'),
                _buildTextField(itemController, 'Item'),
                _buildTextField(unidadeMedidaController, 'Unidade de Medida', isNumeric: true),
                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() && diasSelecionados.containsValue(true) && _escolaSelecionada != null) {
                      final nome = nomeController.text;
                      final descricao = descricaoController.text;
                      final escola = _escolaSelecionada!;  // Aqui usamos a escola selecionada
                      final modalidade = modalidadeController.text;
                      final periodo = periodoController.text;
                      final tipoRefeicao = tipoRefeicaoController.text;
                      final tipoItem = tipoItemController.text;
                      final item = itemController.text;
                      final unidadeMedida = double.tryParse(unidadeMedidaController.text) ?? 0.0;

                      List<String> diasAtivos = diasSelecionados.entries
                          .where((element) => element.value)
                          .map((e) => e.key)
                          .toList();

                      final cardapio = Cardapio(
                        nome: nome,
                        descricao: descricao,
                        escola: escola,  // Associei a escola aqui
                        modalidade: modalidade,
                        periodo: periodo,
                        tipoRefeicao: tipoRefeicao,
                        tipoItem: tipoItem,
                        item: item,
                        unidadeMedida: unidadeMedida,
                        diasSemana: diasAtivos,
                      );

                      cardapioController.adicionarCardapio(cardapio);

                      _limparCampos();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Cardápio ${cardapio.nome} adicionado com sucesso!')),
                      );
                    } else {
                      setState(() {
                        _diasSelecionadosValidos = diasSelecionados.containsValue(true);
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Por favor, preencha todos os campos e selecione pelo menos um dia!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Text("Adicionar Cardápio"),
                ),
                SizedBox(height: 20),

                Text("Cardápios Cadastrados:", style: TextStyle(fontSize: 18)),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: cardapioController.listarCardapios().length,
                    itemBuilder: (context, index) {
                      final cardapio = cardapioController.listarCardapios()[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text(cardapio.nome, style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                            "Descrição: ${cardapio.descricao}\n"
                            "Escola: ${cardapio.escola}\n"
                            "Modalidade: ${cardapio.modalidade}\n"
                            "Período: ${cardapio.periodo}\n"
                            "Tipo de Refeição: ${cardapio.tipoRefeicao}\n"
                            "Tipo de Item: ${cardapio.tipoItem}\n"
                            "Item: ${cardapio.item}\n"
                            "Unidade de Medida: ${cardapio.unidadeMedida}\n"
                            "Dias da Semana: ${cardapio.diasSemana.join(', ')}",
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Função para gerar o menu de seleção das escolas
  List<DropdownMenuItem<String>> _gerarMenuEscolar() {
    // Aqui você deve buscar as escolas cadastradas (exemplo abaixo)
    List<String> escolas = ['Escola A', 'Escola B', 'Escola C'];  // Substitua com a lista de escolas reais
    return escolas.map((escola) {
      return DropdownMenuItem<String>(
        value: escola,
        child: Text(escola),
      );
    }).toList();
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        validator: (value) => value!.isEmpty ? 'Preencha este campo' : null,
      ),
    );
  }
}
