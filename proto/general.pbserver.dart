///
//  Generated code. Do not modify.
//  source: general.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'package:protobuf/protobuf.dart' as $pb;

import 'dart:core' as $core show String, Map, ArgumentError, dynamic;
import 'general.pb.dart' as $1;
import 'google/protobuf/empty.pb.dart' as $0;
import 'general.pbjson.dart';

export 'general.pb.dart';

abstract class GeneralServiceBase extends $pb.GeneratedService {
  $async.Future<$1.LoginResp> loginWithMobile($pb.ServerContext ctx, $1.LoginWithMobileReq request);
  $async.Future<$0.Empty> completionUserInfo($pb.ServerContext ctx, $1.CompletionUserInfoReq request);
  $async.Future<$1.LoginResp> loginWithQQ($pb.ServerContext ctx, $1.LoginWithQQReq request);
  $async.Future<$1.LoginResp> loginWithWX($pb.ServerContext ctx, $1.LoginWithWXReq request);
  $async.Future<$0.Empty> updateMobile($pb.ServerContext ctx, $1.UpdateMobileReq request);
  $async.Future<$0.Empty> resetPassword($pb.ServerContext ctx, $1.ResetPasswordReq request);
  $async.Future<$0.Empty> sendSmsCodeForLogin($pb.ServerContext ctx, $1.SendSmsCodeReq request);
  $async.Future<$0.Empty> sendSmsCodeForResetPwd($pb.ServerContext ctx, $1.SendSmsCodeReq request);
  $async.Future<$0.Empty> sendEmailCodeForResetPwd($pb.ServerContext ctx, $1.SendEmailCodeReq request);

  $pb.GeneratedMessage createRequest($core.String method) {
    switch (method) {
      case 'LoginWithMobile': return $1.LoginWithMobileReq();
      case 'CompletionUserInfo': return $1.CompletionUserInfoReq();
      case 'LoginWithQQ': return $1.LoginWithQQReq();
      case 'LoginWithWX': return $1.LoginWithWXReq();
      case 'UpdateMobile': return $1.UpdateMobileReq();
      case 'ResetPassword': return $1.ResetPasswordReq();
      case 'SendSmsCodeForLogin': return $1.SendSmsCodeReq();
      case 'SendSmsCodeForResetPwd': return $1.SendSmsCodeReq();
      case 'SendEmailCodeForResetPwd': return $1.SendEmailCodeReq();
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String method, $pb.GeneratedMessage request) {
    switch (method) {
      case 'LoginWithMobile': return this.loginWithMobile(ctx, request);
      case 'CompletionUserInfo': return this.completionUserInfo(ctx, request);
      case 'LoginWithQQ': return this.loginWithQQ(ctx, request);
      case 'LoginWithWX': return this.loginWithWX(ctx, request);
      case 'UpdateMobile': return this.updateMobile(ctx, request);
      case 'ResetPassword': return this.resetPassword(ctx, request);
      case 'SendSmsCodeForLogin': return this.sendSmsCodeForLogin(ctx, request);
      case 'SendSmsCodeForResetPwd': return this.sendSmsCodeForResetPwd(ctx, request);
      case 'SendEmailCodeForResetPwd': return this.sendEmailCodeForResetPwd(ctx, request);
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => GeneralServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => GeneralServiceBase$messageJson;
}

