// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vault_insert_dao.dart';

// ignore_for_file: type=lint
mixin _$VaultInsertDaoMixin on DatabaseAccessor<VaultDatabase> {
  $VaultEntriesTable get vaultEntries => attachedDatabase.vaultEntries;
  VaultInsertDaoManager get managers => VaultInsertDaoManager(this);
}

class VaultInsertDaoManager {
  final _$VaultInsertDaoMixin _db;
  VaultInsertDaoManager(this._db);
  $$VaultEntriesTableTableManager get vaultEntries =>
      $$VaultEntriesTableTableManager(_db.attachedDatabase, _db.vaultEntries);
}
