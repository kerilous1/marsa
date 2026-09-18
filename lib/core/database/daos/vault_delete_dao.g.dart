// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vault_delete_dao.dart';

// ignore_for_file: type=lint
mixin _$VaultDeleteDaoMixin on DatabaseAccessor<VaultDatabase> {
  $VaultEntriesTable get vaultEntries => attachedDatabase.vaultEntries;
  VaultDeleteDaoManager get managers => VaultDeleteDaoManager(this);
}

class VaultDeleteDaoManager {
  final _$VaultDeleteDaoMixin _db;
  VaultDeleteDaoManager(this._db);
  $$VaultEntriesTableTableManager get vaultEntries =>
      $$VaultEntriesTableTableManager(_db.attachedDatabase, _db.vaultEntries);
}
