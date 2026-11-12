import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/utils/category_icon_helper.dart';
import '../../../../core/widgets/marsa_logo_emblem.dart';
import '../../../categories/domain/entities/category_entity.dart';
import '../../../categories/presentation/cubit/categories_cubit.dart';
import '../../../categories/presentation/cubit/categories_state.dart';
import '../../domain/usecases/route_raw_payload_usecase.dart';
import '../cubit/share_cubit.dart';
import '../cubit/share_state.dart';

/// Translucent Quick Router Modal displayed upon intercepting shared content or in-app quick capture.
///
/// Features:
///   - 100% Dynamic: Automatically renders active categories from [CategoriesCubit].
///   - Inline Quick Creation: Supports "+ New Vault" without navigating away.
///   - Instant Persistence: Sub-300ms execution SLA with haptic confirmation.
///   - External Share Exit: Invokes [SystemNavigator.pop] when [isExternalShare] is true.
///   - Safe Dismissal: Auto-routes to Temp Vault with 72h TTL on outside tap or back press.
class QuickRouterModal extends StatefulWidget {
  final bool isExternalShare;

  const QuickRouterModal({
    super.key,
    this.isExternalShare = false,
  });

  @override
  State<QuickRouterModal> createState() => _QuickRouterModalState();
}

class _QuickRouterModalState extends State<QuickRouterModal> {
  late final TextEditingController _textController;
  late final TextEditingController _newCategoryController;
  bool _isCreatingCategory = false;
  bool _newCategoryAutoPurge = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController()
      ..addListener(() {
        if (mounted) setState(() {});
      });
    _newCategoryController = TextEditingController();
  }

  Future<void> _pickAttachment() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['jpg', 'jpeg', 'png', 'webp', 'pdf'],
      );
      final pickedPath = result?.files.single.path;
      if (pickedPath != null && mounted) {
        context.read<ShareCubit>().attachFile(
              pickedPath,
              customTitle: _textController.text.trim().isNotEmpty
                  ? _textController.text.trim()
                  : null,
            );
      }
    } catch (e) {
      debugPrint('Error picking attachment: $e');
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _newCategoryController.dispose();
    super.dispose();
  }

  static const MethodChannel _appControlChannel =
      MethodChannel('com.example.marsa/app_control');

  /// Properly exits the app after external share by finishing the Android activity.
  Future<void> _exitApp() async {
    // finishAndRemoveTask removes the activity from recent apps and returns
    // to the source app immediately. Falls back to SystemNavigator.pop if channel fails.
    try {
      await _appControlChannel.invokeMethod<bool>('finishApp');
    } catch (_) {
      try {
        await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      } catch (_) {
        SystemNavigator.pop();
      }
    }
  }

  void _onDismiss() {
    context.read<ShareCubit>().dismissToTempVault();
    if (widget.isExternalShare) {
      _exitApp();
    } else if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final l10n = context.l10n;

    // Brand modal background: #E8F5EE in light mode, surface in dark mode
    final modalBg = isDark
        ? colorScheme.surface.withValues(alpha: 0.96)
        : const Color(0xFFE8F5EE).withValues(alpha: 0.98);

    return BlocConsumer<ShareCubit, ShareState>(
      listener: (context, state) async {
        if (state is ShareSuccess) {
          await HapticFeedback.mediumImpact();
          await Future.delayed(const Duration(milliseconds: 100));
          if (!context.mounted) return;

          if (widget.isExternalShare) {
            await _exitApp();
          } else {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          }
        }
      },
      builder: (context, state) {
        final isSaving = state is ShareSaving;
        final rawPayload = state is ShareInitial ? state.rawPayload : '';
        final filePath = state is ShareInitial ? state.filePath : null;
        final isManualCapture = rawPayload.isEmpty && filePath == null;

        return PopScope(
          canPop: !isSaving,
          onPopInvokedWithResult: (didPop, result) async {
            if (!didPop && !isSaving) {
              _onDismiss();
            }
          },
          child: Container(
            margin: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            decoration: BoxDecoration(
              color: modalBg,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: isDark
                    ? colorScheme.outline.withValues(alpha: 0.25)
                    : const Color(0xFF128C7E).withValues(alpha: 0.25),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top Drag Handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: colorScheme.onSurface.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // Header with MARSA emblem and action
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const MarsaLogoEmblem(size: 26),
                          const SizedBox(width: 8),
                          Text(
                            isManualCapture
                                ? l10n.quickCaptureTitle
                                : l10n.appName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      if (isSaving)
                        Row(
                          children: [
                            const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              l10n.saving,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        )
                      else
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: const Icon(Icons.close_rounded, size: 20),
                          onPressed: _onDismiss,
                          tooltip: l10n.cancel,
                        ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Content Preview Card
                  if (isManualCapture) ...[
                    TextField(
                      controller: _textController,
                      maxLines: 3,
                      autofocus: true,
                      style: theme.textTheme.bodyMedium,
                      decoration: InputDecoration(
                        hintText: l10n.quickCaptureHint,
                        filled: true,
                        fillColor: theme.cardColor,
                        contentPadding: const EdgeInsets.all(14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: colorScheme.outline.withValues(alpha: 0.25),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: colorScheme.outline.withValues(alpha: 0.2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                        ),
                        onPressed: isSaving ? null : _pickAttachment,
                        icon: const Icon(Icons.attach_file_rounded, size: 18),
                        label: Text(
                          Localizations.localeOf(context).languageCode == 'ar'
                              ? 'إرفاق صورة أو ملف PDF'
                              : 'Attach Image or PDF',
                        ),
                      ),
                    ),
                  ] else
                    _buildPayloadPreview(context, rawPayload, filePath),

                  const SizedBox(height: 14),

                  // Inline "+ New Vault" Creation Form
                  if (_isCreatingCategory)
                    _buildInlineCategoryCreator(context, isSaving)
                  else
                    // Dynamic Category Grid + Quick Add Button
                    BlocBuilder<CategoriesCubit, CategoriesState>(
                      builder: (context, catState) {
                        final categories = catState.categories;
                        final activeText = _textController.text.trim().isNotEmpty
                            ? _textController.text.trim()
                            : rawPayload;
                        final suggestedKey = (activeText.isNotEmpty || filePath != null)
                            ? RouteRawPayloadUseCase.suggestSmartCategoryKey(
                                rawPayload: activeText,
                                filePath: filePath,
                              )
                            : null;

                        return LayoutBuilder(
                          builder: (context, constraints) {
                            final crossAxisCount = constraints.maxWidth > 340 ? 2 : 1;
                            final totalItems = categories.length + 1; // +1 for the Add button

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: crossAxisCount == 2 ? 2.1 : 3.6,
                              ),
                              itemCount: totalItems,
                              itemBuilder: (context, index) {
                                // Last tile is "+ New Vault"
                                if (index == categories.length) {
                                  return _AddCategoryTile(
                                    isDisabled: isSaving,
                                    onTap: () {
                                      HapticFeedback.lightImpact();
                                      setState(() {
                                        _isCreatingCategory = true;
                                        _newCategoryController.clear();
                                      });
                                    },
                                  );
                                }

                                final cat = categories[index];
                                return _DynamicCategoryTile(
                                  category: cat,
                                  isSuggested: suggestedKey == cat.key,
                                  isDisabled: isSaving,
                                  onTap: () {
                                    final explicitText = _textController.text.trim();
                                    if (isManualCapture && explicitText.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(l10n.quickCaptureHint),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                      return;
                                    }

                                    context.read<ShareCubit>().routePayloadWithKey(
                                          categoryKey: cat.key,
                                          explicitPayload: explicitText,
                                          hasAutoPurge: cat.hasAutoPurge,
                                        );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Builds a rich preview card of the intercepted payload.
  Widget _buildPayloadPreview(BuildContext context, String rawPayload, String? filePath) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isUrl = rawPayload.startsWith('http://') || rawPayload.startsWith('https://');
    final lowerPath = filePath?.toLowerCase() ?? '';
    final isImage = filePath != null &&
        (lowerPath.endsWith('.jpg') ||
            lowerPath.endsWith('.jpeg') ||
            lowerPath.endsWith('.png') ||
            lowerPath.endsWith('.webp') ||
            lowerPath.endsWith('.gif'));
    final isPdf = lowerPath.endsWith('.pdf');

    final displayTitle = filePath != null &&
            (rawPayload.isEmpty ||
                rawPayload == filePath ||
                rawPayload.startsWith('/') ||
                rawPayload.startsWith('file:') ||
                rawPayload.startsWith('content:'))
        ? p.basename(filePath)
        : rawPayload;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        children: [
          if (isImage) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(filePath),
                width: 44,
                height: 44,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const Icon(Icons.image_outlined, size: 28),
              ),
            ),
            const SizedBox(width: 10),
          ] else if (isPdf) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.picture_as_pdf_rounded, size: 22, color: Colors.red),
            ),
            const SizedBox(width: 10),
          ] else if (isUrl) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.link_rounded, size: 20, color: colorScheme.primary),
            ),
            const SizedBox(width: 10),
          ] else ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.secondary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                filePath != null ? Icons.attach_file_rounded : Icons.description_outlined,
                size: 20,
                color: colorScheme.secondary,
              ),
            ),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Text(
              displayTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurface.withValues(alpha: 0.85),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the inline category creation card when user taps "+ New Vault".
  Widget _buildInlineCategoryCreator(BuildContext context, bool isSaving) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.35),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.addCategory,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _newCategoryController,
            autofocus: true,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: '${l10n.categoryNameHint}...',
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Checkbox(
                value: _newCategoryAutoPurge,
                onChanged: (val) => setState(() => _newCategoryAutoPurge = val ?? false),
              ),
              Expanded(
                child: Text(
                  '${l10n.catTempVault} (72h TTL)',
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => setState(() => _isCreatingCategory = false),
                child: Text(l10n.cancel),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: isSaving ? null : _saveAndRouteNewCategory,
                child: Text(l10n.save),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _saveAndRouteNewCategory() async {
    final name = _newCategoryController.text.trim();
    if (name.isEmpty) return;

    final categoriesCubit = context.read<CategoriesCubit>();
    final newKey = await categoriesCubit.createQuickCategory(
      name: name,
      iconKey: 'folder',
      colorHex: '#128C7E',
      hasAutoPurge: _newCategoryAutoPurge,
    );

    if (newKey != null && mounted) {
      final explicitText = _textController.text.trim();
      context.read<ShareCubit>().routePayloadWithKey(
            categoryKey: newKey,
            explicitPayload: explicitText,
            hasAutoPurge: _newCategoryAutoPurge,
          );
    }
  }
}

class _DynamicCategoryTile extends StatelessWidget {
  final CategoryEntity category;
  final bool isSuggested;
  final bool isDisabled;
  final VoidCallback onTap;

  const _DynamicCategoryTile({
    required this.category,
    this.isSuggested = false,
    required this.isDisabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final name = isArabic ? category.nameAr : category.nameEn;
    final icon = CategoryIconHelper.getIcon(category.iconKey);
    final color = CategoryIconHelper.hexToColor(category.colorHex);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isDisabled ? null : onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isSuggested
                ? color.withValues(alpha: 0.08)
                : theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color.withValues(alpha: isSuggested ? 0.85 : 0.3),
              width: isSuggested ? 1.6 : 1.0,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 20, color: color),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isSuggested)
                          Icon(
                            Icons.auto_awesome_rounded,
                            size: 14,
                            color: color,
                          ),
                      ],
                    ),
                    if (category.hasAutoPurge)
                      Text(
                        '72h TTL',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 10,
                          color: colorScheme.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddCategoryTile extends StatelessWidget {
  final bool isDisabled;
  final VoidCallback onTap;

  const _AddCategoryTile({
    required this.isDisabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isDisabled ? null : onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.primary.withValues(alpha: 0.4),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.add_rounded,
                  size: 20,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.addCategory,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
