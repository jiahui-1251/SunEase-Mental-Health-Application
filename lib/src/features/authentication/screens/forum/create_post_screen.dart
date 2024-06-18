import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/text_strings.dart';
import 'package:fyp/src/features/authentication/screens/widgets/page_title_widget.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  final List<String> _categories = [
    'Academic',
    'Family',
    'Relationship',
    'Self-Exploration',
    'Others',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _createPost() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle post creation logic here
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Post created successfully!'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PageTitleWidget(title: tCreatePost, backgroundColor: tOrangeColor),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: tBlackColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text('Select Category', style: Theme.of(context).textTheme.bodyLarge),
                        icon: Icon(Icons.arrow_drop_down, color: tOrangeColor),
                        value: _selectedCategory,
                        items: _categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Container(
                              width: MediaQuery.of(context).size.width - 64, 
                              child: Text(
                                category,
                                style: Theme.of(context).textTheme.bodyLarge,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategory = newValue;
                          });
                        },
                        dropdownColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Post Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter a title' : null,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    controller: _contentController,
                    decoration: InputDecoration(
                      labelText: 'Post Content',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    maxLines: 5,
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter content' : null,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: _createPost,
                      style: ElevatedButton.styleFrom(
                        iconColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Create',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
