
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../providers/recipe_provider.dart';
import '../providers/auth_provider.dart';
import 'add_recipe_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecipeProvider>().fetchRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Recipes", style: AppTheme.displayMedium),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: AppTheme.secondaryColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddRecipePage()),
          );
          if (mounted) {
             context.read<RecipeProvider>().fetchRecipes();
          }
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.recipes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   const Icon(Icons.cookie_outlined, size: 80, color: Colors.grey),
                   const SizedBox(height: 16),
                   Text("No recipes yet.", style: AppTheme.bodyLarge),
                   Text("Tap + to add one!", style: AppTheme.bodyMedium),
                ],
              ),
            );
          }

          return AnimationLimiter(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.recipes.length,
              itemBuilder: (context, index) {
                final recipe = provider.recipes[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header Image
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Image.network(
                                  recipe.photoUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.broken_image, color: Colors.grey),
                                    );
                                  },
                                ),
                              ),
                            ),
                            // Content
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          recipe.title,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.secondaryColor,
                                          ),
                                        ),
                                      ),
                                      Consumer<AuthProvider>(
                                        builder: (context, auth, _) {
                                          // Only show delete if user owns it
                                          if (auth.currentUser?.id == recipe.userId) {
                                              return IconButton(
                                                icon: const Icon(Icons.delete_outline, color: Colors.red),
                                                onPressed: () {
                                                   _showDeleteDialog(context, recipe.id);
                                                },
                                              );
                                          }
                                          return const SizedBox();
                                        },
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    recipe.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Icon(Icons.person, size: 16, color: Colors.grey[600]),
                                      const SizedBox(width: 4),
                                      Text(
                                        recipe.user?.name ?? 'Unknown',
                                        style: TextStyle(
                                            color: Colors.grey[600], fontSize: 12),
                                      ),
                                      const Spacer(),
                                      const Icon(Icons.favorite, size: 16, color: Colors.redAccent),
                                      const SizedBox(width: 4),
                                      Text(
                                        "${recipe.likesCount}",
                                        style: TextStyle(
                                            color: Colors.grey[600], fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Recipe"),
        content: const Text("Are you sure you want to delete this recipe?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              await context.read<RecipeProvider>().deleteRecipe(id);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
