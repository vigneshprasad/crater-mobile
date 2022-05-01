import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/api/interceptors/authorized_interceptor.dart';

part 'cover_image_api_service.chopper.dart';

final coverImageApiServiceProvider =
    Provider((_) => CoverImageApiService.create());

@ChopperApi(baseUrl: "/")
abstract class CoverImageApiService extends ChopperService {
  static CoverImageApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://84wp6p3fi7.execute-api.ap-south-1.amazonaws.com',
      services: [
        _$CoverImageApiService(),
      ],
      interceptors: [
        AuthorizedInterceptor(),
      ],
      converter: const JsonConverter(),
    );
    return _$CoverImageApiService(client);
  }

  @Post(path: 'test')
  Future<Response> generateImage(@Body() Map<String, dynamic> body);
}
