import 'package:flutter/material.dart';

class CadastrarValoresNutricionaisTela extends StatefulWidget {
  @override
  _CadastrarValoresNutricionaisTelaState createState() =>
      _CadastrarValoresNutricionaisTelaState();
}

class _CadastrarValoresNutricionaisTelaState
    extends State<CadastrarValoresNutricionaisTela> {
  final _formKey = GlobalKey<FormState>();

  final List<Map<String, String>> _campos = [
    {"label": "Calorias", "unidade": "Kcal", "valor": "0.000"},
    {"label": "Carboidratos", "unidade": "g", "valor": "0.000"},
    {"label": "Proteínas", "unidade": "g", "valor": "0.000"},
    {"label": "Lipídios", "unidade": "g", "valor": "0.000"},
    {"label": "Fibras", "unidade": "g", "valor": "0.000"},
    {"label": "Vitamina A", "unidade": "µg", "valor": "0.000"},
    {"label": "Vitamina C", "unidade": "mg", "valor": "0.000"},
    {"label": "Vitamina D", "unidade": "µg", "valor": "0.000"},
    {"label": "Vitamina E", "unidade": "mg", "valor": "0.000"},
    {"label": "Vitamina B1", "unidade": "mg", "valor": "0.000"},
    {"label": "Vitamina B2", "unidade": "mg", "valor": "0.000"},
    {"label": "Vitamina B6", "unidade": "mg", "valor": "0.000"},
    {"label": "Vitamina B12", "unidade": "µg", "valor": "0.000"},
    {"label": "Niacina", "unidade": "mg", "valor": "0.000"},
    {"label": "Ácido Fólico", "unidade": "µg", "valor": "0.000"},
    {"label": "Ácido Pant", "unidade": "mg", "valor": "0.000"},
    {"label": "Cálcio", "unidade": "mg", "valor": "0.000"},
    {"label": "Ferro", "unidade": "mg", "valor": "0.000"},
    {"label": "Magnésio", "unidade": "mg", "valor": "0.000"},
    {"label": "Potássio", "unidade": "mg", "valor": "0.000"},
    {"label": "Selênio", "unidade": "µg", "valor": "0.000"},
    {"label": "Fósforo", "unidade": "mg", "valor": "0.000"},
    {"label": "Iodo", "unidade": "µg", "valor": "0.000"},
    {"label": "Cobre", "unidade": "mg", "valor": "0.000"},
    {"label": "Zinco", "unidade": "mg", "valor": "0.000"},
    {"label": "Sódio", "unidade": "mg", "valor": "0.000"},
    {"label": "Gordura Total", "unidade": "g", "valor": "0.000"},
    {"label": "Colesterol", "unidade": "mg", "valor": "0.000"},
    {"label": "G. Saturada", "unidade": "g", "valor": "0.000"},
    {"label": "G. Poli", "unidade": "g", "valor": "0.000"},
    {"label": "G. Mono", "unidade": "g", "valor": "0.000"},
  ];

  void _salvarDados() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Valores salvos com sucesso!')),
      );
    }
  }

  Widget _buildTextField(String label, String unidade, String valor) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
          SizedBox(height: 2),
          SizedBox(
            height: 35,
            child: Row(
              children: [
                // Caixa de texto
                Expanded(
                  child: TextFormField(
                    initialValue: valor,  // Define o valor inicial como '0.000'
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    style: TextStyle(fontSize: 12),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo não pode estar vazio';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 4), // Espaço entre o valor e a unidade
                // Unidade ao lado
                Text(unidade, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Faz a tela se ajustar ao teclado
      appBar: AppBar(
        title: Text('Cadastrar Valores Nutricionais'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Wrap(
                  spacing: 8, // Espaçamento entre as colunas
                  runSpacing: 4, // Espaçamento entre as linhas
                  children: _campos
                      .map((campo) => Container(
                            width: MediaQuery.of(context).size.width / 3 - 16, // Largura adaptável para 3 colunas
                            child: _buildTextField(
                              campo["label"]!,
                              campo["unidade"]!,
                              campo["valor"]!,
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _salvarDados,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                    textStyle: TextStyle(fontSize: 14),
                  ),
                  child: Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
