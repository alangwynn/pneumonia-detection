import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthToken extends Equatable {
  const AuthToken({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.idToken,
    this.tokenType = 'Bearer',
  });

  factory AuthToken.fromMap(Map<String, dynamic> json) => AuthToken(
        accessToken: json['AccessToken'] as String,
        refreshToken: json['RefreshToken'] as String,
        expiresIn: json['ExpiresIn'] as int,
        idToken: json['IdToken'] as String,
        tokenType:
            json['TokenType'] == null ? 'Bearer' : json['TokenType'] as String,
      );

  factory AuthToken.fromJson(String json) => AuthToken.fromMap(
        jsonDecode(json) as Map<String, dynamic>,
      );

  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  //* Used to recover the session
  final String idToken;
  final String tokenType;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'AccessToken': accessToken,
        'RefreshToken': refreshToken,
        'ExpiresIn': expiresIn,
        'IdToken': idToken,
        'TokenType': tokenType,
      };

  String toJson() => jsonEncode(toMap());

  @override
  String toString() {
    return 'AuthToken(AccessToken: $accessToken, RefreshToken: $refreshToken, '
        'ExpiresIn: $expiresIn, IdToken: $idToken, TokenType: $tokenType)';
  }

  @override
  List<Object?> get props => [
        accessToken,
        refreshToken,
        expiresIn,
        idToken,
        tokenType,
      ];
}