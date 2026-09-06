import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';

class DailyWirdCard extends StatelessWidget {
  final VoidCallback onContinue;

  const DailyWirdCard({
    super.key,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Determine morning or evening based on time
    // For simplicity, let's say morning is before 3:00 PM (15:00)
    final hour = DateTime.now().hour;
    final isMorning = hour < 15;
    
    final title = l10n.dailyWird;
    final typeStr = isMorning ? l10n.morningAzkar : l10n.eveningAzkar;
    final iconData = isMorning ? Icons.wb_sunny : Icons.nights_stay;
    final iconColor = isMorning ? Colors.orange.shade400 : Colors.indigo.shade400;
    final iconBg = isMorning ? Colors.orange.withValues(alpha: 0.1) : Colors.indigo.withValues(alpha: 0.1);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark 
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1) 
            : Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.inventory_2_outlined,
                color: Theme.of(context).textTheme.bodyMedium?.color,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Main Content
          Row(
            children: [
              // Weather / Time Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  iconData,
                  color: iconColor,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              
              // Text
              Expanded(
                child: Text(
                  typeStr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              
              // Continue Button (Text + Arrow)
              InkWell(
                onTap: onContinue,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        l10n.continueReading,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.green.shade400 : const Color(0xFF356B4E),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.adaptive.arrow_forward,
                        size: 16,
                        color: isDark ? Colors.green.shade400 : const Color(0xFF356B4E),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
