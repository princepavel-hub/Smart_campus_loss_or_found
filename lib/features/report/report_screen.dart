import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/models/campus_item.dart';
import '../../providers/app_providers.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({required this.kind, super.key});
  final ReportKind kind;

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _verification = TextEditingController();
  final _dropOff = TextEditingController();
  final _contact = TextEditingController();
  final _otherCategory = TextEditingController();
  final _otherLocation = TextEditingController();
  String _category = 'Electronics';
  String _location = 'Central Library';
  XFile? _photo;
  bool _saving = false;

  bool get _isFound => widget.kind == ReportKind.found;

  @override
  void dispose() {
    for (final controller in [
      _title,
      _description,
      _verification,
      _dropOff,
      _contact,
      _otherCategory,
      _otherLocation,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(_isFound ? 'Report found item' : 'Report lost item'),
    ),
    body: Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          _Header(kind: widget.kind),
          const SizedBox(height: 22),
          Text(
            'Item details',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          TextFormField(
            key: const Key('report_title'),
            controller: _title,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'Item title',
              prefixIcon: Icon(Icons.inventory_2_outlined),
            ),
            validator: _required,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            key: const Key('report_category'),
            initialValue: _category,
            decoration: const InputDecoration(
              labelText: 'Category',
              prefixIcon: Icon(Icons.category_outlined),
            ),
            items: [...categories.skip(1), 'Other']
                .map(
                  (value) => DropdownMenuItem(value: value, child: Text(value)),
                )
                .toList(),
            onChanged: (value) => setState(() => _category = value!),
          ),
          if (_category == 'Other') ...[
            const SizedBox(height: 12),
            TextFormField(
              key: const Key('report_other_category'),
              controller: _otherCategory,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Specify category',
                prefixIcon: Icon(Icons.edit_outlined),
              ),
              validator: _required,
            ),
          ],
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            key: const Key('report_location'),
            initialValue: _location,
            decoration: InputDecoration(
              labelText: _isFound ? 'Location found' : 'Last known location',
              prefixIcon: const Icon(Icons.location_on_outlined),
            ),
            items: [...campusLocations.skip(1), 'Other']
                .map(
                  (value) => DropdownMenuItem(value: value, child: Text(value)),
                )
                .toList(),
            onChanged: (value) => setState(() => _location = value!),
          ),
          if (_location == 'Other') ...[
            const SizedBox(height: 12),
            TextFormField(
              key: const Key('report_other_location'),
              controller: _otherLocation,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: _isFound
                    ? 'Specify where it was found'
                    : 'Specify last known location',
                prefixIcon: const Icon(Icons.edit_location_alt_outlined),
              ),
              validator: _required,
            ),
          ],
          const SizedBox(height: 12),
          TextFormField(
            controller: _description,
            minLines: 3,
            maxLines: 5,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'Public description',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.notes_rounded),
            ),
            validator: _required,
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: _pickPhoto,
            icon: const Icon(Icons.add_a_photo_outlined),
            label: Text(
              _photo == null ? 'Attach a photo (optional)' : 'Change photo',
            ),
          ),
          if (_photo != null) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: kIsWeb
                  ? Image.network(_photo!.path, height: 160, fit: BoxFit.cover)
                  : Image.file(
                      File(_photo!.path),
                      height: 160,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox(
                            height: 80,
                            child: Center(child: Text('Photo selected')),
                          ),
                    ),
            ),
          ],
          const SizedBox(height: 24),
          if (_isFound) ...[
            Text(
              'Custody information',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _dropOff,
              decoration: const InputDecoration(
                labelText: 'Current drop-off location',
                prefixIcon: Icon(Icons.security_rounded),
              ),
              validator: _required,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _contact,
              decoration: const InputDecoration(
                labelText: 'Finder contact or matricule',
                prefixIcon: Icon(Icons.contact_phone_outlined),
              ),
              validator: _required,
            ),
            const SizedBox(height: 24),
          ],
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.lock_outline_rounded),
                      const SizedBox(width: 8),
                      Text(
                        'Private verification',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    'This answer is encrypted on-device and is never shown publicly.',
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _verification,
                    minLines: 2,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: _isFound
                          ? 'Ask about a detail only the owner knows'
                          : 'Hidden mark, wallpaper, key-ring detail…',
                      alignLabelWithHint: true,
                    ),
                    validator: _required,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            key: const Key('submit_report'),
            onPressed: _saving ? null : _submit,
            icon: _saving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check_rounded),
            label: Text(_saving ? 'Saving securely…' : 'Submit report'),
          ),
          const SizedBox(height: 10),
          Text(
            'Works offline · syncs automatically when connected',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    ),
  );

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'This field is required' : null;

  Future<void> _pickPhoto() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Take a photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from library'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;
    final photo = await ImagePicker().pickImage(
      source: source,
      imageQuality: 72,
      maxWidth: 1600,
    );
    if (mounted) setState(() => _photo = photo);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final photoPath = kIsWeb && _photo != null
        ? 'data:${_photo!.mimeType ?? 'image/jpeg'};base64,${base64Encode(await _photo!.readAsBytes())}'
        : _photo?.path;
    final id = 'CL-${1000 + DateTime.now().millisecondsSinceEpoch % 9000}';
    final item = CampusItem(
      id: id,
      title: _title.text.trim(),
      category: _category == 'Other' ? _otherCategory.text.trim() : _category,
      location: _location == 'Other' ? _otherLocation.text.trim() : _location,
      description: _description.text.trim(),
      reportKind: widget.kind,
      status: _isFound ? ItemStatus.inVault : ItemStatus.lost,
      reportedAt: DateTime.now(),
      dropOffLocation: _isFound ? _dropOff.text.trim() : null,
      reporterContact: _isFound ? _contact.text.trim() : null,
      photoPath: photoPath,
      pendingSync: true,
    );
    await ref
        .read(repositoryProvider)
        .saveItem(item, verificationAnswer: _verification.text.trim());
    if (!mounted) return;
    setState(() => _saving = false);
    if (_isFound) {
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Vault tag generated'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QrImageView(data: 'campuslost://item/$id', size: 190),
              const SizedBox(height: 12),
              Text(
                id,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
              ),
              const Text('Print or attach this QR code to the physical item.'),
            ],
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Done'),
            ),
          ],
        ),
      );
    }
    if (mounted) context.go('/item/$id');
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.kind});
  final ReportKind kind;
  @override
  Widget build(BuildContext context) {
    final found = kind == ReportKind.found;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: found
              ? const [Color(0xFF1D4ED8), Color(0xFF2563EB)]
              : const [Color(0xFFB45309), Color(0xFFF59E0B)],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(
            found ? Icons.volunteer_activism_rounded : Icons.search_rounded,
            size: 38,
            color: Colors.white,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  found ? 'Thank you for helping!' : 'We’ll help you look.',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  found
                      ? 'Register the item so its owner can find it safely.'
                      : 'Precise details improve the chance of a match.',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
