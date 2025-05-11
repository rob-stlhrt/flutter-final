import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final int categoryId;
  final String categoryName;
  final String categoryState;

  const CategoryCard({
    Key? key,
    required this.categoryId,
    required this.categoryName,
    required this.categoryState,
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
            Icon(Icons.category, size: 40, color: Colors.blue.shade700),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categoryName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ID: $categoryId',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    'Estado: $categoryState',
                    style: TextStyle(
                      fontSize: 14,
                      color: 
                      categoryState.toLowerCase() == 'activo' || 
                      categoryState.toLowerCase() == 'Activo' || 
                      categoryState.toLowerCase() == 'activa' || 
                      categoryState.toLowerCase() == 'Activa'
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
