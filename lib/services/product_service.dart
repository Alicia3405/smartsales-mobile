import '../core/config/api_config.dart';
import '../models/product_model.dart';
import 'api_service.dart';

class ProductService {
  // Get all products
  static Future<List<Product>> getProducts({
    int? categoryId,
    String? search,
  }) async {
    try {
      final queryParams = <String, String>{};
      if (categoryId != null) {
        queryParams['category'] = categoryId.toString();
      }
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      
      final response = await ApiService.get(
        ApiConfig.products,
        queryParams: queryParams,
      );
      
      // La respuesta puede ser una lista directa o un objeto con 'results'
      final List<dynamic> productsJson = (response is List 
          ? response 
          : (response['results'] as List? ?? [])) as List<dynamic>;
      
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
  
  // Get product by ID
  static Future<Product> getProduct(int id) async {
    try {
      final response = await ApiService.get('${ApiConfig.products}$id/');
      return Product.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  
  // Get all categories
  static Future<List<Category>> getCategories() async {
    try {
      final response = await ApiService.get(ApiConfig.categories);
      
      final List<dynamic> categoriesJson = (response is List 
          ? response 
          : (response['results'] as List? ?? [])) as List<dynamic>;
      
      return categoriesJson.map((json) => Category.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
