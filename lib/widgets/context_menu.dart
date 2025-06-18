import 'package:flutter/material.dart';
import 'package:smart_context_menu/utils/responsive.dart';

class ContextMenu extends StatelessWidget {
  final VoidCallback onClose;

  const ContextMenu({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveWidget.isDesktop(context) ? 160 :90,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8)
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildMenuItem("Create"),
          buildMenuItem("Edit"),
          buildMenuItem("Remove"),
        ],
      ),
    );
  }

  Widget buildMenuItem(String label) {
    return InkWell(
      onTap: onClose,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Text(label),
      ),
    );
  }
}
