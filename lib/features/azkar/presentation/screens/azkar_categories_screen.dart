import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/azkar_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import 'azkar_details_screen.dart';

class AzkarCategoriesScreen extends StatefulWidget {
  const AzkarCategoriesScreen({super.key});

  @override
  State<AzkarCategoriesScreen> createState() => _AzkarCategoriesScreenState();
}

class _AzkarCategoriesScreenState extends State<AzkarCategoriesScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AzkarProvider>();
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final categories = provider.groupedAzkar.keys.where((cat) {
      return cat.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.azkarAllCategories,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ابحث عن أذكار (مثال: السفر، المطر)...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: isDark ? Colors.grey[900] : Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: categories.isEmpty
                ? const Center(child: Text('لا توجد نتائج'))
                : ListView.separated(
                    itemCount: categories.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return ListTile(
                        leading: Icon(
                          Icons.eco_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(
                          category,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AzkarDetailsScreen(categoryName: category),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
