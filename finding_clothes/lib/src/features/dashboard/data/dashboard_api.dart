import 'package:dio/dio.dart';
import 'package:finding_clothes/src/features/dashboard/domain/list_result.dart';
import 'package:finding_clothes/src/shared/providers/dio_providers.dart';
import 'package:finding_clothes/src/shared/utils/constants/api_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'dashboard_api.g.dart';

@RestApi(baseUrl: ApiConstants.apiStart)
abstract class DashboardApi {
  factory DashboardApi(Dio dio, {String baseUrl}) = _DashboardApi;
  
  @GET(ApiConstants.apiSearch)
  Future<ListResultModel> searchClothes({
    @Path("urlImg") required String urlImg,
    @Path("apiKey") required String apiKey,
  });   
}

final dashboardApi = Provider<DashboardApi>((ref) {
  final dio = ref.watch(dioProvider);
  return DashboardApi(dio);
});