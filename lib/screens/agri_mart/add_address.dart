// ignore_for_file: use_build_context_synchronously

import 'package:agrisync/services/agri_mart_service_user.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _flatNumberController = TextEditingController();
  final TextEditingController _streetRoadController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _countryController =
      TextEditingController(text: 'India');

  bool loadAddress = false;
  String? selectedState;

  final List<String> _states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal'
  ];

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    setState(() => loadAddress = true);

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        _handleLocationFailure();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        _handleLocationFailure();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          // ignore: deprecated_member_use
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _streetController.text = place.street ?? '';
          _cityController.text = place.locality ?? '';
          selectedState = place.administrativeArea;
          _postalCodeController.text = place.postalCode ?? '';
        });
      }
    } catch (e) {
      _handleLocationFailure();
    } finally {
      setState(() => loadAddress = false);
    }
  }

  void _handleLocationFailure() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Failed to fetch location. Enter manually.')),
    );
    setState(() => loadAddress = false);
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final res = await AgriMartServiceUser.instance.updateUserAddress(
        _fullNameController.text,
        '+91 ${_phoneController.text}',
        _flatNumberController.text,
        _streetRoadController.text,
        _streetController.text,
        _cityController.text,
        selectedState ?? '',
        _countryController.text,
        _postalCodeController.text,
      );
      if (res == null) {
        showSnackBar("Address Updated successfully", context);
        Navigator.pop(context, 'address-added');
      } else {
        showSnackBar(res, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff338864),
        title: Text(
          appLocalizations.enterShippingAddress,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: loadAddress
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    _buildTextField(_fullNameController, appLocalizations.name,
                        appLocalizations.enterFullName,
                        validator: (value) => value!.isEmpty
                            ? appLocalizations.fullNameRequired
                            : null),
                    const SizedBox(height: 16),
                    _buildTextField(
                        _phoneController,
                        appLocalizations.mobile_no,
                        appLocalizations.enterMobileNumber,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        validator: (value) => value!.length != 10
                            ? appLocalizations.enterValidMobileNumber
                            : null),
                    const SizedBox(height: 16),
                    _buildTextField(
                        _flatNumberController,
                        appLocalizations.flat_no,
                        appLocalizations.enterFlatNumber,
                        validator: (value) => value!.isEmpty
                            ? appLocalizations.flatNumberRequired
                            : null),
                    const SizedBox(height: 16),
                    _buildTextField(
                        _streetRoadController,
                        appLocalizations.street_road,
                        appLocalizations.enterStreetName,
                        validator: (value) => value!.isEmpty
                            ? appLocalizations.streetRequired
                            : null),
                    const SizedBox(height: 16),
                    _buildTextField(_cityController, appLocalizations.city,
                        appLocalizations.enterCity,
                        validator: (value) => value!.isEmpty
                            ? appLocalizations.cityRequired
                            : null),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedState,
                      items: _states.map((state) {
                        return DropdownMenuItem(
                            value: state, child: Text(state));
                      }).toList(),
                      onChanged: (value) =>
                          setState(() => selectedState = value),
                      decoration: InputDecoration(
                          labelText: appLocalizations.state,
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                        _postalCodeController,
                        appLocalizations.postal_code,
                        appLocalizations.enterPostalCode,
                        keyboardType: TextInputType.number,
                        validator: (value) => value!.isEmpty
                            ? appLocalizations.postalCodeRequired
                            : null),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff338864)),
                      child: TextLato(
                        text: appLocalizations.submitAddress,
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, String hint,
      {TextInputType keyboardType = TextInputType.text,
      int? maxLength,
      String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      validator: validator,
      decoration: InputDecoration(
          labelText: label, hintText: hint, border: const OutlineInputBorder()),
    );
  }
}
