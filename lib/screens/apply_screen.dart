import 'package:flutter/material.dart';

class ApplyScreen extends StatefulWidget {
  const ApplyScreen({super.key});

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _skillsController = TextEditingController();
  final _experienceController = TextEditingController();
  final _fieldController = TextEditingController();
  final _rateController = TextEditingController();

  @override
  void dispose() {
    _skillsController.dispose();
    _experienceController.dispose();
    _fieldController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  void _submitApplication() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil('/landing_after_apply', (_) => false);
    }
  }

  void _cancelApplication() {
    Navigator.of(context).pushNamedAndRemoveUntil('/main_nav', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apply')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _skillsController,
                decoration: const InputDecoration(labelText: 'Skills'),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _experienceController,
                decoration: const InputDecoration(labelText: 'Experience'),
                maxLines: 3,
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _fieldController,
                decoration: const InputDecoration(labelText: 'Field'),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _rateController,
                decoration: const InputDecoration(labelText: 'Rate'),
                validator:
                    (val) =>
                        double.tryParse(val ?? '') == null
                            ? 'Enter valid number'
                            : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitApplication,
                child: const Text('APPLY'),
              ),
              TextButton(
                onPressed: _cancelApplication,
                child: const Text('CANCEL'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
