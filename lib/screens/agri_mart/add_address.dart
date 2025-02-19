// ignore_for_file: use_build_context_synchronously
import 'package:agrisync/services/agri_mart_service_user.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController =
      TextEditingController(text: '+91 ');
  final TextEditingController _flatNumberController = TextEditingController();
  final TextEditingController _streetRoadController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  Future<void> _fetchLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location services are disabled.')));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied.')));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied.')));
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _streetController.text = place.street ?? '';
          _cityController.text = place.locality ?? '';
          _stateController.text = place.administrativeArea ?? '';
          _countryController.text = place.country ?? '';
          _postalCodeController.text = place.postalCode ?? '';
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location fetched successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to get location: $e')));
    }
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final res = await AgriMartServiceUser.instance.updateUserAddress(
        _fullNameController.text,
        _phoneController.text,
        _flatNumberController.text,
        _streetRoadController.text,
        _streetController.text,
        _cityController.text,
        _stateController.text,
        _countryController.text,
        _postalCodeController.text,
      );
      if (res == null) {
        showSnackBar("Address Updated successfully", context);
        Navigator.pop(context);
      } else {
        showSnackBar(res, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff338864),
        title: Text(
          'Enter Shipping Address',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: _fetchLocation,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                  _fullNameController, 'Full Name', 'Enter your full name'),
              const SizedBox(height: 16),
              _buildTextField(
                  _phoneController, 'Phone Number', 'Enter your phone number',
                  keyboardType: TextInputType.phone, validator: (value) {
                if (value == null || value.isEmpty || value.length != 14) {
                  return 'Phone number must be 10 digits';
                }
                return null;
              }),
              const SizedBox(height: 16),
              _buildTextField(_flatNumberController, 'Flat Number',
                  'Enter your flat number'),
              const SizedBox(height: 16),
              _buildTextField(_streetRoadController, 'Street/Road Name',
                  'Enter your street or road name'),
              const SizedBox(height: 16),
              _buildTextField(_streetController, 'Street Address',
                  'Enter your street address'),
              const SizedBox(height: 16),
              _buildTextField(_cityController, 'City', 'Enter your city'),
              const SizedBox(height: 16),
              _buildTextField(_stateController, 'State', 'Enter your state'),
              const SizedBox(height: 16),
              _buildTextField(
                  _countryController, 'Country', 'Enter your country'),
              const SizedBox(height: 16),
              _buildTextField(_postalCodeController, 'Postal Code',
                  'Enter your postal code',
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontSize: 18),
                    backgroundColor: const Color(0xff338864),
                  ),
                  child: const Text(
                    'Submit Address',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTextField(
  TextEditingController controller,
  String label,
  String hint, {
  TextInputType keyboardType = TextInputType.text,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      border: const OutlineInputBorder(),
    ),
    keyboardType: keyboardType,
    validator: validator ??
        (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
  );
}
