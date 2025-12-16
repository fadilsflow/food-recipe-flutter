import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../providers/recipe_provider.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _methodController = TextEditingController();
  final _ingredientsController = TextEditingController();
  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select an image")),
        );
        return;
      }

      try {
        await context.read<RecipeProvider>().addRecipe(
              title: _titleController.text,
              description: _descriptionController.text,
              cookingMethod: _methodController.text,
              ingredients: _ingredientsController.text,
              photo: _selectedImage!,
            );
        if (!mounted) return;
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Recipe added successfully!")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Add Recipe", style: TextStyle(color: AppTheme.secondaryColor)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppTheme.secondaryColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image Picker
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    image: _selectedImage != null
                        ? DecorationImage(
                            image: FileImage(_selectedImage!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _selectedImage == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                            SizedBox(height: 8),
                            Text("Tap to add photo", style: TextStyle(color: Colors.grey)),
                          ],
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 24),
              CustomTextField(
                label: "Title",
                icon: Icons.title,
                controller: _titleController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: "Description",
                icon: Icons.description,
                controller: _descriptionController,
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: "Ingredients",
                icon: Icons.list,
                controller: _ingredientsController,
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: "Cooking Method",
                icon: Icons.kitchen,
                controller: _methodController,
                maxLines: 4,
              ),
              const SizedBox(height: 32),
              Consumer<RecipeProvider>(
                 builder: (context, provider, _) {
                   return PrimaryButton(
                     text: "Share Recipe",
                     onPressed: _submit,
                     isLoading: provider.isLoading,
                   );
                 }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
