// print("Product Name: $productName");
// print("Description: $description");
// print("Categories: $categories");
// print("Price: $price");
// print("Unit: $unit");
// print("Product Image: $productImage");
// print("Stock Quantity: $stockQuantity");
// print("Created At: $createdAt");
// print("Expire At: $expireAt");
// ignore_for_file: use_build_context_synchronously

import 'package:agrisync/admin/service/agri_mart_service.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';

class AddProductFormPage extends StatefulWidget {
  const AddProductFormPage({super.key});

  @override
  AddProductFormPageState createState() => AddProductFormPageState();
}

class AddProductFormPageState extends State<AddProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each field
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  String? _productImage;
  final TextEditingController _stockQuantityController =
      TextEditingController();
  final TextEditingController _createdAtController = TextEditingController();
  final TextEditingController _expireAtController = TextEditingController();
  String? selectedUnit;
  bool isLoad = false;

  // Variables to store selected dates
  DateTime? _createdAt;
  DateTime? _expireAt;

  // List of categories
  final List<String> cropProductType = [
    "Seeds & Planting Material",
    "Fertilizers & Soil Enhancers",
    "Crop Protection (Pesticides, Biocontrol)",
    "Irrigation & Farm Machinery",
    "Tools & Equipment",
    "Animal & Aquaculture Products",
    "Greenhouse & Smart Farming Tech",
  ];

  // Selected categories
  final List<String> _selectedCategories = [];

  @override
  void dispose() {
    // Dispose all controllers
    _productNameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _unitController.dispose();
    _productImage = null;
    _stockQuantityController.dispose();
    _createdAtController.dispose();
    _expireAtController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isCreatedAt) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isCreatedAt) {
          _createdAt = picked;
          _createdAtController.text = "${picked.toLocal()}".split(" ")[0];
        } else {
          _expireAt = picked;
          _expireAtController.text = "${picked.toLocal()}".split(" ")[0];
        }
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() &&
        _productImage != null &&
        selectedUnit != null) {
      setState(() {
        isLoad = true;
      });
      String productName = _productNameController.text;
      String description = _descriptionController.text;
      double price = double.parse(_priceController.text);
      String unit = "${_unitController.text} ${selectedUnit!}";
      String productImage = _productImage!;
      int stockQuantity = int.parse(_stockQuantityController.text);
      DateTime createdAt = _createdAt!;
      DateTime expireAt = _expireAt!;
      List<String> categories = _selectedCategories;

      // print(productName);
      // print(description);
      // print(price);
      // print(unit);
      // print(productImage);
      // print(stockQuantity);
      // print(createdAt);
      // print(expireAt);
      // print(categories);

      final res = await AgriMartService.instance.uploadProduct(
        productName,
        description,
        categories,
        price,
        unit,
        productImage,
        stockQuantity,
        createdAt,
        expireAt,
      );
      if (res == null) {
        showSnackBar("Product Upload SucessFully", context);
        Navigator.pop(context);
      } else {
        showSnackBar(res, context);
      }
      setState(() {
        isLoad = true;
      });
      showSnackBar("Check the detail !", context);
    }
  }

  Future<void> _openCategorySelectionDialog(BuildContext context) async {
    // Create a local copy of selected categories for the dialog
    List<String> tempSelectedCategories = List.from(_selectedCategories);

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const TextLato(text: "Select Categories"),
              content: SingleChildScrollView(
                child: Column(
                  children: cropProductType.map((category) {
                    return CheckboxListTile(
                      title: Text(category),
                      value: tempSelectedCategories.contains(category),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            tempSelectedCategories.add(category);
                          } else {
                            tempSelectedCategories.remove(category);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const TextLato(text: "Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    // Update the main state with the selected categories
                    setState(() {
                      _selectedCategories.clear();
                      _selectedCategories.addAll(tempSelectedCategories);
                    });
                    Navigator.of(context).pop();
                  },
                  child: const TextLato(text: "Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextLato(text: "Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: isLoad
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.lightGreen,
                  ),
                )
              : ListView(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      controller: _productNameController,
                      decoration:
                          const InputDecoration(labelText: "Product Name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a product name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      controller: _descriptionController,
                      decoration:
                          const InputDecoration(labelText: "Description"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a description";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Category Selection
                    GestureDetector(
                      onTap: () => _openCategorySelectionDialog(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Categories",
                            hintText: _selectedCategories.isEmpty
                                ? "Select categories"
                                : _selectedCategories.join(", "),
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                          ),
                          validator: (value) {
                            if (_selectedCategories.isEmpty) {
                              return "Please select at least one category";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      controller: _priceController,
                      decoration: const InputDecoration(labelText: "Price"),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a price";
                        }
                        if (double.tryParse(value) == null) {
                          return "Please enter a valid number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: _unitController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Unit",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a unit";
                              }
                              if (double.tryParse(value) == null) {
                                return "Please enter a valid number";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: DropdownButtonFormField<String>(
                            value: selectedUnit,
                            decoration: const InputDecoration(
                              labelText: "Type",
                              // border: OutlineInputBorder(),
                            ),
                            items: ["kg", "ml", "gram", "litre", "piece"]
                                .map((unit) => DropdownMenuItem(
                                    value: unit, child: Text(unit)))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedUnit = value!;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Select unit type";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (_productImage != null)
                      ElevatedButton(
                          onPressed: () {
                            showImage(context, _productImage!);
                          },
                          child: const TextLato(text: "View Product Image")),
                    const SizedBox(
                      height: 10,
                    ),

                    ElevatedButton(
                        onPressed: () async {
                          _productImage = await pickImageAndConvertToBase64(
                              imageQuality: 5);
                          setState(() {});
                        },
                        child: const TextLato(text: "Select Product Image")),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _stockQuantityController,
                      decoration:
                          const InputDecoration(labelText: "Stock Quantity"),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a stock quantity";
                        }
                        if (int.tryParse(value) == null) {
                          return "Please enter a valid number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Created At Field with Date Picker
                    TextFormField(
                      controller: _createdAtController,
                      decoration: InputDecoration(
                        labelText: "Created At",
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context, true),
                        ),
                      ),
                      readOnly: true, // Prevent manual editing
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select a creation date";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Expire At Field with Date Picker
                    TextFormField(
                      controller: _expireAtController,
                      decoration: InputDecoration(
                        labelText: "Expire At",
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context, false),
                        ),
                      ),
                      readOnly: true, // Prevent manual editing
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select an expiration date";
                        }
                        if (_expireAt != null &&
                            _createdAt != null &&
                            _expireAt!.isBefore(_createdAt!)) {
                          return "Expiration date must be after creation date";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text("Submit"),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
