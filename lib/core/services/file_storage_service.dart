import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// Manages private sandboxed file storage for sensitive captured media.
///
/// Prevents the Android Content URI trap by synchronously copying byte streams
/// into app-private sandboxed storage before Activity dismissal.
///
/// Enforces media privacy by injecting a `.nomedia` marker to prevent OS galleries
/// and cloud sync utilities from scanning sensitive personal documents.
class FileStorageService {
  static const String _vaultDocsFolder = 'vault/docs';
  static const String _noMediaFile = '.nomedia';
  final Uuid _uuid;

  FileStorageService({Uuid? uuid}) : _uuid = uuid ?? const Uuid();

  /// Ensures the sandboxed vault directory and `.nomedia` marker exist.
  Future<Directory> getOrCreateVaultDirectory() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final vaultPath = p.join(docsDir.path, _vaultDocsFolder);
    final dir = Directory(vaultPath);

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    // Inject .nomedia on Android to hide documents from MediaStore and photo galleries
    if (Platform.isAndroid) {
      final noMedia = File(p.join(vaultPath, _noMediaFile));
      if (!await noMedia.exists()) {
        await noMedia.create();
      }
    }

    return dir;
  }

  /// Copies an incoming file stream from a temporary path or content URI
  /// into the private vault sandbox.
  ///
  /// Returns the absolute local file path of the cloned file.
  Future<String> copyToVault(String sourcePath) async {
    final vaultDir = await getOrCreateVaultDirectory();
    final ext = p.extension(sourcePath);
    final targetFileName = '${_uuid.v4()}${ext.isNotEmpty ? ext : ".bin"}';
    final targetPath = p.join(vaultDir.path, targetFileName);

    final sourceFile = File(sourcePath);
    await sourceFile.copy(targetPath);

    return targetPath;
  }
}
