import 'package:hive_flutter/adapters.dart';
import 'package:tua/feature/auth/data/models/login_model.dart';

Box? userCache;
String userCacheBoxKey = 'userCache';
// keys

String languageAppKey = 'languageAppKey';
String sliderCacheKey = 'sliderCacheKey';
String onBoardingKey = 'onBoardingKey';
String userCacheKey = 'userCacheKey';
String darkModeKey = 'darkModeKey';
String idUserKey = 'idUserKey';
String locationCacheKey = 'locationCacheKey';
String hasStoreKey = 'hasStore';
String allMyAddressesKey = 'allMyAddressesKey';
String advertiseModelKey = 'advertiseModelKey';
String categoriesModelKey = 'categoriesModelKey';
String lookupCacheKey = 'lookupCacheKey';
int idUserValue = 0;
String fcmTokenKey = 'fcmTokenKey';
String deviceIdKey = 'deviceIdKey';
String donationProgramsCacheKey = 'donationProgramsCacheKey';

// value
bool onBoardingValue = true;
bool rememberMe = false;

bool darkModeValue = false;

UserInfo? userCacheValue;

String? locationCacheValue;
