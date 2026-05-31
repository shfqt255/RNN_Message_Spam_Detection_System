import 'package:flutter/foundation.dart';
import 'package:sms_spam_detection_app/services/api_service.dart';

class SpamProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  String _prediction = '';
  double _confidence = 0.0;
  String _error = '';

  bool get isLoading => _isLoading;
  String get prediction => _prediction;
  double get confidence => _confidence;
  String get error => _error;

  bool get hasResult => _prediction.isNotEmpty;
  bool get hasError => _error.isNotEmpty;

  Future<void> detectSpam(String message) async {
    // Clear previous state before new request
    _prediction = '';
    _confidence = 0.0;
    _error = '';
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _apiService.checkSpam(message);

      _prediction = (result['prediction'] as String? ?? '').trim();
      _confidence = (result['confidence'] as num?)?.toDouble() ?? 0.0;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearResults() {
    _prediction = '';
    _confidence = 0.0;
    _error = '';
    _isLoading = false;
    notifyListeners();
  }
}
