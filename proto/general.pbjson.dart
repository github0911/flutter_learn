///
//  Generated code. Do not modify.
//  source: general.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'google/protobuf/empty.pbjson.dart' as $0;

const LoginWithMobileReq$json = const {
  '1': 'LoginWithMobileReq',
  '2': const [
    const {'1': 'mobile', '3': 1, '4': 1, '5': 9, '10': 'mobile'},
    const {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'password', '3': 3, '4': 1, '5': 9, '10': 'password'},
  ],
};

const LoginWithEmailReq$json = const {
  '1': 'LoginWithEmailReq',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
  ],
};

const LoginWithQQReq$json = const {
  '1': 'LoginWithQQReq',
  '2': const [
    const {'1': 'openID', '3': 1, '4': 1, '5': 9, '10': 'openID'},
  ],
};

const LoginWithWXReq$json = const {
  '1': 'LoginWithWXReq',
  '2': const [
    const {'1': 'openID', '3': 1, '4': 1, '5': 9, '10': 'openID'},
  ],
};

const LoginResp$json = const {
  '1': 'LoginResp',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'token', '3': 3, '4': 1, '5': 9, '10': 'token'},
    const {'1': 'expiredAt', '3': 4, '4': 1, '5': 3, '10': 'expiredAt'},
    const {'1': 'lack', '3': 5, '4': 1, '5': 9, '10': 'lack'},
  ],
};

const CompletionUserInfoReq$json = const {
  '1': 'CompletionUserInfoReq',
  '2': const [
    const {'1': 'nickName', '3': 1, '4': 1, '5': 9, '10': 'nickName'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

const UpdateMobileReq$json = const {
  '1': 'UpdateMobileReq',
  '2': const [
    const {'1': 'mobile', '3': 1, '4': 1, '5': 9, '10': 'mobile'},
    const {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
  ],
};

const ResetPasswordReq$json = const {
  '1': 'ResetPasswordReq',
  '2': const [
    const {'1': 'mobile', '3': 1, '4': 1, '5': 9, '10': 'mobile'},
    const {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'code', '3': 3, '4': 1, '5': 9, '10': 'code'},
  ],
};

const SendEmailCodeReq$json = const {
  '1': 'SendEmailCodeReq',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

const SendSmsCodeReq$json = const {
  '1': 'SendSmsCodeReq',
  '2': const [
    const {'1': 'mobile', '3': 1, '4': 1, '5': 9, '10': 'mobile'},
  ],
};

const GeneralServiceBase$json = const {
  '1': 'General',
  '2': const [
    const {'1': 'LoginWithMobile', '2': '.com.xinyan.beenest.api.general.LoginWithMobileReq', '3': '.com.xinyan.beenest.api.general.LoginResp'},
    const {'1': 'CompletionUserInfo', '2': '.com.xinyan.beenest.api.general.CompletionUserInfoReq', '3': '.google.protobuf.Empty'},
    const {'1': 'LoginWithQQ', '2': '.com.xinyan.beenest.api.general.LoginWithQQReq', '3': '.com.xinyan.beenest.api.general.LoginResp'},
    const {'1': 'LoginWithWX', '2': '.com.xinyan.beenest.api.general.LoginWithWXReq', '3': '.com.xinyan.beenest.api.general.LoginResp'},
    const {'1': 'UpdateMobile', '2': '.com.xinyan.beenest.api.general.UpdateMobileReq', '3': '.google.protobuf.Empty'},
    const {'1': 'ResetPassword', '2': '.com.xinyan.beenest.api.general.ResetPasswordReq', '3': '.google.protobuf.Empty'},
    const {'1': 'SendSmsCodeForLogin', '2': '.com.xinyan.beenest.api.general.SendSmsCodeReq', '3': '.google.protobuf.Empty'},
    const {'1': 'SendSmsCodeForResetPwd', '2': '.com.xinyan.beenest.api.general.SendSmsCodeReq', '3': '.google.protobuf.Empty'},
    const {'1': 'SendEmailCodeForResetPwd', '2': '.com.xinyan.beenest.api.general.SendEmailCodeReq', '3': '.google.protobuf.Empty'},
  ],
};

const GeneralServiceBase$messageJson = const {
  '.com.xinyan.beenest.api.general.LoginWithMobileReq': LoginWithMobileReq$json,
  '.com.xinyan.beenest.api.general.LoginResp': LoginResp$json,
  '.com.xinyan.beenest.api.general.CompletionUserInfoReq': CompletionUserInfoReq$json,
  '.google.protobuf.Empty': $0.Empty$json,
  '.com.xinyan.beenest.api.general.LoginWithQQReq': LoginWithQQReq$json,
  '.com.xinyan.beenest.api.general.LoginWithWXReq': LoginWithWXReq$json,
  '.com.xinyan.beenest.api.general.UpdateMobileReq': UpdateMobileReq$json,
  '.com.xinyan.beenest.api.general.ResetPasswordReq': ResetPasswordReq$json,
  '.com.xinyan.beenest.api.general.SendSmsCodeReq': SendSmsCodeReq$json,
  '.com.xinyan.beenest.api.general.SendEmailCodeReq': SendEmailCodeReq$json,
};

