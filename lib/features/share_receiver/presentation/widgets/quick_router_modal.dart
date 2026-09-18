import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/vault_types.dart';
import '../../../../core/localization/localization_extension.dart';
import '../cubit/share_cubit.dart';
import '../cubit/share_state.dart';

/// Translucent Quick Router Modal displayed upon intercepting shared content.
///
/// Features:
///   - Material 3 dual theming (no hardcoded colors, purely driven by [Theme.of]).
///   - Full dual localization (Arabic primary, English secondary via [context.l10n]).
///   - 4-slot grid: Docs, Read Later, Quick Notes, Temp Vault.
///   - Outside tap interception auto-routing to Temp Vault with 72h TTL.
///   - Sub-500ms execution SLA with haptic confirmation and instant OS exit.
class QuickRouterModal extends StatelessWidget {
  const QuickRouterModal({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    return BlocConsumer<ShareCubit, ShareState>(
      listener: (context, state) async {
        if (state is ShareSuccess) {
          // Provide tactile feedback confirming persistence
          await HapticFeedback.mediumImpact();
          // Instant dismissal back to host application (<200ms)
          await Future.delayed(const Duration(milliseconds: 150));
          await SystemNavigator.pop();
        }
      },
      builder: (context, state) {
        final isSaving = state is ShareSaving;
        final selectedCategory = state is ShareSaving ? state.category : null;

        return PopScope(
          canPop: !isSaving,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop && !isSaving) {
              // Intercept back button to safely persist in Temp Vault
              context.read<ShareCubit>().dismissToTempVault();
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top drag indicator
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Header with logo/title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.appName,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
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
                      ),
                  ],
                ),
                const SizedBox(height: 16),

                // 2x2 Category Grid
                Row(
                  children: [
                    Expanded(
                      child: _CategoryTile(
                        category: VaultCategory.docs,
                        icon: Icons.badge_outlined,
                        title: l10n.catDocs,
                        subtitle: l10n.catDocsSub,
                        isSelected: selectedCategory == VaultCategory.docs,
                        isDisabled: isSaving,
                        onTap: () => context
                            .read<ShareCubit>()
                            .routePayload(VaultCategory.docs),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _CategoryTile(
                        category: VaultCategory.readLater,
                        icon: Icons.menu_book_outlined,
                        title: l10n.catReadLater,
                        subtitle: l10n.catReadLaterSub,
                        isSelected: selectedCategory == VaultCategory.readLater,
                        isDisabled: isSaving,
                        onTap: () => context
                            .read<ShareCubit>()
                            .routePayload(VaultCategory.readLater),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _CategoryTile(
                        category: VaultCategory.quickNotes,
                        icon: Icons.lightbulb_outline,
                        title: l10n.catQuickNotes,
                        subtitle: l10n.catQuickNotesSub,
                        isSelected: selectedCategory == VaultCategory.quickNotes,
                        isDisabled: isSaving,
                        onTap: () => context
                            .read<ShareCubit>()
                            .routePayload(VaultCategory.quickNotes),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _CategoryTile(
                        category: VaultCategory.tempVault,
                        icon: Icons.hourglass_empty_outlined,
                        title: l10n.catTempVault,
                        subtitle: l10n.catTempVaultSub,
                        isSelected: selectedCategory == VaultCategory.tempVault,
                        isDisabled: isSaving,
                        onTap: () => context
                            .read<ShareCubit>()
                            .routePayload(VaultCategory.tempVault),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final VaultCategory category;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback onTap;

  const _CategoryTile({
    required this.category,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.isDisabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final tileBg = isSelected
        ? colorScheme.primary.withValues(alpha: 0.15)
        : theme.cardColor;

    final borderColor = isSelected
        ? colorScheme.primary
        : colorScheme.outline.withValues(alpha: 0.2);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isDisabled ? null : onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: tileBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: isSelected ? 1.5 : 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 22,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                  fontSize: 11,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
