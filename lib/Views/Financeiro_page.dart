import 'package:flutter/material.dart';
import '../Controllers/Financeiro_Controller.dart';
import 'Boleto_Container.dart';
import '../Controllers/AppDrawer.dart';

class FinanceiroPage extends StatefulWidget {
  @override
  _FinanceiroPageState createState() => _FinanceiroPageState();
}

class _FinanceiroPageState extends State<FinanceiroPage> {
  final FinanceiroController controller = FinanceiroController();
  String selectedMonthYear = "08/2024";
  int? selectedContainerIndex;

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
              items: controller.getMonthsAndYears().map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedMonthYear = newValue!;
                  controller.filterBoletosByMonthYear(selectedMonthYear);
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.boletos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedContainerIndex = index;
                    });
                  },
                  child: BoletoContainer(
                    boleto: controller.boletos[index],
                    isSelected: selectedContainerIndex == index,
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
                      controller.downloadBoleto(selectedContainerIndex!);
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
