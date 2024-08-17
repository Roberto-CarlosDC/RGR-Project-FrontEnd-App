import '../Models/Boleto.dart';

class FinanceiroController {
  List<Boleto> boletos = [
    Boleto(title: "Boleto de Mensalidade", dueDate: "10/08/2024"),
    Boleto(title: "Boleto de Mensalidade", dueDate: "10/07/2024"),
    Boleto(title: "Boleto de Mensalidade", dueDate: "10/06/2024"),
  ];

  List<String> getMonthsAndYears() {
    return [
      '08/2024',
      '07/2024',
      '06/2024',
      // Adicione mais opções conforme necessário
    ];
  }

  void filterBoletosByMonthYear(String monthYear) {
    // Implementar lógica de filtro dos boletos
  }

  void downloadBoleto(int index) {
    // Implementar lógica de download do boleto
  }
}
