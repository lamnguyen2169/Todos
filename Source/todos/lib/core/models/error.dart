/// https://stackoverflow.com/questions/7996569/can-we-create-custom-http-status-codes#11871377
/// https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
/// https://www.rfc-editor.org/rfc/rfc7231.html

import 'dart:convert';

class APPCode {
  static const int ok = 200;
  static const int internalServer = 500;
  static const int unknown = 600;
  static const int notReachable = 601;
  static const int unidentified = 602;
}

class APPError {
  int code = APPCode.unknown;
  String message = '';

  /// MARK: - Constructors
  APPError({required int code, required String message})
      : this.code = code,
        this.message = message;

  factory APPError.internalServerError() => APPError(
        code: APPCode.internalServer,
        message: 'Internal Server Error',
      );

  factory APPError.unknown() => APPError(
        code: APPCode.unknown,
        message: 'Unknown error',
      );

  factory APPError.notReachable() => APPError(
        code: APPCode.notReachable,
        message: 'Connection error',
      );

  factory APPError.withMessage(String message) => APPError(
        code: APPCode.unidentified,
        message: message,
      );

  factory APPError.fromJson(Map<String, dynamic> json) => APPError(
        code: json['code'],
        message: json['message'],
      );

  /// MARK: - Public methods
  static bool validated(Map<String, dynamic>? json) {
    return (json != null) && (json['code'] != null) && (json['message'] != null);
  }

  Map<String, dynamic> toJson() => {
        'code': this.code,
        'message': this.message,
      };

  String toJsonString() => json.encode(this.toJson());

  Map<String, dynamic> toDBJson() => {
        'code': this.code,
        'message': this.message,
      };
}
