import 'package:flutter/material.dart';
import '../Controllers/PreparacaoController.dart';
import '../Models/PreparacaoModel.dart';

class PreparacaoView extends StatefulWidget {
  @override
  _PreparacaoViewState createState() => _PreparacaoViewState();
}

class _PreparacaoViewState extends State<PreparacaoView> {
  final PreparacaoController _controller = PreparacaoController();
  final _formKey = GlobalKey<FormState>();

  // Controladores para os campos da tela principal
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController medidaController = TextEditingController();
  final TextEditingController pcLiquidoController = TextEditingController();
  final TextEditingController pcBrutoController = TextEditingController();
  final TextEditingController fcController = TextEditingController();
  final TextEditingController fonteController = TextEditingController();
  final TextEditingController grupoController = TextEditingController();
  final TextEditingController itemController = TextEditingController();
  final TextEditingController pesquisaController = TextEditingController();

  String? selectedItem;
  String? selectedMedida;
  String? selectedFilterType = 'Nome'; // Tipo de filtro: Nome, Grupo, Item

  List<String> itens = ['Item 1', 'Item 2', 'Item 3'];
  List<String> medidas = ['g']; // Só tem a opção 'g'

  List<Preparacao> preparacoesFiltradas = [];

  @override
  void initState() {
    super.initState();
    preparacoesFiltradas = _controller.listarPreparacoes(); // Inicializa com todas as preparações
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro de Preparação")),
      body: SingleChildScrollView( // Tornando a tela rolável
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Formulário de cadastro
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTextField("Nome", nomeController),
                            _buildDropdown("Item", itens, selectedItem, (value) {
                              setState(() {
                                selectedItem = value;
                              });
                            }),
                            _buildDropdown("Medida", medidas, selectedMedida, (value) {
                              setState(() {
                                selectedMedida = value;
                              });
                            }),
                            Row(
                              children: [
                                Expanded(child: _buildTextField("PC Líquido", pcLiquidoController, isNumeric: true, isDouble: true)),
                                SizedBox(width: 16),
                                Expanded(child: _buildTextField("PC Bruto", pcBrutoController, isNumeric: true, isDouble: true)),
                              ],
                            ),
                            _buildTextField("FC", fcController, isNumeric: true, isInt: true),
                            _buildTextField("Fonte de Informações", fonteController),
                            _buildTextField("Grupo", grupoController),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _adicionarPreparacao,
                              child: Text("Adicionar"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
            SizedBox(height: 20),  // Espaço entre o formulário e a tabela
            // Filtro de pesquisa
            Row(
              children: [
                // Dropdown para selecionar o tipo de filtro
                DropdownButton<String>(
                  value: selectedFilterType,
                  onChanged: (value) {
                    setState(() {
                      selectedFilterType = value;
                    });
                  },
                  items: ['Nome', 'Grupo', 'Item']
                      .map((filterType) => DropdownMenuItem<String>(
                            value: filterType,
                            child: Text(filterType),
                          ))
                      .toList(),
                ),
                SizedBox(width: 16),
                // Campo de pesquisa
                Expanded(
                  child: TextField(
                    controller: pesquisaController,
                    decoration: InputDecoration(
                      labelText: 'Pesquisar...',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: _filtrarPreparacoes,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Tabela de preparações
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text("Nome")),
                  DataColumn(label: Text("Medida")),
                  DataColumn(label: Text("PC Líquido")),
                  DataColumn(label: Text("PC Bruto")),
                  DataColumn(label: Text("FC")),
                  DataColumn(label: Text("Grupo")),
                  DataColumn(label: Text("Item")),
                  DataColumn(label: Text("Ações")),
                ],
                rows: preparacoesFiltradas.map((preparacao) {
                  return DataRow(cells: [
                    DataCell(Text(preparacao.nome)),
                    DataCell(Text(preparacao.medida)),
                    DataCell(Text(preparacao.pcLiquido.toString())),
                    DataCell(Text(preparacao.pcBruto.toString())),
                    DataCell(Text(preparacao.fc.toString())),
                    DataCell(Text(preparacao.grupo)),
                    DataCell(Text(preparacao.item)),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _abrirTelaEdicao(preparacao),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _confirmarApagar(preparacao),
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _filtrarPreparacoes(String query) {
    List<Preparacao> filtradas = _controller.listarPreparacoes();
    
    if (query.isNotEmpty) {
      if (selectedFilterType == 'Nome') {
        filtradas = filtradas.where((p) => p.nome.toLowerCase().contains(query.toLowerCase())).toList();
      } else if (selectedFilterType == 'Grupo') {
        filtradas = filtradas.where((p) => p.grupo.toLowerCase().contains(query.toLowerCase())).toList();
      } else if (selectedFilterType == 'Item') {
        filtradas = filtradas.where((p) => p.item.toLowerCase().contains(query.toLowerCase())).toList();
      }
    }

    setState(() {
      preparacoesFiltradas = filtradas;
    });
  }

  // Método de confirmação para apagar
  void _confirmarApagar(Preparacao preparacao) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar Apagar"),
          content: Text("Você tem certeza que deseja apagar '${preparacao.nome}'?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Apagar"),
              onPressed: () {
                _controller.removerPreparacao(preparacao.nome);
                setState(() {
                  preparacoesFiltradas = _controller.listarPreparacoes();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Método para abrir a tela de edição
  void _abrirTelaEdicao(Preparacao preparacao) {
  nomeController.text = preparacao.nome;
  medidaController.text = preparacao.medida;
  pcLiquidoController.text = preparacao.pcLiquido.toString();
  pcBrutoController.text = preparacao.pcBruto.toString();
  fcController.text = preparacao.fc.toString();
  fonteController.text = preparacao.fonteDeInformacoes;
  grupoController.text = preparacao.grupo;
  itemController.text = preparacao.item;

  // Definir valores selecionados
  selectedItem = preparacao.item;
  selectedMedida = preparacao.medida;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Alterar Preparação"),
        content: Container(
          width: double.maxFinite,  // Garante que o conteúdo ocupe toda a largura disponível
          height: 600,  // Ajusta a altura do dialog (aumente ou diminua conforme necessário)
          child: SingleChildScrollView(  // Permite rolar o conteúdo se necessário
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField("Nome", nomeController),
                  _buildDropdown("Item", itens, selectedItem, (value) {
                    setState(() {
                      selectedItem = value;
                    });
                  }),
                  _buildDropdown("Medida", medidas, selectedMedida, (value) {
                    setState(() {
                      selectedMedida = value;
                    });
                  }),
                  Row(
                    children: [
                      Expanded(child: _buildTextField("PC Líquido", pcLiquidoController, isNumeric: true, isDouble: true)),
                      SizedBox(width: 16),
                      Expanded(child: _buildTextField("PC Bruto", pcBrutoController, isNumeric: true, isDouble: true)),
                    ],
                  ),
                  _buildTextField("FC", fcController, isNumeric: true, isInt: true),
                  _buildTextField("Fonte de Informações", fonteController),
                  _buildTextField("Grupo", grupoController),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Preparacao novaPreparacao = Preparacao(
                          nome: nomeController.text,
                          medida: selectedMedida!,
                          pcLiquido: double.parse(pcLiquidoController.text),
                          pcBruto: double.parse(pcBrutoController.text),
                          fc: int.parse(fcController.text),
                          fonteDeInformacoes: fonteController.text,
                          grupo: grupoController.text,
                          item: selectedItem!,
                        );
                        _controller.atualizarPreparacao(preparacao.nome, novaPreparacao);
                        setState(() {
                          preparacoesFiltradas = _controller.listarPreparacoes();
                        });

                        // Limpar os campos após editar
                        nomeController.clear();
                        medidaController.clear();
                        pcLiquidoController.clear();
                        pcBrutoController.clear();
                        fcController.clear();
                        fonteController.clear();
                        grupoController.clear();
                        itemController.clear();
                        pesquisaController.clear();
                        setState(() {
                          selectedItem = null;
                          selectedMedida = null;
                        });

                        Navigator.of(context).pop();
                      }
                    },
                    child: Text("Salvar Alterações"),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}


  // Método para adicionar uma nova preparação
  void _adicionarPreparacao() {
    if (_formKey.currentState!.validate()) {
      Preparacao preparacao = Preparacao(
        nome: nomeController.text,
        medida: selectedMedida!,
        pcLiquido: double.parse(pcLiquidoController.text),
        pcBruto: double.parse(pcBrutoController.text),
        fc: int.parse(fcController.text),
        fonteDeInformacoes: fonteController.text,
        grupo: grupoController.text,
        item: selectedItem!,
      );
      bool sucesso = _controller.adicionarPreparacao(preparacao);
      if (sucesso) {
        setState(() {
          preparacoesFiltradas = _controller.listarPreparacoes();
        });

        // Limpar os campos após adicionar
        nomeController.clear();
        medidaController.clear();
        pcLiquidoController.clear();
        pcBrutoController.clear();
        fcController.clear();
        fonteController.clear();
        grupoController.clear();
        itemController.clear();
        pesquisaController.clear();
        setState(() {
          selectedItem = null;
          selectedMedida = null;
        });
      } else {
        // Exibir um alerta se a preparação já existir
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Erro"),
              content: Text("Já existe uma preparação com esse nome."),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumeric = false, bool isInt = false, bool isDouble = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Este campo é obrigatório';
          }
          if (isInt && int.tryParse(value) == null) {
            return 'Por favor, insira um número inteiro válido';
          }
          if (isDouble && double.tryParse(value) == null) {
            return 'Por favor, insira um número válido';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? selectedValue, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null) {
            return 'Este campo é obrigatório';
          }
          return null;
        },
      ),
    );
  }
}
