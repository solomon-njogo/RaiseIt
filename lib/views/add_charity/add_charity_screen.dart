import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddCharityScreen extends StatefulWidget {
  @override
  _AddCharityScreenState createState() => _AddCharityScreenState();
}

class _AddCharityScreenState extends State<AddCharityScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _targetAmountController = TextEditingController();

  File? _imageFile;
  String? _selectedCategory;
  DateTime? _startDate;
  DateTime? _endDate;

  /// **🔹 List of charity categories**
  final List<String> _charityCategories = [
    "Nonprofit",
    "Community",
    "Emergency",
    "Medical",
    "Memorial",
    "Environment",
    "Animal",
    "Faith",
    "Volunteer",
    "Family",
    "Wishes"
  ];

  /// **🔹 Pick Image from Gallery**
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  /// **🔹 Select Date Function**
  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime(2100);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate ? (_startDate ?? initialDate) : (_endDate ?? initialDate),
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  /// **🔹 Format Number with Commas**
  String _formatNumber(String s) {
    if (s.isEmpty) return '';
    return NumberFormat("#,###").format(int.parse(s.replaceAll(',', '')));
  }

  /// **🔹 Handle Input for Target Amount**
  void _onTargetAmountChanged(String value) {
    String newValue = _formatNumber(value);
    if (newValue != value) {
      _targetAmountController.value = TextEditingValue(
        text: newValue,
        selection: TextSelection.collapsed(offset: newValue.length),
      );
    }
  }

  /// **🔹 Add Charity to Firestore**
  Future<void> _addCharity() async {
    if (_formKey.currentState!.validate() && _startDate != null && _endDate != null) {
      try {
        await FirebaseFirestore.instance.collection('charities').add({
          'name': _nameController.text,
          'description': _descriptionController.text,
          'category': _selectedCategory ?? '',
          'location': _locationController.text,
          'targetAmount': double.parse(_targetAmountController.text.replaceAll(',', '')),
          'raisedAmount': 0.0,
          'startDate': _startDate!.toIso8601String(),
          'endDate': _endDate!.toIso8601String(),
          'image': _imageFile?.path ?? '',
          'updates': [],
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Charity added successfully')),
        );

        _formKey.currentState!.reset();
        setState(() {
          _imageFile = null;
          _selectedCategory = null;
          _startDate = null;
          _endDate = null;
        });

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add charity: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Charity')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter the charity name' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a description' : null,
              ),

              /// **🔹 Category Dropdown**
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(labelText: "Category"),
                items: _charityCategories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                validator: (value) => value == null ? 'Please select a category' : null,
              ),

              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a location' : null,
              ),
              TextFormField(
                controller: _targetAmountController,
                decoration: InputDecoration(labelText: 'Target Amount'),
                keyboardType: TextInputType.number,
                onChanged: _onTargetAmountChanged,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter a target amount';
                  if (double.tryParse(value.replaceAll(',', '')) == null) return 'Please enter a valid number';
                  return null;
                },
              ),

              /// **🔹 Start Date Picker**
              ListTile(
                title: Text("Start Date"),
                subtitle: Text(_startDate != null
                    ? "${_startDate!.toLocal()}".split(' ')[0]
                    : "Select a start date"),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _pickDate(context, true),
              ),

              /// **🔹 End Date Picker**
              ListTile(
                title: Text("End Date"),
                subtitle: Text(_endDate != null
                    ? "${_endDate!.toLocal()}".split(' ')[0]
                    : "Select an end date"),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _pickDate(context, false),
              ),

              /// **🔹 Image Picker**
              SizedBox(height: 20),
              Text("Upload Charity Image", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              _imageFile != null
                  ? Column(
                children: [
                  Image.file(_imageFile!, height: 150, width: 150, fit: BoxFit.cover),
                  TextButton.icon(
                    onPressed: _pickImage,
                    icon: Icon(Icons.image),
                    label: Text("Change Image"),
                  ),
                ],
              )
                  : ElevatedButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.upload),
                label: Text("Pick Image"),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addCharity,
                child: Text('Add Charity'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
