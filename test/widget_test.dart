import 'dart:ui';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marsa/app_config.dart';
import 'package:marsa/core/database/daos/vault_delete_dao.dart';
import 'package:marsa/core/database/daos/vault_insert_dao.dart';
import 'package:marsa/core/database/daos/vault_query_dao.dart';
import 'package:marsa/core/database/daos/vault_update_dao.dart';
import 'package:marsa/core/database/vault_database.dart';
import 'package:marsa/core/services/file_storage_service.dart';
import 'package:marsa/features/dashboard/data/repositories/delete_vault_repository_impl.dart';
import 'package:marsa/features/dashboard/data/repositories/query_vault_repository_impl.dart';
import 'package:marsa/features/dashboard/data/repositories/update_vault_repository_impl.dart';
import 'package:marsa/features/dashboard/domain/usecases/delete_vault_item_usecase.dart';
import 'package:marsa/features/dashboard/domain/usecases/get_items_by_category_usecase.dart';
import 'package:marsa/features/dashboard/domain/usecases/purge_expired_items_usecase.dart';
import 'package:marsa/features/dashboard/domain/usecases/search_vault_items_usecase.dart';
import 'package:marsa/features/dashboard/domain/usecases/update_item_category_usecase.dart';
import 'package:marsa/features/share_receiver/data/repositories/share_repository_impl.dart';
import 'package:marsa/features/share_receiver/domain/usecases/route_raw_payload_usecase.dart';
import 'package:marsa/main_common.dart';

void main() {
  setUpAll(() {
    AppConfig.initialize(
      flavor: Flavor.dev,
      appName: 'MARSA Dev',
      packageSuffix: '.dev',
      databaseName: 'marsa_test.sqlite',
    );
  });

  testWidgets('MarsaApp renders MainDashboardScreen on standard launch',
      (WidgetTester tester) async {
    final db = VaultDatabase.forTesting(NativeDatabase.memory());
    final insertDao = VaultInsertDao(db);
    final queryDao = VaultQueryDao(db);
    final deleteDao = VaultDeleteDao(db);
    final updateDao = VaultUpdateDao(db);

    final fileStorageService = FileStorageService();
    final shareRepo = ShareRepositoryImpl(insertDao);
    final queryRepo = QueryVaultRepositoryImpl(queryDao);
    final deleteRepo = DeleteVaultRepositoryImpl(
      deleteDao: deleteDao,
      queryDao: queryDao,
      fileStorageService: fileStorageService,
    );
    final updateRepo = UpdateVaultRepositoryImpl(updateDao);

    final routeRawPayloadUseCase = RouteRawPayloadUseCase(shareRepo);
    final getItemsByCategoryUseCase = GetItemsByCategoryUseCase(queryRepo);
    final searchVaultItemsUseCase = SearchVaultItemsUseCase(queryRepo);
    final deleteVaultItemUseCase = DeleteVaultItemUseCase(deleteRepo);
    final updateItemCategoryUseCase = UpdateItemCategoryUseCase(updateRepo);
    final purgeExpiredItemsUseCase = PurgeExpiredItemsUseCase(deleteRepo);

    await tester.pumpWidget(
      MarsaApp(
        database: db,
        fileStorageService: fileStorageService,
        routeRawPayloadUseCase: routeRawPayloadUseCase,
        getItemsByCategoryUseCase: getItemsByCategoryUseCase,
        searchVaultItemsUseCase: searchVaultItemsUseCase,
        deleteVaultItemUseCase: deleteVaultItemUseCase,
        updateItemCategoryUseCase: updateItemCategoryUseCase,
        purgeExpiredItemsUseCase: purgeExpiredItemsUseCase,
        initialLocale: const Locale('ar'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('مَرسى'), findsWidgets);
    await db.close();
  });
}
