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
    final base = p.basenameWithoutExtension(sourcePath);
    final cleanBase = base.replaceAll(RegExp(r'[^\w\s\.-]'), '_').trim();
    final uniquePrefix = _uuid.v4().substring(0, 8);
    final targetFileName = cleanBase.isNotEmpty
        ? '${uniquePrefix}_$cleanBase${ext.isNotEmpty ? ext : ".bin"}'
        : '${_uuid.v4()}${ext.isNotEmpty ? ext : ".bin"}';
    final targetPath = p.join(vaultDir.path, targetFileName);

    final sourceFile = File(sourcePath);
    try {
      await sourceFile.copy(targetPath);
    } catch (_) {
      final bytes = await sourceFile.readAsBytes();
      final targetFile = File(targetPath);
      await targetFile.writeAsBytes(bytes, flush: true);
    }

    return targetPath;
  }

  /// Safely deletes a file from the private vault sandbox.
  ///
  /// Returns true if file was deleted, false otherwise.
  Future<bool> deleteFile(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
    } catch (_) {
      // Ignore failures to delete non-existent or inaccessible files
    }
    return false;
  }
}
