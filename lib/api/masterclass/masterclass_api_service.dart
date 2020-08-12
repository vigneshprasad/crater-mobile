import 'package:chopper/chopper.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:worknetwork/api/interceptors/authorized_interceptor.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/models/masterclass/masterclass_model.dart';

part 'masterclass_api_service.g.dart';
part 'masterclass_api_service.chopper.dart';

@JsonSerializable()
class MasterClassGetResponse {
  final int count;

  @JsonKey(nullable: true)
  final String next;

  @JsonKey(nullable: true)
  final String previous;

  final List<MasterClass> results;

  MasterClassGetResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory MasterClassGetResponse.fromJson(Map<String, dynamic> json) =>
      _$MasterClassGetResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MasterClassGetResponseToJson(this);
}

@ChopperApi(baseUrl: '/resources/masterclasses/')
abstract class MasterClassApiService extends ChopperService {
  static MasterClassApiService create() {
    final client = ChopperClient(
      baseUrl: AppConstants.apiBaseUrl,
      services: [
        _$MasterClassApiService(),
      ],
      interceptors: [AuthorizedInterceptor()],
    );
    return _$MasterClassApiService(client);
  }

  @Get(path: '')
  Future<Response> getVideosList();
}
