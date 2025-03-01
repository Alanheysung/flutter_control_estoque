import 'package:flutter/material.dart';

class CadastrarTela extends StatefulWidget {
  @override
  _CardapioState createState() => _CardapioState();
}

class _CardapioState extends State<CadastrarTela> {
  Map<String, bool> diasSelecionados = {
    "Seg": false,
    "Ter": false,
    "Qua": false,
    "Qui": false,
    "Sex": false,
    "Sáb": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cardápio"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Escola',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Modalidade',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Período',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Text("Cardápio:"),
              SizedBox(height: 8),
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
                          });
                        },
                      ),
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              // Campos adicionais de refeição
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Tipo de Refeição',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Tipo de Item',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Fonte',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Item',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Unidade de Medida',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Quantidade',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Lógica para enviar os dados do formulário
                },
                child: Text('Adicionar a lista'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}