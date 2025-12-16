import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../providers/recipe_provider.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

// Conditional imports
import 'add_recipe_page_stub.dart'
    if (dart.library.io) 'add_recipe_page_mobile.dart'
    if (dart.library.html) 'add_recipe_page_web.dart' as platform;

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
  dynamic _selectedImage; // Can be File (mobile) or html.File (web)
  Uint8List? _webImageBytes; // For web preview

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (kIsWeb) {
        // Web: read bytes for preview
        final bytes = await image.readAsBytes();
        setState(() {
          _webImageBytes = bytes;
          _selectedImage = image; // Store XFile for web
        });
      } else {
        // Mobile: use File
        final file = await platform.convertToFile(image);
        setState(() {
          _selectedImage = file;
        });
      }
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
        // Convert XFile to appropriate type for the platform
        final photoFile = kIsWeb 
            ? await platform.convertToFile(_selectedImage as XFile)
            : _selectedImage;
            
        await context.read<RecipeProvider>().addRecipe(
              title: _titleController.text,
              description: _descriptionController.text,
              cookingMethod: _methodController.text,
              ingredients: _ingredientsController.text,
              photo: photoFile,
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
                    image: _getImageDecoration(),
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

  DecorationImage? _getImageDecoration() {
    if (_selectedImage == null) return null;
    
    if (kIsWeb && _webImageBytes != null) {
      return DecorationImage(
        image: MemoryImage(_webImageBytes!),
        fit: BoxFit.cover,
      );
    } else if (!kIsWeb && _selectedImage != null) {
      return DecorationImage(
        image: platform.getFileImage(_selectedImage),
        fit: BoxFit.cover,
      );
    }
    
    return null;
  }
}
