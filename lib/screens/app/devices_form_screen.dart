import 'package:flutter/material.dart';
import 'package:flutter_hello/providers/device_form_provider.dart';
import 'package:flutter_hello/providers/devices_provider.dart';
import 'package:flutter_hello/widgets/custom_button_loading.dart';
import 'package:provider/provider.dart';

class DevicesFormScreen extends StatelessWidget {
  const DevicesFormScreen({super.key});

  static String route = "/app-devices-form";

  @override
  Widget build(BuildContext context) {
    final devicesProvider = Provider.of<DevicesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devices Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ChangeNotifierProvider(
          create: (_) => DeviceFormProvider(devicesProvider.selectedDevice),
          child: const DeviceForm(),
        ),
      ),
    );
  }
}

class DeviceForm extends StatelessWidget {
  const DeviceForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceForm = Provider.of<DeviceFormProvider>(context);
    final device = deviceForm.device;
    return Form(
      key: deviceForm.formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: device.name,
            decoration: InputDecoration(
                labelText: 'Name',
                errorText: deviceForm.errors.containsKey('name')
                    ? deviceForm.errors['name'][0]
                    : null),
            validator: (value) {
              if (value == null || value.isEmpty) {
                // return 'This field is required';
              }
              return null;
            },
            onSaved: (value) => device.name = value!,
          ),
          SizedBox(
            height: 20,
          ),
          CustomButtonLoading(
            isLoading: deviceForm.isLoading,
            text: device.id == null ? 'Create' : 'Update',
            onClick: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              if (deviceForm.validate()) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
