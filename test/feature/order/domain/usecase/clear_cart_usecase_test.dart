// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:hamro_grocery_mobile/core/error/failure.dart';
// import 'package:hamro_grocery_mobile/feature/order/domain/usecase/clear_cart_usecase.dart';
// import 'package:mocktail/mocktail.dart';
// import 'mock_repository.dart'; 

// void main() {
  
//   late MockCartRepository mockCartRepository;
//   late ClearCartUseCase usecase;

//   setUp(() {
    
//     mockCartRepository = MockCartRepository();
//     usecase = ClearCartUseCase(cartRepository: mockCartRepository);
//   });

//   group('ClearCartUseCase', () {
//     test(
//       'should call clearCart on the repository and return Right(unit) on success',
//       () async {
        
//         when(
//           () => mockCartRepository.clearCart(),
//         ).thenAnswer((_) async => const Right(unit));

        
//         final result = await usecase();

        
//         expect(result, const Right(unit));
        
//         verify(() => mockCartRepository.clearCart()).called(1);
        
//         verifyNoMoreInteractions(mockCartRepository);
//       },
//     );

//     test(
//       'should return a Failure when the call to the repository is unsuccessful',
//       () async {
//         // Arrange
//         // Define a failure object to be returned by the mock
//         final tFailure = ApiFailure(message: "Failed to clear the cart");
//         // Stub the repository method to return a failure (Left)
//         when(
//           () => mockCartRepository.clearCart(),
//         ).thenAnswer((_) async => Left(tFailure));

//         // Act
//         final result = await usecase();

//         // Assert
//         // Expect the result to be the defined Failure
//         expect(result, Left(tFailure));
//         // Verify that the repository's clearCart method was still called
//         verify(() => mockCartRepository.clearCart()).called(1);
//         // Ensure no other interactions
//         verifyNoMoreInteractions(mockCartRepository);
//       },
//     );
//   });
// }
