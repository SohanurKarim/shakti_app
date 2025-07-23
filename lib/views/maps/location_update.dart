import 'package:flutter/material.dart';

class BranchInfoForm extends StatefulWidget {
  @override
  _BranchInfoFormState createState() => _BranchInfoFormState();
}

class _BranchInfoFormState extends State<BranchInfoForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController branchCodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController thanaController = TextEditingController();
  final TextEditingController supervisionStatusController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Branch Info Form')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Branch Info Update',
                 style: TextStyle(
                  fontWeight: FontWeight.w600,
                   fontSize: 24,
                   //backgroundColor: Colors.blue
                 ),
                ),
              ),
              _buildTextField(
                label: 'Branch Code',
                controller: branchCodeController,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // Implement search
                  },
                ),
              ),
              _buildTextField(
                label: 'Phone Number',
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
              ),
              _buildTextField(
                label: 'Category',
                controller: categoryController,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'Latitude',
                      controller: latitudeController,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.my_location),
                        onPressed: () {
                          // Implement location picker
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      label: 'Longitude',
                      controller: longitudeController,
                    ),
                  ),
                ],
              ),
              _buildTextField(label: 'District', controller: districtController),
              _buildTextField(label: 'Thana', controller: thanaController),
              _buildTextField(label: 'Supervision Status', controller: supervisionStatusController),
              _buildTextField(label: 'Branch Landmark', controller: landmarkController),
              _buildTextField(
                label: 'Branch Address',
                controller: addressController,
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              /// 🔘 Full-width Elevated Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.update),
                  label: const Text('Update Info', style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontSize: 16),
                    backgroundColor: Colors.blue
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Updating Info...')),
                      );
                    }
                  },
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                'For any kind of assistance please contact with\n01847099601',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: suffixIcon,
          border: const OutlineInputBorder(),
        ),
        validator: (value) => value == null || value.isEmpty ? 'Please enter $label' : null,
      ),
    );
  }
}
