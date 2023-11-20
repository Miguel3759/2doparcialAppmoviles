import 'package:rmgmapp/data.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final Data data;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const Item({super.key, required this.data, required this.onEditPressed, required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: colors.primary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.name),
                Text(data.email),
              ],
            ),
          ),
          IconButton(onPressed: onEditPressed, icon: const Icon(Icons.edit)),
          IconButton(onPressed: onDeletePressed, icon: const Icon(Icons.delete)),
        ],
      ),
    );
  }
}
