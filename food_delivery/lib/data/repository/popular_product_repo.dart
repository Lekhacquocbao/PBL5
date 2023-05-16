import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:food_delivery/data/api/api_client.dart';

class PopularProductRepo extends GetxService{
  late final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async{
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}