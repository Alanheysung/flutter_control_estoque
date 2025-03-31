import 'package:flutter/material.dart';
import '../Controllers/ReferenciasNutricionaisController.dart';
import '../Models/ReferenciasNutricionaisModel.dart';
import 'CadastrarValoresNutricionais.dart';

class ReferenciasNutricionaisTela extends StatefulWidget {
  @override
  _ReferenciasNutricionaisTelaState createState() =>
      _ReferenciasNutricionaisTelaState();
}

class _ReferenciasNutricionaisTelaState
    extends State<ReferenciasNutricionaisTela> {
  final _formKey = GlobalKey<FormState>();
  final _controller = ReferenciasNutricionaisController();

  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  String? _numeroRefeicoes;
  String? _categoriaEnsino;
  String? _faixaIdade;
  String? _periodo;
  String _filtroPesquisa = '';
  String _tipoPesquisa = 'Nome'; // Variável para armazenar o tipo de pesquisa selecionado
  
  List<ReferenciasNutricionais> _referenciasCadastradas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Referência Nutricional'), backgroundColor: Colors.green),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTitle(),
              _buildTextField(_nomeController, 'Nome'),
              _buildTextField(_descricaoController, 'Descrição'),
              _buildDropdownRow('N° min de refeição', _numeroRefeicoes, ['1', '2', '3', '4'], (value) => setState(() => _numeroRefeicoes = value)),
              _buildDropdownRow('Categoria de Ensino', _categoriaEnsino, ['Creche', 'Pré-escola', 'Ensino Fundamental', 'Ensino Médio', 'EJAI'], (value) => setState(() => _categoriaEnsino = value)),
              _buildDropdownRow('Faixa de idade', _faixaIdade, ['1 - 3 anos', '4 - 5 anos', '6 - 10 anos', '7 - 11 anos', '11 - 15 anos', '16 - 18 anos', '19 - 70 anos'], (value) => setState(() => _faixaIdade = value)),
              _buildDropdownRow('Período', _periodo, ['Manhã', 'Tarde', 'Parcial', 'Integral'], (value) => setState(() => _periodo = value)),
              _buildButton('Cadastrar valores nutricionais', Colors.blue, () => Navigator.push(context, MaterialPageRoute(builder: (_) => CadastrarValoresNutricionaisTela()))),
              _buildButton('Cadastrar', Colors.green, _cadastrarReferencia),
              _buildSearchField(),
              _buildTipoPesquisaDropdown(), // Adicionando o Dropdown para selecionar tipo de pesquisa
              _buildDataTable()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() => Text('Cadastrar referência nutricional', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center);

  Widget _buildTextField(TextEditingController controller, String label) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
          validator: (value) => value?.isEmpty == true ? '$label é obrigatório' : null,
        ),
      );

  Widget _buildDropdownRow(String label, String? value, List<String> options, ValueChanged<String?> onChanged) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
          items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
          validator: (value) => value == null ? 'Selecione uma opção' : null,
        ),
      );

  Widget _buildButton(String text, Color color, VoidCallback onPressed) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(text),
          style: ElevatedButton.styleFrom(backgroundColor: color, padding: EdgeInsets.symmetric(vertical: 10)),
        ),
      );

  Widget _buildSearchField() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Pesquisar', prefixIcon: Icon(Icons.search), border: OutlineInputBorder()),
          onChanged: (value) => setState(() => _filtroPesquisa = value.toLowerCase()),
        ),
      );

  Widget _buildTipoPesquisaDropdown() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: DropdownButton<String>(
          value: _tipoPesquisa,
          onChanged: (newValue) {
            setState(() {
              _tipoPesquisa = newValue!;
            });
          },
          items: ['Nome', 'Faixa Etária', 'Categoria', 'Período']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          hint: Text('Selecione tipo de pesquisa'),
        ),
      );

  Widget _buildDataTable() => DataTable(
        columns: ['Nome', 'Descrição', 'N° Refeições', 'Categoria', 'Faixa Idade', 'Período', 'Ações']
            .map((title) => DataColumn(label: Text(title)))
            .toList(),
        rows: _referenciasCadastradas
            .where((r) {
              // Conectar a lógica de filtro de acordo com o tipo de pesquisa selecionado
              switch (_tipoPesquisa) {
                case 'Nome':
                  return r.nome.toLowerCase().contains(_filtroPesquisa);
                case 'Faixa Etária':
                  return r.faixaIdade.toLowerCase().contains(_filtroPesquisa);
                case 'Categoria':
                  return r.categoriaEnsino.toLowerCase().contains(_filtroPesquisa);
                case 'Período':
                  return r.periodo.toLowerCase().contains(_filtroPesquisa);
                default:
                  return false;
              }
            })
            .map((r) => DataRow(cells: [
                  DataCell(Text(r.nome)),
                  DataCell(Text(r.descricao)),
                  DataCell(Text(r.nRefeicoes.toString())),
                  DataCell(Text(r.categoriaEnsino)),
                  DataCell(Text(r.faixaIdade)),
                  DataCell(Text(r.periodo)),
                  DataCell(Row(
                    children: [
                      IconButton(icon: Icon(Icons.edit, color: Colors.blue), onPressed: () => _editarReferencia(r)),
                      IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: () => _excluirReferencia(r)),
                    ],
                  )),
                ]))
            .toList(),
      );

  void _cadastrarReferencia() {
    if (_formKey.currentState?.validate() ?? false) {
      final referencia = ReferenciasNutricionais(
        nome: _nomeController.text,
        descricao: _descricaoController.text,
        nRefeicoes: int.tryParse(_numeroRefeicoes ?? '') ?? 0,
        categoriaEnsino: _categoriaEnsino ?? '',
        faixaIdade: _faixaIdade ?? '',
        periodo: _periodo ?? '',
      );
      
      if (_controller.adicionarReferencia(referencia)) {
        setState(() {
          _referenciasCadastradas.add(referencia);
          _nomeController.clear();
          _descricaoController.clear();
          _numeroRefeicoes = null;
          _categoriaEnsino = null;
          _faixaIdade = null;
          _periodo = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Referência cadastrada com sucesso!')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Já existe uma referência com esse nome.')));
      }
    }
  }
/*
  void _excluirReferencia(ReferenciasNutricionais referencia) {
    setState(() => _referenciasCadastradas.remove(referencia));
  }

  void _editarReferencia(ReferenciasNutricionais referencia) {
    // Implementação da edição
  }
}*/




  // Função para excluir a referência
void _excluirReferencia(ReferenciasNutricionais referencia) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Confirmar Exclusão'),
        content: Text('Tem certeza de que deseja excluir esta referência nutricional?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Fecha o diálogo sem fazer nada
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // Remove a referência após confirmação
              bool sucesso = _controller.removerReferencia(referencia.nome);
              if (sucesso) {
                setState(() {
                  _referenciasCadastradas.remove(referencia); // Remove da lista
                });

                Navigator.pop(context); // Fecha o diálogo
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Referência excluída com sucesso!')),
                );
              } else {
                Navigator.pop(context); // Fecha o diálogo
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Falha ao excluir a referência!')),
                );
              }
            },
            child: Text('Confirmar'),
          ),
        ],
      );
    },
  );
}


void _editarReferencia(ReferenciasNutricionais referencia) {
  // Variáveis temporárias para os campos de edição
  String nomeTemp = referencia.nome;
  String descricaoTemp = referencia.descricao;
  String? numeroRefeicoesTemp = referencia.nRefeicoes.toString();
  String? categoriaEnsinoTemp = referencia.categoriaEnsino;
  String? faixaIdadeTemp = referencia.faixaIdade.toString();  // Verifique aqui, convertendo para string
  String? periodoTemp = referencia.periodo;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Editar Referência'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Nome
              TextFormField(
                initialValue: referencia.nome,
                decoration: InputDecoration(labelText: 'Nome'),
                onChanged: (value) => nomeTemp = value,
              ),
              // Descrição
              TextFormField(
                initialValue: referencia.descricao,
                decoration: InputDecoration(labelText: 'Descrição'),
                onChanged: (value) => descricaoTemp = value,
              ),
              // Número de refeições
              DropdownButtonFormField<String>(
                value: numeroRefeicoesTemp,
                decoration: InputDecoration(labelText: 'Número de Refeições'),
                items: [
                  DropdownMenuItem(value: '1', child: Text('1')),
                  DropdownMenuItem(value: '2', child: Text('2')),
                  DropdownMenuItem(value: '3', child: Text('3')),
                  DropdownMenuItem(value: '4', child: Text('4')),
                ],
                onChanged: (value) {
                  numeroRefeicoesTemp = value;
                },
              ),
              // Faixa de idade
              DropdownButtonFormField<String>(
                value: faixaIdadeTemp,
                decoration: InputDecoration(labelText: 'Faixa de Idade'),
                items: [
                  DropdownMenuItem(value: '1 - 3 anos', child: Text('1 - 3 anos')),
                  DropdownMenuItem(value: '4 - 5 anos', child: Text('4 - 5 anos')),
                  DropdownMenuItem(value: '6 - 10 anos', child: Text('6 - 10 anos')),
                  DropdownMenuItem(value: '7 - 11 anos', child: Text('7 - 11 anos')),
                  DropdownMenuItem(value: '11 - 15 anos', child: Text('11 - 15 anos')),
                  DropdownMenuItem(value: '16 - 18 anos', child: Text('16 - 18 anos')),
                  DropdownMenuItem(value: '19 - 70 anos', child: Text('19 - 70 anos')),
                ],
                onChanged: (value) {
                  faixaIdadeTemp = value;
                },
              ),
              // Categoria de Ensino
              DropdownButtonFormField<String>(
                value: categoriaEnsinoTemp,
                decoration: InputDecoration(labelText: 'Categoria de Ensino'),
                items: [
                  DropdownMenuItem(value: 'Creche', child: Text('Creche')),
                  DropdownMenuItem(value: 'Pré-escola', child: Text('Pré-escola')),
                  DropdownMenuItem(value: 'Ensino Fundamental', child: Text('Ensino Fundamental')),
                  DropdownMenuItem(value: 'Ensino Médio', child: Text('Ensino Médio')),
                  DropdownMenuItem(value: 'EJAI', child: Text('EJAI')),
                ],
                onChanged: (value) {
                  categoriaEnsinoTemp = value;
                },
              ),
              // Período
              DropdownButtonFormField<String>(
                value: periodoTemp,
                decoration: InputDecoration(labelText: 'Período'),
                items: [
                  DropdownMenuItem(value: 'Manhã', child: Text('Manhã')),
                  DropdownMenuItem(value: 'Tarde', child: Text('Tarde')),
                  DropdownMenuItem(value: 'Parcial', child: Text('Parcial')),
                  DropdownMenuItem(value: 'Integral', child: Text('Integral')),
                ],
                onChanged: (value) {
                  periodoTemp = value;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Cria o novo objeto de referência com os dados alterados
              ReferenciasNutricionais referenciaAtualizada = ReferenciasNutricionais(
                nome: nomeTemp,
                descricao: descricaoTemp,
                nRefeicoes: int.tryParse(numeroRefeicoesTemp ?? '') ?? 0,
                faixaIdade: faixaIdadeTemp ?? '',  // Alterado para string
                categoriaEnsino: categoriaEnsinoTemp ?? '',
                periodo: periodoTemp ?? '',
              );

              // Chama o método de atualização no controlador
              bool sucesso = _controller.atualizarReferencia(
                referencia.nome, // Nome original para identificar
                referenciaAtualizada,
              );

              if (sucesso) {
                setState(() {
                  // Atualiza a referência na lista
                  var index = _referenciasCadastradas.indexWhere((r) => r.nome == referencia.nome);
                  if (index != -1) {
                    _referenciasCadastradas[index] = referenciaAtualizada;
                  }
                });

                Navigator.pop(context); // Fecha o diálogo
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Referência atualizada com sucesso!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Falha ao atualizar a referência!')),
                );
              }
            },
            child: Text('Salvar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Fecha o diálogo
            },
            child: Text('Cancelar'),
          ),
        ],
      );
    },
  );
}


}