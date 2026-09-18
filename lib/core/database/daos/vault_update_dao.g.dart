// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vault_update_dao.dart';

// ignore_for_file: type=lint
mixin _$VaultUpdateDaoMixin on DatabaseAccessor<VaultDatabase> {
  $VaultEntriesTable get vaultEntries => attachedDatabase.vaultEntries;
  VaultUpdateDaoManager get managers => VaultUpdateDaoManager(this);
}

class VaultUpdateDaoManager {
  final _$VaultUpdateDaoMixin _db;
  VaultUpdateDaoManager(this._db);
  $$VaultEntriesTableTableManager get vaultEntries =>
      $$VaultEntriesTableTableManager(_db.attachedDatabase, _db.vaultEntries);
}
