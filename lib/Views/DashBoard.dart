import 'package:flutter/material.dart';

class EmpresaSelectionPage extends StatefulWidget {
  @override
  _EmpresaSelectionPageState createState() => _EmpresaSelectionPageState();
}

class _EmpresaSelectionPageState extends State<EmpresaSelectionPage> {
  String? selectedEmpresa;
  final List<String> empresas = [
    'Empresa A',
    'Empresa B',
    'Empresa C',
    'Empresa D',
  ];

  void _showTokenModal(BuildContext context) {
    final TextEditingController tokenController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tokenController,
                decoration: InputDecoration(labelText: 'Digite o Token de Acesso'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Lógica de validação do token com a API
                  final token = tokenController.text;
                  if (token == 'TOKEN_VALIDO') {
                    Navigator.of(context).pop(); // Fecha o modal
                    Navigator.of(context).pushReplacementNamed('/home'); // Navega para a tela HOME
                  } else {
                    // Exibe mensagem de erro ou faz outra ação
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Token inválido!')),
                    );
                  }
                },
                child: Text('Confirmar Token'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione sua Empresa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: empresas.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedEmpresa = empresas[index];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: selectedEmpresa == empresas[index]
                              ? Colors.blue
                              : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          empresas[index],
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (selectedEmpresa != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () => _showTokenModal(context),
                  child: Text('Confirmar'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
