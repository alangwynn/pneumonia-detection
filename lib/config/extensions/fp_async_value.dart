import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pneumonia_detection/exceptions/exceptions.dart';

extension FnAsyncValue<T> on AsyncValue<Either<ApiException, T>> {
  R mapEither<R>({
    required R Function(AsyncData<T> d) data,
    required R Function(AsyncError<T> e) error,
    required R Function(AsyncLoading<T> l) loading,
  }) {
    return map(
      data: (fpData) {
        return fpData.value.fold(
          (left) => error(
            AsyncError(left.message, StackTrace.current),
          ),
          (right) => data(AsyncData(right)),
        );
      },
      error: (fpError) {
        return error(AsyncError(fpError.error, fpError.stackTrace));
      },
      loading: (fpLoading) {
        return loading(const AsyncLoading());
      },
    );
  }
}