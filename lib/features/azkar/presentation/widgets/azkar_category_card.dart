import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AzkarCategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const AzkarCategoryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // In dark mode, we might want slightly different surface colors to match the image
    final backgroundColor = isDark ? colorScheme.surfaceContainerHighest : const Color(0xFFF3F1E8); // Off-white/cream for light mode

    return Card(
      elevation: 0,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: colorScheme.outlineVariant.withOpacity(0.3),
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              // Icon at Top-End (Left in RTL, Right in LTR)
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Icon(
                  icon,
                  color: colorScheme.primary,
                  size: 28,
                ),
              ),
              
              // Title and Subtitle at Center-Start (Right in RTL, Left in LTR)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24), // Push down slightly from top
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? Colors.grey[400] : colorScheme.primary.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Arrow at Bottom-End (Left in RTL, Right in LTR)
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: isDark ? Colors.grey[400] : colorScheme.primary.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
