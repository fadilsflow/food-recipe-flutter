import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:flutter_storage/data/services/auth_service.dart';
import 'package:flutter_storage/data/services/dio_client.dart';

@GenerateMocks([DioClient, Dio])
import 'auth_service_test.mocks.dart';

void main() {
  late AuthService authService;
  late MockDioClient mockDioClient;
  late MockDio mockDio;

  setUp(() {
    mockDioClient = MockDioClient();
    mockDio = MockDio();

    // Stub the dio getter to return our mockDio
    when(mockDioClient.dio).thenReturn(mockDio);

    authService = AuthService(dioClient: mockDioClient);
  });

  group('AuthService Unit Test', () {
    test('login returns data when API call is success (200)', () async {
      // Arrange
      const email = 'wahyufadil1140@gmail.com';
      const password = 'Admin123!';
      final responseData = {
        'status': 'success',
        'data': {
          'token': 'dummy_token',
          'user': {'id': 1, 'name': 'Test User'},
        },
      };

      // Mock the POST request
      when(mockDio.post(any, data: anyNamed('data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/login'),
          statusCode: 200,
          data: responseData,
        ),
      );

      // Act
      final result = await authService.login(email, password);

      // Assert
      expect(result, responseData['data']);
      verify(
        mockDio.post(any, data: {'email': email, 'password': password}),
      ).called(1);
    });

    test('login throws exception when API call fails', () async {
      // Arrange
      const email = 'wahyufadil1140@gmail.com';
      const password = 'Admin123!';
      final errorData = {'status': 'error', 'message': 'Invalid credentials'};

      when(mockDio.post(any, data: anyNamed('data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/login'),
          statusCode: 401,
          data: errorData,
        ),
      );

      // Act & Assert
      expect(() => authService.login(email, password), throwsException);
    });
  });
}
