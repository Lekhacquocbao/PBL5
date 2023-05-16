import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:food_delivery/data/api/api_client.dart';

class RecommendedProductRepo extends GetxService{
  late final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async{
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}