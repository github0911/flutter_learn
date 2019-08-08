///
//  Generated code. Do not modify.
//  source: general.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;
import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/empty.pb.dart' as $0;

class LoginWithMobileReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LoginWithMobileReq', package: const $pb.PackageName('com.xinyan.beenest.api.general'))
    ..aOS(1, 'mobile')
    ..aOS(2, 'code')
    ..aOS(3, 'password')
    ..hasRequiredFields = false
  ;

  LoginWithMobileReq._() : super();
  factory LoginWithMobileReq() => create();
  factory LoginWithMobileReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoginWithMobileReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  LoginWithMobileReq clone() => LoginWithMobileReq()..mergeFromMessage(this);
  LoginWithMobileReq copyWith(void Function(LoginWithMobileReq) updates) => super.copyWith((message) => updates(message as LoginWithMobileReq));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoginWithMobileReq create() => LoginWithMobileReq._();
  LoginWithMobileReq createEmptyInstance() => create();
  static $pb.PbList<LoginWithMobileReq> createRepeated() => $pb.PbList<LoginWithMobileReq>();
  static LoginWithMobileReq getDefault() => _defaultInstance ??= create()..freeze();
  static LoginWithMobileReq _defaultInstance;

  $core.String get mobile => $_getS(0, '');
  set mobile($core.String v) { $_setString(0, v); }
  $core.bool hasMobile() => $_has(0);
  void clearMobile() => clearField(1);

  $core.String get code => $_getS(1, '');
  set code($core.String v) { $_setString(1, v); }
  $core.bool hasCode() => $_has(1);
  void clearCode() => clearField(2);

  $core.String get password => $_getS(2, '');
  set password($core.String v) { $_setString(2, v); }
  $core.bool hasPassword() => $_has(2);
  void clearPassword() => clearField(3);
}

class LoginWithEmailReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LoginWithEmailReq', package: const $pb.PackageName('com.xinyan.beenest.api.general'))
    ..aOS(1, 'email')
    ..aOS(2, 'code')
    ..hasRequiredFields = false
  ;

  LoginWithEmailReq._() : super();
  factory LoginWithEmailReq() => create();
  factory LoginWithEmailReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoginWithEmailReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  LoginWithEmailReq clone() => LoginWithEmailReq()..mergeFromMessage(this);
  LoginWithEmailReq copyWith(void Function(LoginWithEmailReq) updates) => super.copyWith((message) => updates(message as LoginWithEmailReq));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoginWithEmailReq create() => LoginWithEmailReq._();
  LoginWithEmailReq createEmptyInstance() => create();
  static $pb.PbList<LoginWithEmailReq> createRepeated() => $pb.PbList<LoginWithEmailReq>();
  static LoginWithEmailReq getDefault() => _defaultInstance ??= create()..freeze();
  static LoginWithEmailReq _defaultInstance;

  $core.String get email => $_getS(0, '');
  set email($core.String v) { $_setString(0, v); }
  $core.bool hasEmail() => $_has(0);
  void clearEmail() => clearField(1);

  $core.String get code => $_getS(1, '');
  set code($core.String v) { $_setString(1, v); }
  $core.bool hasCode() => $_has(1);
  void clearCode() => clearField(2);
}

class LoginWithQQReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LoginWithQQReq', package: const $pb.PackageName('com.xinyan.beenest.api.general'))
    ..aOS(1, 'openID')
    ..hasRequiredFields = false
  ;

  LoginWithQQReq._() : super();
  factory LoginWithQQReq() => create();
  factory LoginWithQQReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoginWithQQReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  LoginWithQQReq clone() => LoginWithQQReq()..mergeFromMessage(this);
  LoginWithQQReq copyWith(void Function(LoginWithQQReq) updates) => super.copyWith((message) => updates(message as LoginWithQQReq));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoginWithQQReq create() => LoginWithQQReq._();
  LoginWithQQReq createEmptyInstance() => create();
  static $pb.PbList<LoginWithQQReq> createRepeated() => $pb.PbList<LoginWithQQReq>();
  static LoginWithQQReq getDefault() => _defaultInstance ??= create()..freeze();
  static LoginWithQQReq _defaultInstance;

  $core.String get openID => $_getS(0, '');
  set openID($core.String v) { $_setString(0, v); }
  $core.bool hasOpenID() => $_has(0);
  void clearOpenID() => clearField(1);
}

class LoginWithWXReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LoginWithWXReq', package: const $pb.PackageName('com.xinyan.beenest.api.general'))
    ..aOS(1, 'openID')
    ..hasRequiredFields = false
  ;

  LoginWithWXReq._() : super();
  factory LoginWithWXReq() => create();
  factory LoginWithWXReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoginWithWXReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  LoginWithWXReq clone() => LoginWithWXReq()..mergeFromMessage(this);
  LoginWithWXReq copyWith(void Function(LoginWithWXReq) updates) => super.copyWith((message) => updates(message as LoginWithWXReq));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoginWithWXReq create() => LoginWithWXReq._();
  LoginWithWXReq createEmptyInstance() => create();
  static $pb.PbList<LoginWithWXReq> createRepeated() => $pb.PbList<LoginWithWXReq>();
  static LoginWithWXReq getDefault() => _defaultInstance ??= create()..freeze();
  static LoginWithWXReq _defaultInstance;

  $core.String get openID => $_getS(0, '');
  set openID($core.String v) { $_setString(0, v); }
  $core.bool hasOpenID() => $_has(0);
  void clearOpenID() => clearField(1);
}

class LoginResp extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LoginResp', package: const $pb.PackageName('com.xinyan.beenest.api.general'))
    ..aInt64(1, 'id')
    ..aOS(2, 'name')
    ..aOS(3, 'token')
    ..aInt64(4, 'expiredAt')
    ..aOS(5, 'lack')
    ..hasRequiredFields = false
  ;

  LoginResp._() : super();
  factory LoginResp() => create();
  factory LoginResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoginResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  LoginResp clone() => LoginResp()..mergeFromMessage(this);
  LoginResp copyWith(void Function(LoginResp) updates) => super.copyWith((message) => updates(message as LoginResp));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoginResp create() => LoginResp._();
  LoginResp createEmptyInstance() => create();
  static $pb.PbList<LoginResp> createRepeated() => $pb.PbList<LoginResp>();
  static LoginResp getDefault() => _defaultInstance ??= create()..freeze();
  static LoginResp _defaultInstance;

  Int64 get id => $_getI64(0);
  set id(Int64 v) { $_setInt64(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get name => $_getS(1, '');
  set name($core.String v) { $_setString(1, v); }
  $core.bool hasName() => $_has(1);
  void clearName() => clearField(2);

  $core.String get token => $_getS(2, '');
  set token($core.String v) { $_setString(2, v); }
  $core.bool hasToken() => $_has(2);
  void clearToken() => clearField(3);

  Int64 get expiredAt => $_getI64(3);
  set expiredAt(Int64 v) { $_setInt64(3, v); }
  $core.bool hasExpiredAt() => $_has(3);
  void clearExpiredAt() => clearField(4);

  $core.String get lack => $_getS(4, '');
  set lack($core.String v) { $_setString(4, v); }
  $core.bool hasLack() => $_has(4);
  void clearLack() => clearField(5);
}

class CompletionUserInfoReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('CompletionUserInfoReq', package: const $pb.PackageName('com.xinyan.beenest.api.general'))
    ..aOS(1, 'nickName')
    ..aOS(2, 'password')
    ..hasRequiredFields = false
  ;

  CompletionUserInfoReq._() : super();
  factory CompletionUserInfoReq() => create();
  factory CompletionUserInfoReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CompletionUserInfoReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  CompletionUserInfoReq clone() => CompletionUserInfoReq()..mergeFromMessage(this);
  CompletionUserInfoReq copyWith(void Function(CompletionUserInfoReq) updates) => super.copyWith((message) => updates(message as CompletionUserInfoReq));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CompletionUserInfoReq create() => CompletionUserInfoReq._();
  CompletionUserInfoReq createEmptyInstance() => create();
  static $pb.PbList<CompletionUserInfoReq> createRepeated() => $pb.PbList<CompletionUserInfoReq>();
  static CompletionUserInfoReq getDefault() => _defaultInstance ??= create()..freeze();
  static CompletionUserInfoReq _defaultInstance;

  $core.String get nickName => $_getS(0, '');
  set nickName($core.String v) { $_setString(0, v); }
  $core.bool hasNickName() => $_has(0);
  void clearNickName() => clearField(1);

  $core.String get password => $_getS(1, '');
  set password($core.String v) { $_setString(1, v); }
  $core.bool hasPassword() => $_has(1);
  void clearPassword() => clearField(2);
}

class UpdateMobileReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UpdateMobileReq', package: const $pb.PackageName('com.xinyan.beenest.api.general'))
    ..aOS(1, 'mobile')
    ..aOS(2, 'code')
    ..hasRequiredFields = false
  ;

  UpdateMobileReq._() : super();
  factory UpdateMobileReq() => create();
  factory UpdateMobileReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateMobileReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UpdateMobileReq clone() => UpdateMobileReq()..mergeFromMessage(this);
  UpdateMobileReq copyWith(void Function(UpdateMobileReq) updates) => super.copyWith((message) => updates(message as UpdateMobileReq));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateMobileReq create() => UpdateMobileReq._();
  UpdateMobileReq createEmptyInstance() => create();
  static $pb.PbList<UpdateMobileReq> createRepeated() => $pb.PbList<UpdateMobileReq>();
  static UpdateMobileReq getDefault() => _defaultInstance ??= create()..freeze();
  static UpdateMobileReq _defaultInstance;

  $core.String get mobile => $_getS(0, '');
  set mobile($core.String v) { $_setString(0, v); }
  $core.bool hasMobile() => $_has(0);
  void clearMobile() => clearField(1);

  $core.String get code => $_getS(1, '');
  set code($core.String v) { $_setString(1, v); }
  $core.bool hasCode() => $_has(1);
  void clearCode() => clearField(2);
}

class ResetPasswordReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ResetPasswordReq', package: const $pb.PackageName('com.xinyan.beenest.api.general'))
    ..aOS(1, 'mobile')
    ..aOS(2, 'email')
    ..aOS(3, 'code')
    ..hasRequiredFields = false
  ;

  ResetPasswordReq._() : super();
  factory ResetPasswordReq() => create();
  factory ResetPasswordReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResetPasswordReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ResetPasswordReq clone() => ResetPasswordReq()..mergeFromMessage(this);
  ResetPasswordReq copyWith(void Function(ResetPasswordReq) updates) => super.copyWith((message) => updates(message as ResetPasswordReq));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResetPasswordReq create() => ResetPasswordReq._();
  ResetPasswordReq createEmptyInstance() => create();
  static $pb.PbList<ResetPasswordReq> createRepeated() => $pb.PbList<ResetPasswordReq>();
  static ResetPasswordReq getDefault() => _defaultInstance ??= create()..freeze();
  static ResetPasswordReq _defaultInstance;

  $core.String get mobile => $_getS(0, '');
  set mobile($core.String v) { $_setString(0, v); }
  $core.bool hasMobile() => $_has(0);
  void clearMobile() => clearField(1);

  $core.String get email => $_getS(1, '');
  set email($core.String v) { $_setString(1, v); }
  $core.bool hasEmail() => $_has(1);
  void clearEmail() => clearField(2);

  $core.String get code => $_getS(2, '');
  set code($core.String v) { $_setString(2, v); }
  $core.bool hasCode() => $_has(2);
  void clearCode() => clearField(3);
}

class SendEmailCodeReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SendEmailCodeReq', package: const $pb.PackageName('com.xinyan.beenest.api.general'))
    ..aOS(1, 'email')
    ..hasRequiredFields = false
  ;

  SendEmailCodeReq._() : super();
  factory SendEmailCodeReq() => create();
  factory SendEmailCodeReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendEmailCodeReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SendEmailCodeReq clone() => SendEmailCodeReq()..mergeFromMessage(this);
  SendEmailCodeReq copyWith(void Function(SendEmailCodeReq) updates) => super.copyWith((message) => updates(message as SendEmailCodeReq));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendEmailCodeReq create() => SendEmailCodeReq._();
  SendEmailCodeReq createEmptyInstance() => create();
  static $pb.PbList<SendEmailCodeReq> createRepeated() => $pb.PbList<SendEmailCodeReq>();
  static SendEmailCodeReq getDefault() => _defaultInstance ??= create()..freeze();
  static SendEmailCodeReq _defaultInstance;

  $core.String get email => $_getS(0, '');
  set email($core.String v) { $_setString(0, v); }
  $core.bool hasEmail() => $_has(0);
  void clearEmail() => clearField(1);
}

class SendSmsCodeReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SendSmsCodeReq', package: const $pb.PackageName('com.xinyan.beenest.api.general'))
    ..aOS(1, 'mobile')
    ..hasRequiredFields = false
  ;

  SendSmsCodeReq._() : super();
  factory SendSmsCodeReq() => create();
  factory SendSmsCodeReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendSmsCodeReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SendSmsCodeReq clone() => SendSmsCodeReq()..mergeFromMessage(this);
  SendSmsCodeReq copyWith(void Function(SendSmsCodeReq) updates) => super.copyWith((message) => updates(message as SendSmsCodeReq));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendSmsCodeReq create() => SendSmsCodeReq._();
  SendSmsCodeReq createEmptyInstance() => create();
  static $pb.PbList<SendSmsCodeReq> createRepeated() => $pb.PbList<SendSmsCodeReq>();
  static SendSmsCodeReq getDefault() => _defaultInstance ??= create()..freeze();
  static SendSmsCodeReq _defaultInstance;

  $core.String get mobile => $_getS(0, '');
  set mobile($core.String v) { $_setString(0, v); }
  $core.bool hasMobile() => $_has(0);
  void clearMobile() => clearField(1);
}

class GeneralApi {
  $pb.RpcClient _client;
  GeneralApi(this._client);

  $async.Future<LoginResp> loginWithMobile($pb.ClientContext ctx, LoginWithMobileReq request) {
    var emptyResponse = LoginResp();
    return _client.invoke<LoginResp>(ctx, 'General', 'LoginWithMobile', request, emptyResponse);
  }
  $async.Future<$0.Empty> completionUserInfo($pb.ClientContext ctx, CompletionUserInfoReq request) {
    var emptyResponse = $0.Empty();
    return _client.invoke<$0.Empty>(ctx, 'General', 'CompletionUserInfo', request, emptyResponse);
  }
  $async.Future<LoginResp> loginWithQQ($pb.ClientContext ctx, LoginWithQQReq request) {
    var emptyResponse = LoginResp();
    return _client.invoke<LoginResp>(ctx, 'General', 'LoginWithQQ', request, emptyResponse);
  }
  $async.Future<LoginResp> loginWithWX($pb.ClientContext ctx, LoginWithWXReq request) {
    var emptyResponse = LoginResp();
    return _client.invoke<LoginResp>(ctx, 'General', 'LoginWithWX', request, emptyResponse);
  }
  $async.Future<$0.Empty> updateMobile($pb.ClientContext ctx, UpdateMobileReq request) {
    var emptyResponse = $0.Empty();
    return _client.invoke<$0.Empty>(ctx, 'General', 'UpdateMobile', request, emptyResponse);
  }
  $async.Future<$0.Empty> resetPassword($pb.ClientContext ctx, ResetPasswordReq request) {
    var emptyResponse = $0.Empty();
    return _client.invoke<$0.Empty>(ctx, 'General', 'ResetPassword', request, emptyResponse);
  }
  $async.Future<$0.Empty> sendSmsCodeForLogin($pb.ClientContext ctx, SendSmsCodeReq request) {
    var emptyResponse = $0.Empty();
    return _client.invoke<$0.Empty>(ctx, 'General', 'SendSmsCodeForLogin', request, emptyResponse);
  }
  $async.Future<$0.Empty> sendSmsCodeForResetPwd($pb.ClientContext ctx, SendSmsCodeReq request) {
    var emptyResponse = $0.Empty();
    return _client.invoke<$0.Empty>(ctx, 'General', 'SendSmsCodeForResetPwd', request, emptyResponse);
  }
  $async.Future<$0.Empty> sendEmailCodeForResetPwd($pb.ClientContext ctx, SendEmailCodeReq request) {
    var emptyResponse = $0.Empty();
    return _client.invoke<$0.Empty>(ctx, 'General', 'SendEmailCodeForResetPwd', request, emptyResponse);
  }
}

