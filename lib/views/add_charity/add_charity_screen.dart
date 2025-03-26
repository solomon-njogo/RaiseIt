import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:raiseit/models/categories_model.dart';

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


  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
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

  String _formatNumber(String s) {
    if (s.isEmpty) return '';
    return NumberFormat("#,###").format(int.parse(s.replaceAll(',', '')));
  }

  void _onTargetAmountChanged(String value) {
    String newValue = _formatNumber(value);
    if (newValue != value) {
      _targetAmountController.value = TextEditingValue(
        text: newValue,
        selection: TextSelection.collapsed(offset: newValue.length),
      );
    }
  }

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
          'status': 'All',
          'updates': [],
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Charity added successfully')),
        );

        // Pop the screen after a short delay
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pop(context);
        });

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
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Charity', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Name Input
              _buildTextField(_nameController, "Charity Name", Icons.business, "Please enter the charity name"),

              /// Description Input
              _buildTextField(_descriptionController, "Description", Icons.info, "Please enter a description"),

              /// Category Dropdown
              _buildDropdown(),

              /// Location Input
              _buildTextField(_locationController, "Location", Icons.location_on, "Please enter a location"),

              /// Target Amount Input
              _buildTextField(
                _targetAmountController, "Target Amount", Icons.attach_money, "Please enter a target amount",
                keyboardType: TextInputType.number,
                onChanged: _onTargetAmountChanged,
              ),

              /// Start & End Date Pickers
              _buildDatePicker("Start Date", _startDate, () => _pickDate(context, true)),
              _buildDatePicker("End Date", _endDate, () => _pickDate(context, false)),

              /// Image Picker
              SizedBox(height: 20),
              Center(
                child: _imageFile != null
                    ? Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(_imageFile!, height: 180, width: screenWidth * 0.8, fit: BoxFit.cover),
                    ),
                    SizedBox(height: 10),
                    TextButton.icon(
                      onPressed: _pickImage,
                      icon: Icon(Icons.image, color: Colors.blue),
                      label: Text("Change Image", style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                )
                    : ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(Icons.upload),
                  label: Text("Upload Image"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),

              /// Submit Button
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _addCharity,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    child: Text('Add Charity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label,
      IconData icon,
      String validationMessage, {
        TextInputType keyboardType = TextInputType.text,
        Function(String)? onChanged,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: (value) {
          if (value.isNotEmpty) {
            String capitalizedValue = value[0].toUpperCase() + value.substring(1);
            controller.value = TextEditingValue(
              text: capitalizedValue,
              selection: TextSelection.collapsed(offset: capitalizedValue.length),
            );
          }
          if (onChanged != null) {
            onChanged(value);
          }
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) => value == null || value.isEmpty ? validationMessage : null,
      ),
    );
  }

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField<String>(
        value: _selectedCategory,
        decoration: InputDecoration(
          labelText: "Category",
          prefixIcon: Icon(Icons.category),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: charityCategories.map((category) {
          return DropdownMenuItem(
            value: category,
            child: Row(
              children: [
                Icon(charityCategoryIcons[category], color: Colors.blue), // Display icon
                SizedBox(width: 10),
                Text(category),
              ],
            ),
          );
        }).toList(),
        onChanged: (newValue) => setState(() => _selectedCategory = newValue),
        validator: (value) => value == null ? 'Please select a category' : null,
      ),
    );
  }


  Widget _buildDatePicker(String title, DateTime? date, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      subtitle: Text(date != null ? DateFormat.yMMMd().format(date) : "Select a date"),
      trailing: Icon(Icons.calendar_today),
      onTap: onTap,
    );
  }
}
