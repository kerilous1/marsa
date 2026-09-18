// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vault_query_dao.dart';

// ignore_for_file: type=lint
mixin _$VaultQueryDaoMixin on DatabaseAccessor<VaultDatabase> {
  $VaultEntriesTable get vaultEntries => attachedDatabase.vaultEntries;
  VaultQueryDaoManager get managers => VaultQueryDaoManager(this);
}

class VaultQueryDaoManager {
  final _$VaultQueryDaoMixin _db;
  VaultQueryDaoManager(this._db);
  $$VaultEntriesTableTableManager get vaultEntries =>
      $$VaultEntriesTableTableManager(_db.attachedDatabase, _db.vaultEntries);
}
