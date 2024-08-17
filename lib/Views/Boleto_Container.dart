import 'package:flutter/material.dart';
import '../Models/Boleto.dart';

class BoletoContainer extends StatelessWidget {
  final Boleto boleto;
  final bool isSelected;

  BoletoContainer({
    required this.boleto,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
            : Colors.white,
        border: Border.all(
          color: isSelected
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
                boleto.title,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.0),
              Text(
                'Vencimento: ${boleto.dueDate}',
                style: TextStyle(fontSize: 14.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
