import 'package:flutter/material.dart';
import 'teste.dart';
import 'theme.dart';

class FinanceiroPage extends StatefulWidget {
  @override
  _FinanceiroPageState createState() => _FinanceiroPageState();
}

class _FinanceiroPageState extends State<FinanceiroPage> {
  String selectedMonthYear = "08/2024"; // Exemplo de mês/ano atual
  int? selectedContainerIndex;

  // Lista de boletos (Exemplo de dados estáticos)
  final List<Map<String, String>> boletos = [
    {"title": "Boleto de Mensalidade", "dueDate": "10/08/2024"},
    {"title": "Boleto de Mensalidade", "dueDate": "10/07/2024"},
    {"title": "Boleto de Mensalidade", "dueDate": "10/06/2024"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Financeiro'),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              value: selectedMonthYear,
              decoration: InputDecoration(
                labelText: 'Filtrar por Mês/Ano',
                border: OutlineInputBorder(),
              ),
              items: <String>[
                '08/2024',
                '07/2024',
                '06/2024',
                // Adicione mais opções conforme necessário
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedMonthYear = newValue!;
                  // Implementar o filtro de registros baseado no mês/ano selecionado
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: boletos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedContainerIndex = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: selectedContainerIndex == index
                          ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                          : Colors.white,
                      border: Border.all(
                        color: selectedContainerIndex == index
                            ? Theme.of(context).colorScheme.secondary
                            : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.picture_as_pdf, size: 40.0, color: Colors.grey),
                        SizedBox(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              boletos[index]['title']!,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'Vencimento: ${boletos[index]['dueDate']}',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: selectedContainerIndex != null
                  ? () {
                      // Implementar lógica de download do arquivo PDF
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Download do arquivo em andamento...'),
                        ),
                      );
                    }
                  : null,
              child: Text('Download Arquivo Selecionado'),
            ),
          ),
        ],
      ),
    );
  }
}
