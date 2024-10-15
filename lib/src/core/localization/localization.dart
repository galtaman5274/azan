import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
export 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Extension method on [BuildContext] which gives a quick
/// access to the `AppLocalization` type.
extension LocalizationContext on BuildContext {
  /// Returns the [AppLocalizations] instance.
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
