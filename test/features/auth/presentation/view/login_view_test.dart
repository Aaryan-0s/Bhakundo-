import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nba_hub/config/router/app_route.dart';
import 'package:nba_hub/features/auth/domain/use_case/auth_usecase.dart';
import 'package:nba_hub/features/auth/presentation/viewmodel/auth_view_model.dart';

import '../../../../unit_test/auth_test.mocks.dart';

void main() {
  late AuthUseCase mockAuthUsecase;

  late bool isLogin;

  setUpAll(() async {
    mockAuthUsecase = MockAuthUseCase();

    isLogin = true;
  });
  testWidgets('login test with username and password and open dashboard',
      (WidgetTester tester) async {
    when(mockAuthUsecase.loginUser('aaryan', 'aaryan'))
        .thenAnswer((_) async => Right(isLogin));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider
              .overrideWith((ref) => AuthViewModel(mockAuthUsecase)),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.loginRoute,
          routes: AppRoute.getApplicationRoute(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'aaryan');
    await tester.enterText(find.byType(TextFormField).at(1), 'aaryan');

    await tester.tap(
      find.widgetWithText(ElevatedButton, 'Login'),
    );

    await tester.pumpAndSettle();

    expect(find.text('Today'), findsOneWidget);
  });
}
