import 'package:flutter/material.dart';

class SupplierCard extends StatelessWidget {
  final int providerId;
  final String providerName;
  final String providerLastName;
  final String providerMail;
  final String providerState;

  const SupplierCard({
    Key? key,
    required this.providerId,
    required this.providerName,
    required this.providerLastName,
    required this.providerMail,
    required this.providerState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.business, size: 40, color: Colors.deepPurple.shade700),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$providerName $providerLastName',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ID: $providerId',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    'Correo: $providerMail',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Estado: $providerState',
                    style: TextStyle(
                      fontSize: 14,
                      color: 
                      providerState.toLowerCase() == 'activo' || 
                      providerState.toLowerCase() == 'Activo' || 
                      providerState.toLowerCase() == 'activa' || 
                      providerState.toLowerCase() == 'Activa'
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
