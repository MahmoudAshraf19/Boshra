import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool outlined;

  const CustomActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.backgroundColor,
    this.foregroundColor,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBg = outlined ? Colors.transparent : Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.1);
    final defaultFg = outlined ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.primaryContainer;
    
    return Material(
      color: backgroundColor ?? defaultBg,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: outlined
              ? BoxDecoration(
                  border: Border.all(color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(16),
                )
              : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: foregroundColor ?? defaultFg,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: foregroundColor ?? defaultFg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
