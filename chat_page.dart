import 'dart:convert';
import 'dart:io';

import 'package:bee_nest/class/common/db/link_db.dart';
import 'package:bee_nest/class/common/db/msg_db.dart';
import 'package:bee_nest/class/common/db/user_channel_db.dart';
import 'package:bee_nest/class/common/db/user_subchannel_db.dart';

import 'package:bee_nest/class/common/model/api/general/general.pb.dart';
import 'package:bee_nest/class/common/model/common/base_channel.pb.dart';
import 'package:bee_nest/class/common/model/common/base_file.pb.dart';
import 'package:bee_nest/class/common/model/common/base_im.pb.dart';
import 'package:bee_nest/class/common/model/common/base_user.pb.dart';
import 'package:bee_nest/class/common/model/google/protobuf/empty.pb.dart';
import 'package:bee_nest/class/page/channel/channel_router.dart';
import 'package:bee_nest/class/page/channel/channel_set_word_page.dart';
import 'package:bee_nest/class/page/channel/models/contact_model.dart';
import 'package:bee_nest/class/page/channel/models/subchannel_model.dart';
import 'package:bee_nest/class/page/chat/chat_router.dart';
import 'package:bee_nest/class/page/chat/widgets/delete_message_item.dart';
import 'package:bee_nest/class/page/chat/widgets/edit_message_item.dart';
import 'package:bee_nest/class/page/chat/widgets/emoji_panel.dart';
import 'package:bee_nest/class/page/chat/widgets/mark_message_tip.dart';
import 'package:bee_nest/class/page/chat/widgets/message_item.dart';
import 'package:bee_nest/class/page/chat/widgets/send_message_item.dart';
import 'package:bee_nest/common/account_manager.dart';
import 'package:bee_nest/common/net_work/http_net_work/upload_response.dart';
import 'package:bee_nest/common/net_work/services/channel_service.dart';
import 'package:bee_nest/common/net_work/services/general_service.dart';
import 'package:bee_nest/common/widgets/image_panel.dart';
import 'package:bee_nest/macros/macros.dart';
import 'package:bee_nest/res/resources.dart';
import 'package:bee_nest/routers/fluro_navigator.dart';
import 'package:bee_nest/utils/bee_event_bus.dart';
import 'package:bee_nest/utils/file_utils.dart';
import 'package:bee_nest/utils/image_utils.dart';
import 'package:bee_nest/utils/toast.dart';
import 'package:bee_nest/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:fixnum/fixnum.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

/// 频道群聊
class ChatPage extends StatefulWidget {
  static String inChannelId;
  static String inSubChannelId;
  static Int64 SENDING_KEY = Int64(-10000);
  static Int64 FAILED_KEY = Int64(-20000);

  String channelId;
  String channelName;
  String seqId; //getChannelInfo中lastMsg中的seqId
  String channelIcon;
  String subChannelId;
  String name;
  SubchannelCommonSetting subchannelCommonSetting;
  bool hasMarkMessage;

  ChatPage({
    this.channelId,
    this.channelName,
    this.channelIcon,
    this.subChannelId,
    this.name,
    this.subchannelCommonSetting,
    this.seqId,
    this.hasMarkMessage: false,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Int64 channelId;
  Int64 subchannelId;
  String name = "";
  AutoScrollController _autoScrollController;
  double keyboardH = 0;
  double sendViewBtmH = 0;
  bool showKeyBoard = false;
  String sendMsgStr = "";
  Int64 _seqId;
  Int64 _loadingSeqId;
  UserInfo userInfo;
  List<MsgContent> listMsgs = List<MsgContent>();
  List<UserProfile> listUserProfiles = List<UserProfile>();
  TextEditingController textEditingController;
  TextEditingController textEditViewEditingController;
  FocusNode focusNode = FocusNode();
  FocusNode textEditViewFocusNode = FocusNode();
  EmojiPanel emojiPanel;
  Widget imagePanel;

  bool isHideEmojiPanel = true;
  bool isHideImagePanel = true;
  bool isHideEditView = true;
  int editIndex;

  int selectImageCount = 0;

  List<String> localImagePathList = [];
  List<AssetEntity> assetEntityList = [];
  List<Asset> images = List<Asset>();

  Map<Int64, List<GetLinkInfoResp>> linkInfos =
      Map<Int64, List<GetLinkInfoResp>>();

  bool _isLoading = true;
  bool _listViewReverse = true;

  var _eventSocketPushDelChannelMsg;
  var _eventSocketPushEditChannelMsg;
  var _eventSocketPushSendChannelMsg;
  var _removeMarkEventBus;

  String inputText = "";
  List<ContactInfo> atMemberList = [];
  List<ContactInfo> atRoleList = [];
  List<SubchannelModel> atSubchannelList = [];

  _bodyWidget() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _listMsgView(),
              isHideEditView
                  ? SendMessageItem(
                      textEditingController: textEditingController,
                      focusNode: focusNode,
                      onSubmitted: (str) {
                        sendMsgStr = str;
                        _sendChannelMsg();
                      },
                      onClickEmoji: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        setState(() {
                          isHideEmojiPanel = !isHideEmojiPanel;
                          isHideImagePanel = true;
                        });
                      },
                      onClickImage: () {
                        _clickImage();
                      },
                    )
                  : EditMessageItem(
                      textEditingController: textEditViewEditingController,
                      focusNode: textEditViewFocusNode,
                      onClickCancelButton: () {
                        setState(() {
                          isHideEditView = true;
                        });
                      },
                      onClickTrueButton: () {
                        setState(() {
                          isHideEditView = true;
                          _editChannelMsg();
                        });
                      },
                    ),
              Offstage(
                offstage: isHideEmojiPanel,
                child: _getEmojiPanel(),
              ),
              Opacity(
                opacity: isHideImagePanel ? 0 : 1,
                child: isHideImagePanel ? Gaps.empty : _getImagePanel(),
              ),
            ],
          ),
        ),
//        Positioned(
//          top: 0,
//          left: 0,
//          right: 0,
//          height: Macros.scale(37),
//          child: _haveNotReadMsgView(),
//        )
      ],
    );
  }

  _clickImage() {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      isHideImagePanel = !isHideImagePanel;
      isHideEmojiPanel = true;
    });
    // NavigatorUtils.push(context, ChatRouter.imagePanel);
  }

  _getEmojiPanel() {
    Utils.debug("_getEmojiPanel $emojiPanel $isHideEmojiPanel");
    if (emojiPanel == null) {
      emojiPanel = EmojiPanel(
        onTapEmoji: (value) {
          setState(() {
            textEditingController.selection = TextSelection(
                baseOffset: 0, extentOffset: textEditingController.text.length);
            Utils.debug(
                "text length -------------> ${textEditingController.text.length}");
            textEditingController.text += value;
            Utils.debug(
                "text length -------------> ${textEditingController.text.length}");
          });
        },
        onClickDelete: () {
          setState(() {
            String text = textEditingController.text;
            var result = text.substring(0, text.length - 1);
            Utils.debug("onClickDelete result -------------> $result");
            if (result.isNotEmpty) {
              List<int> bytes = utf8.encode(text.substring(text.length - 1));
              Utils.debug("onClickDelete bytes -------------> ${bytes.length}");
              Utils.debug("onClickDelete bytes -------------> $bytes");
              if (bytes.length == 3 && bytes[0] == 237) {
                result = result.substring(0, result.length - 1);
              }
            }
            textEditingController.text = result;
            Utils.debug(
                "onClickDelete text length -------------> ${textEditingController.text.length}");
          });
        },
        onClickSend: () {
          sendMsgStr = textEditingController.text;
          _sendChannelMsg();
          textEditingController.text = "";
          setState(() {
            isHideEmojiPanel = true;
          });
        },
      );
    }
    return emojiPanel;
  }

  _getImagePanel() {
    Utils.debug("_getImagePanel -------------------> imagePanel");
    if (imagePanel == null) {
      imagePanel = ImagePanel(
        onClickCamera: () {
          _takePhoto();
        },
        onClickGallery: () {
          _loadAssets();
        },
        onClickImage: (count) {
          selectImageCount = count;
        },
        onClickSend: (data) {
          if (data is List<AssetEntity>) {
            _clickImage();
            _sendImageMessage(data);
          }
        },
      );
    }
    return imagePanel;
  }

  _sendImageMessage(List<AssetEntity> data) async {
    localImagePathList.clear();
    assetEntityList = data;
    for (var item in assetEntityList) {
      bool result = await item.exists;
      if (result) {
        var file = await item.file;
        String path = file?.path;
        localImagePathList.add(path);
      }
    }
    for (var path in localImagePathList) {
      _uploadFile(path);
    }
    Utils.debug(
        "localImagePathList ---------------------> ${localImagePathList.toString()}");
    // MsgContent msgContent = MsgContent();
    // msgContent.seqId = _seqId + 1;
    // msgContent.fromUid = AccountManager.instance.getUserId();
    // ExtraInfo extraInfo = ExtraInfo();
    // AttechmentInfo attechmentInfo = AttechmentInfo();
    // attechmentInfo.fileID = "";
    // attechmentInfo.filePath = "";
    // attechmentInfo.fileType = AttechmentInfo_FileType.PIC;
    // extraInfo.attechmentInfo = attechmentInfo;
    // msgContent.extraInfo = extraInfo;
    // setState(() {
    //   listMsgs.insert(0, msgContent);
    // });

    // var resp = await GeneralService.instance.sendChannelMsg(
    //     Int64(int.parse(widget.channelId)),
    //     Int64(int.parse(widget.subChannelId)),
    //     content: sendMsgStr);
    // if (resp is SendChannelMsgResp) {}
  }

  _takePhoto() async {
    Utils.debug("_takePhoto --------------------------> ");
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      String path = image.path;
      _uploadFile(path);
    } on Exception catch (e) {
      Utils.debug(e.toString());
    }
  }

  _getImageExtraInfo(String path, {String id: ""}) {
    ExtraInfo extraInfo = ExtraInfo();
    AttechmentInfo attechmentInfo = AttechmentInfo();
    attechmentInfo.fileID = id;
    attechmentInfo.filePath = path;
    //attechmentInfo.fileType = AttechmentInfo_FileType.PIC;
    extraInfo.attechmentInfo = attechmentInfo;
    return extraInfo;
  }

  _uploadFile(String path) async {
    MsgContent msgContent = MsgContent();
    msgContent.seqId = ChatPage.SENDING_KEY;
    msgContent.fromUid = AccountManager.instance.getUserId();
    msgContent.extraInfo = _getImageExtraInfo(path);
    setState(() {
      listMsgs.insert(0, msgContent);
    });

    var file = File(path);
    //var size = await file.length();
    if (path != null && path.isNotEmpty) {
      var response = await FileUtils.uploadFile(
          file, UploadFileType.ChannelMessage,
          channelID: channelId, subChannelID: subchannelId);
      if (response is UploadResponse) {
        ExtraInfo extraInfo = ExtraInfo();
        AttechmentInfo attechmentInfo = AttechmentInfo();
        attechmentInfo.filePath = response.path;
        attechmentInfo.fileID = response.id.toString();
        attechmentInfo.fileName = Utils.getFileName(path);
        //attechmentInfo.fileSize = size;
        extraInfo.attechmentInfo = attechmentInfo;
        var resp = await GeneralService.instance.sendChannelMsg(
            Int64(int.parse(widget.channelId)),
            Int64(int.parse(widget.subChannelId)),
            extraInfo: extraInfo);
        if (resp is SendChannelMsgResp) {
          setState(() {
            msgContent.seqId = resp.seqId;
          });
        }
      }
    }
  }

  Future<void> _loadAssets() async {
    Utils.debug("_loadAssets --------------------------> ");
    List<Asset> resultList = List<Asset>();
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 9,
        enableCamera: false,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#CCCCCC",
          statusBarColor: "#999999",
          actionBarTitle: "图库",
          allViewTitle: "所有图片",
          actionBarTitleColor: "#000000",
          useDetailsView: false,
          lightStatusBar: true,
          selectCircleStrokeColor: "#000000",
          selectionLimitReachedText: "您已经选择了9张图片",
        ),
      );
    } on Exception catch (e) {
      e.toString();
    }

    if (!mounted) return;
    localImagePathList.clear();
    for (var r in resultList) {
      var path = await r.filePath;
      localImagePathList.add(path);
    }
    // 上传服务器
    for (var path in localImagePathList) {
      _uploadFile(path);
    }
  }

  _haveNotReadMsgView() {
    return Container(
      height: Macros.scale(37),
      padding: EdgeInsets.only(left: Macros.scale(20), right: Macros.scale(20)),
      color: Color(0xFF00DBFF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "123条新消息",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: Macros.scale(13)),
          ),
          Row(
            children: <Widget>[
              Text(
                "查看",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Macros.scale(13),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                child: loadAssetImage("chat/icon_next_notRead"),
              )
            ],
          )
        ],
      ),
    );
  }

  _listMsgView() {
    return Flexible(
        child: Container(
      child: EasyRefresh(
          //header: BallPulseHeader(),
          //footer: BallPulseFooter(),
          onRefresh: () async {
            Utils.debug("onRefreshonRefreshonRefresh");
            _loadNewMsg();
          },
          onLoad: () async {
            Utils.debug("onLoadonLoadonLoad");
            _loadHistoryMsg();
          },
          child: ListView.separated(
              reverse: _listViewReverse,
              shrinkWrap: true,
              controller: _autoScrollController,
              itemBuilder: (context, index) {
                return _buildItem(context, index);
              },
              separatorBuilder: (context, index) {
                return Container();
              },
              itemCount: listMsgs.length)),
      color: Color(0xFFF5F5F5),
    ));
  }

  _buildItem(BuildContext context, int index) {
    int isMe = 0;
    if (listMsgs.isEmpty) {
      return Gaps.empty;
    }
    if (index < 0 || index > listMsgs.length) {
      return Gaps.empty;
    }
    MsgContent msgContent = listMsgs[index];

    if (msgContent.extraInfo.msgType == ExtraInfo_MsgType.DEL_EVENT ||
        msgContent.extraInfo.msgType == ExtraInfo_MsgType.EDIT_EVENT ||
        msgContent.extraInfo.msgType == ExtraInfo_MsgType.DEL) {
      return Gaps.empty;
    }

    UserProfile userProfile = UserProfile();

    if (listUserProfiles != null && listUserProfiles.isNotEmpty) {
      /// TODO 用户列表不匹配，和频道列表返回的数据
      Utils.debug("listUserProfiles ---------------> $listUserProfiles" );
      for (var userProfileItem in listUserProfiles) {
        if (userProfileItem.userID == msgContent.fromUid) {
          userProfile = userProfileItem;
          break;
        }
      }
    }

    /// 标记消息显示标记提示 不区分是否是用户自己标记
    if (msgContent.extraInfo.msgType == ExtraInfo_MsgType.PIN_EVENT) {
      if (msgContent.extraInfo.isPin != null && msgContent.extraInfo.isPin) {
        return MarkMessageTipItem(
          name: userProfile.nickName,
          onTap: () async {
            await goToMarkMessageList(context);
          },
        );
      } else {
        return Gaps.empty;
      }
    }

    MsgContent upMsgContent;
    MessageType messageType = MessageType.TEXT;
    ExtraInfo extraInfo = msgContent.extraInfo;
    bool isPin = extraInfo.isPin;
    if (extraInfo != null && extraInfo.attechmentInfo != null) {
      AttechmentInfo attechmentInfo = extraInfo.attechmentInfo;
      String filePath = attechmentInfo.filePath;
      if (filePath != null && filePath.isNotEmpty) {
        if (Utils.isPicture(filePath)) {
          messageType = MessageType.IMAGE;
          msgContent.extraInfo.attechmentInfo.filePath = Utils.getALiOSSUrl() + filePath;
        } else if (Utils.isAttachment(filePath)) {
          messageType = MessageType.ATTACHMENT;
        }
      }
    }
    if (index + 1 < listMsgs.length) {
      upMsgContent = listMsgs[index + 1];
    }

    MessageItem messageItem;
    if (msgContent.fromUid == userInfo.userID) {
      isMe = 1;
    }

    //msgContent.timestamp
    var avatar = userProfile.avatar;
    var nickName = userProfile.nickName;
    var timestamp = Utils.readTimestamp(msgContent.timestamp.toInt());

    var sendStatus = SendStatus.SEND_SUCCESS;
    if (ChatPage.SENDING_KEY == msgContent.seqId) {
      sendStatus = SendStatus.SENDING;
    }
    if (ChatPage.FAILED_KEY == msgContent.seqId) {
      sendStatus = SendStatus.SEND_FAILED;
    }

    var webLinkInfos;
    if (linkInfos.keys.contains(msgContent.seqId)) {
      webLinkInfos = linkInfos[msgContent.seqId];
    }
    String content = msgContent.content;
    /// 用户
    if (content != null && content.isNotEmpty && msgContent.atIds != null && msgContent.atIds.isNotEmpty) {
      content = _replaceMessageToShow(r"<@(\d+)>", content, listUserProfiles);
    }
    /// 分组
//    if (msgContent.atRoles != null && msgContent.atRoles.isNotEmpty) {
//      content = _replaceMessageToShow(r"<@(\d+)>", content, listUserProfiles);
//    }
//    /// 频道
//    if (msgContent.jumpTo != null && msgContent.jumpTo.isNotEmpty) {
//      content = _replaceMessageToShow(r"<@(\d+)>", content, listUserProfiles);
//    }

    msgContent.content = content;
    messageItem = MessageItem(
      avatar,
      nickName,
      timestamp,
      "",
      messageType,
      isMe,
      msgContent,
      linkInfos: webLinkInfos,
      sendStatus: sendStatus,
      upMsgContent: upMsgContent,
      isPin: isPin,
      onPopupClickItem: (value) {
        this.editIndex = index;
        if (value == LongPopupSelectStatus.EDIT) {
          setState(() {
            this.isHideEditView = false;
            this.textEditViewEditingController.text = msgContent.content;
          });
        }
        if (value == LongPopupSelectStatus.DELETE) {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return DeleteMessageItem(messageItem, onCancelCallBack: () {
                Navigator.pop(context);
              }, onTrueCallBack: () {
                Navigator.pop(context);
                _delChannelMsg();
              });
            },
          );
        } else if (value == LongPopupSelectStatus.MARK) {
          /// 标记消息
          _addMark();
        } else if (value == LongPopupSelectStatus.REMOVE_MARK) {
          _removeMark(msgContent);
        } else if (value == LongPopupSelectStatus.COPY) {
          Utils.setClipboardText(msgContent.content);
        }
      },
    );

    return AutoScrollTag(
      key: ValueKey(index),
      controller: _autoScrollController,
      index: index,
      child: GestureDetector(
        child: Container(
          margin: index == 0
              ? EdgeInsets.only(bottom: Macros.scale(10))
              : EdgeInsets.only(bottom: Macros.scale(0)),
          color: Colors.transparent,
          alignment: Alignment.center,
          child: messageItem,
        ),
        onPanDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
          if (!isHideEmojiPanel) {
            setState(() {
              isHideEmojiPanel = true;
            });
          }
          if (!isHideImagePanel) {
            setState(() {
              isHideImagePanel = true;
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    keyboardH = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Color(0xFFF5F5F5),
          actions: <Widget>[
            _buildMark(context),
            IconButton(
              icon: loadAssetImage("channel/icon_24px_set",
                  width: Macros.scale(18), height: Macros.scale(18)),
              onPressed: () {
                NavigatorUtils.push(context, ChannelRouter.channelSetWordPage);
              },
            ),
          ],
          title: Row(
            children: <Widget>[
              GestureDetector(
                child: loadAssetImage(
                  "common/icon_black_back",
                ),
                onTap: () {
                  NavigatorUtils.goBack(context);
                },
              ),
              Container(
                margin: EdgeInsets.only(left: Macros.scale(20)),
                child: loadAssetImage("channel/icon_channel"),
              ),
              Container(
                margin: EdgeInsets.only(left: Macros.scale(4)),
                child: Text(
                  name ?? "",
                  style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: Macros.scale(17),
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          )),
      body: SafeArea(child: _bodyWidget()),
    );
  }

  _buildMark(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Macros.scale(2)),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          IconButton(
            icon: loadAssetImage("chat/icon_pin",
                width: Macros.scale(24), height: Macros.scale(24)),
            onPressed: () async {
              isHideEmojiPanel = true;
              isHideImagePanel = true;
              setState(() {});
              await goToMarkMessageList(context);
            },
          ),
          widget.hasMarkMessage
              ? Positioned(
                  right: Macros.scale(15),
                  top: Macros.scale(18),
                  child: Container(
                    width: Macros.scale(8),
                    height: Macros.scale(8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(Macros.scale(50)),
                    ),
                  ),
                )
              : Gaps.empty
        ],
      ),
    );
  }

  /// 标记消息列表
  Future goToMarkMessageList(BuildContext context) async {
    widget.hasMarkMessage = false;
    setState(() {});
    NavigatorUtils.pushResult(context,
        '${ChatRouter.messageMarkListPage}?channelID=$channelId&subchannelID=$subchannelId',
        (result) async {
      if (result is Int64) {
        if (listMsgs != null && listMsgs.isNotEmpty) {
          int index = _findIndex(result);
          //https://github.com/flutter/flutter/issues/12319
          if (index != -1) {
            /// 加载的列表没有标记消息
            await _autoScrollController.scrollToIndex(index);
          } else {
            /// 获取历史消息
            var seqId = result + 50;
            _showPingMsg(seqId, isNeedScroll: true);
          }
        }
      }
    });
  }

  Future _scrollToIndex(Int64 seqId) async {
    Utils.debug("_scrollToIndex_scrollToIndex");
    int index = _findIndex(seqId);
    Utils.debug("indexindex" + index.toString());
    if (index != -1) {
      await _autoScrollController.scrollToIndex(index);
    }
  }

  int _findIndex(Int64 seqId) {
    int index = -1;
    int length = listMsgs.length;
    for (var i = 0; i < length; i++) {
      if (listMsgs[i]?.seqId == seqId) {
        index = i;
        break;
      }
    }
    return index;
  }

  @override
  void initState() {
    super.initState();

    ChatPage.inChannelId = widget.channelId;
    ChatPage.inSubChannelId = widget.subChannelId;
    name = widget.name;
    channelId = Int64.parseInt(widget.channelId);
    subchannelId = Int64.parseInt(widget.subChannelId);

    _autoScrollController = AutoScrollController();
    _autoScrollController.addListener(() {
      if (_autoScrollController.position.pixels ==
          _autoScrollController.position.maxScrollExtent) {
        Utils.debug("maxScrollExtentmaxScrollExtentmaxScrollExtent");
        //_loadHistoryMsg();
      }
      if (_autoScrollController.position.pixels ==
          _autoScrollController.position.minScrollExtent) {
        Utils.debug("minScrollExtentminScrollExtentminScrollExtent");
        //_loadNewMsg();
      }
    });
    textEditingController = TextEditingController();
    textEditingController.addListener(() {
      String newText = textEditingController.text;
      Utils.debug(
          "textEditingController inputText old --------------> $inputText");
      Utils.debug(
          "textEditingController inputText new --------------> $newText");
      Utils.debug(
          "textEditingController inputText length --------------> ${inputText.length}");
      Utils.debug(
          "textEditingController newText length --------------> ${newText.length}");
      if (inputText == null || inputText.isEmpty) {
        _goToSelect(newText);
      } else {
        if (inputText != null &&
            inputText.isNotEmpty &&
            newText != null &&
            newText.isNotEmpty) {
          if (inputText.length < newText.length) {
            if (newText != null && newText.isNotEmpty) {
              newText = newText.substring(newText.length - 1);
              _goToSelect(newText);
            }
          } else if (inputText.length > newText.length) {
            /// 用户
            if (atMemberList != null && atMemberList.isNotEmpty) {
              for (var item in atMemberList) {
                if (!newText.contains("@${item.channelNickname}")) {
                  atMemberList.remove(item);
                }
              }
            }

            /// 分组（角色）
            if (atRoleList != null && atRoleList.isNotEmpty) {
              for (var item in atRoleList) {
                if (!newText.contains("@${item.channelNickname}")) {
                  atRoleList.remove(item);
                }
              }
            }

            /// 子频道
            if (atSubchannelList != null && atSubchannelList.isNotEmpty) {
              for (var item in atSubchannelList) {
                if (!newText.contains("#${item.name}")) {
                  atSubchannelList.remove(item);
                }
              }
            }
          }
        }
      }

      inputText = textEditingController.text;
    });
    textEditViewEditingController = TextEditingController();

    KeyboardVisibilityNotification().addNewListener(onChange: (show) {
      Utils.debug("KeyboardVisibilityNotification -----------> $show");

      if (show) {
        if (!isHideEmojiPanel) {
          isHideEmojiPanel = true;
        }

        if (!isHideImagePanel) {
          isHideImagePanel = true;
        }
        _autoScrollController.jumpTo(_autoScrollController.offset);
      } else {}
      setState(() {});
    });

    userInfo = AccountManager.instance.getUserInfo();
    _initMsgData();
    if (name == null || name.isEmpty) {
      _initSubchannelData();
    }

    _initEvent();
  }

  /// 跳转到选择界面
  /// @ 选择用户或分组
  ///
  /// # 选择频道
  void _goToSelect(String newText) {
    if (newText == "@") {
      _goToSelectAtMember();
    } else if (newText == "#") {
      _goToSelectAtChannel();
    }
  }

  void _goToSelectAtMember() {
    NavigatorUtils.pushResult(context,
        '${ChannelRouter.selectManager}?actionName=atMember&channelID=${Uri.encodeComponent(widget.channelId)}&subchannelID=${Uri.encodeComponent(widget.subChannelId)}',
        (result) {
      if (result is ContactInfo) {
        if (result.tagIndex == "★") {
          atRoleList.add(result);
        } else {
          atMemberList.add(result);
        }
        textEditingController.text =
            textEditingController.text + result.channelNickname + " ";
        FocusScope.of(context).requestFocus(focusNode);
      }
    });
  }

  void _goToSelectAtChannel() {
    NavigatorUtils.pushResult(context,
        '${ChatRouter.selectAtSubchannelPage}?channelID=${Uri.encodeComponent(widget.channelId)}',
        (result) {
      if (result is SubchannelModel) {
        atSubchannelList.add(result);
        textEditingController.text = textEditingController.text + result.name+ " ";
        FocusScope.of(context).requestFocus(focusNode);
      }
    });
  }

  _genSocketMsgOp(ChannelMsg msg) {
    _seqId = msg.msg.seqId;

    Int64 notfiyCid = msg.cidInfo.cid;
    Int64 notfiySubid = msg.cidInfo.subCid;
    if (notfiyCid == channelId && notfiySubid == subchannelId) {
      setState(() {
        listMsgs.insert(0, msg.msg);
        MsgContent msgContent = msg.msg;
        if (msgContent.extraInfo.msgType == ExtraInfo_MsgType.EDIT_EVENT ||
            msgContent.extraInfo.msgType == ExtraInfo_MsgType.DEL_EVENT ||
            msgContent.extraInfo.msgType == ExtraInfo_MsgType.PIN_EVENT) {
          if (msgContent.extraInfo.msgType == ExtraInfo_MsgType.PIN_EVENT &&
              msgContent.fromUid != userInfo.userID) {
            widget.hasMarkMessage = true;
          }
          listMsgs.forEach((one) {
            if (one is MsgContent) {
              if (one.seqId == msgContent.extraInfo.oldSeqID) {
                one.content = msgContent.content;
                ExtraInfo extraInfo = ExtraInfo();
                if (msgContent.extraInfo.msgType ==
                    ExtraInfo_MsgType.EDIT_EVENT) {
                  one.extraInfo.msgType = ExtraInfo_MsgType.EDIT;
                } else if (msgContent.extraInfo.msgType ==
                    ExtraInfo_MsgType.DEL_EVENT) {
                  one.extraInfo.msgType = ExtraInfo_MsgType.DEL;
                } else if (msgContent.extraInfo.msgType ==
                    ExtraInfo_MsgType.PIN_EVENT) {
                  extraInfo.isPin = msgContent.extraInfo.isPin;
                  extraInfo.attechmentInfo =
                      msgContent.extraInfo.attechmentInfo;
                  extraInfo.oldSeqID = msgContent.extraInfo.oldSeqID;
                  one.extraInfo = extraInfo;
                }
              }
            }
          });
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _autoScrollController.dispose();
    ChatPage.inChannelId = "";
    ChatPage.inSubChannelId = "";
    _eventSocketPushEditChannelMsg.cancel();
    _eventSocketPushDelChannelMsg.cancel();
    _eventSocketPushSendChannelMsg.cancel();
    _removeMarkEventBus.cancel();
  }

  GetChannelMsgReq _genRequestOp(Int64 seqId) {
    GetChannelMsgReq request = GetChannelMsgReq();
    ChannelIdInfo cidInfo = ChannelIdInfo();
    cidInfo.cid = Int64(int.parse(widget.channelId));
    cidInfo.subCid = Int64(int.parse(widget.subChannelId));
    request.cidInfo = cidInfo;
    request.beginSeqId = seqId ?? Macros.maxInt();
    request.limit = 100;
    return request;
  }

  SyncChannelMsgReq _genSyncChannelMsgReqOp() {
    SyncChannelMsgReq request = SyncChannelMsgReq();
    ChannelIdInfo cidInfo = ChannelIdInfo();
    cidInfo.cid = Int64(int.parse(widget.channelId));
    cidInfo.subCid = Int64(int.parse(widget.subChannelId));
    request.cidInfo = cidInfo;
    request.endSeqId = _seqId ?? Int64.MAX_VALUE;
    request.limit = 100;
    request.isForward = false;
    return request;
  }

  _initMsgData() async {
    _seqId = Int64(int.parse(widget.seqId));
    Utils.debug("_seqId_seqId_seqId_seqId" + _seqId.toString());
    GetChannelMsgResp resp =
        await MsgDB().getChannelLastMsg(_genRequestOp(_seqId));
    Utils.debug("resp.msgs.last.seqId" + resp.toString());
    if (resp == null || resp.msgs.length == 0) {
//      Utils.debug("getChannelHistoryMsggetChannelHistoryMsg" + resp.toString());

//      ///网络请求同步最新消息
//      _syncChannelMsgReq();
    } else {
      _refreshWidgetWithResps(resp);
    }

    _syncChannelMsgReq();

    _isLoading = false;
  }

  _initSubchannelData() async {
//    var userChannelDB = new UserChannelDB();
//    var channelData =
//        await userChannelDB.getChannelData(channelId);
//    SubchannelData subchannelData = channelData?.subchannels[subchannelId];
    GetChannelDataRsp channelData =
        await ChannelService.instance.getChannelData(channelId);
    if (channelData != null) {
      SubchannelData subchannelData = channelData.subchannels[subchannelId];
      if (subchannelData != null) {
        name = subchannelData.commonSettings?.name;
        setState(() {});
      }
    }
  }

  _loadHistoryMsg() async {
    Utils.debug("_loadHistoryMsg_loadHistoryMsg_loadHistoryMsg");
    if (_isLoading == true) {
      return;
    }

    GetChannelMsgResp resp =
        await MsgDB().getChannelHistoryMsg(_genRequestOp(listMsgs.last.seqId));
    if (resp.msgs.length == 0) {
      Utils.debug("getChannelHistoryMsggetChannelHistoryMsg" + resp.toString());

      ///网络请求同步最新消息
      _getChannelHistoryMsg();
    } else {
      _refreshHistoryMsg(listMsgs.last.seqId, resp);
    }
  }

  _loadNewMsg() async {
    Utils.debug("_loadNewMsg_loadNewMsg_loadNewMsg_loadNewMsg");
    if (_isLoading == true) {
      return;
    }

    GetChannelMsgResp resp =
        await MsgDB().getChannelNewMsg(_genRequestOp(listMsgs.first.seqId));
    if (resp.msgs.length == 0) {
      Utils.debug("getChannelHistoryMsggetChannelHistoryMsg" + resp.toString());

      ///网络请求同步最新消息
      _getChannelNewMsg(listMsgs.first.seqId);
    } else {
      _refreshNewMsg(listMsgs.first.seqId, resp, isNeedScroll: true);
    }
  }

  _sendChannelMsg() async {
    if (sendMsgStr.isEmpty) {
      return;
    }
    var now = new DateTime.now();
    int nowMill = (now.millisecondsSinceEpoch ~/ 1000);
    MsgContent msgContent = MsgContent();
    msgContent.content = sendMsgStr;
    msgContent.seqId = ChatPage.SENDING_KEY;
    msgContent.timestamp = Int64(nowMill);
    msgContent.fromUid = userInfo.userID;
    setState(() {
      listMsgs.insert(0, msgContent);
    });

    List<Int64> atMemberUserIdList = [];
    List<Int64> atRoleIdList = [];
    List<Int64> atSubchannelIdList = [];
    /// 组装发送的message
    String sendMessage = sendMsgStr;
    if (atMemberList != null && atMemberList.isNotEmpty) {
      for (var item in atMemberList) {
        atMemberUserIdList.add(Int64.parseInt(item.userId));
      }
      /// @(\w+)\s?
      /// @([\s\S]|[^\x00-\xff])*\s?
      sendMessage = _replaceMessageToSend(r"@(\w|[^\x00-\xff])*", sendMessage, atMemberList);
    }
    if (atRoleList != null && atRoleList.isNotEmpty) {
      for (var item in atRoleList) {
        atRoleIdList.add(Int64.parseInt(item.userId));
      }
      sendMessage = _replaceMessageToSend(r"@(\w|[^\x00-\xff])*", sendMessage, atRoleList);
    }
    if (atSubchannelList != null && atSubchannelList.isNotEmpty) {
      for (var item in atSubchannelList) {
        atSubchannelIdList.add(item.subchannelID);
      }
      /// r"#(.*)\s?"
      /// r"#(\w|[^\x00-\xff])*"
      sendMessage = sendMessage.splitMapJoin(RegExp(r"#(\w|[^\x00-\xff])*"), onMatch: (Match match){
        String matchString = match.group(0)?.trim();
        Utils.debug("matchString --------> $matchString");
        String replaceMatchString = "";
        for (var item in atSubchannelList) {
          String channelNickname = "#${item.name}";
          if(channelNickname == matchString) {
            replaceMatchString = "<#${item.subchannelID}>";
          }
        }
        Utils.debug("replaceMatchString --------> $replaceMatchString");
        return replaceMatchString;
      }, onNonMatch: (String nonMatchSting){
        return nonMatchSting;
      });
    }
    Utils.debug("sendMessage ---------------> $sendMessage");
    atMemberList.clear();
    atRoleList.clear();
    atSubchannelList.clear();

    var resp = await GeneralService.instance.sendChannelMsg(
        Int64(int.parse(widget.channelId)),
        Int64(int.parse(widget.subChannelId)),
        content: sendMessage,
        atIds: atMemberUserIdList,
        atRoles: atRoleIdList,
        atSubchannels: atSubchannelIdList);
    if (resp is SendChannelMsgResp) {
      listMsgs.remove(msgContent);
    }
  }

  /// 组装消息发送
  _replaceMessageToSend(String regExpStr, String message, list) {
    RegExp regExp = RegExp(regExpStr);
    String sendMsg = message.splitMapJoin(regExp, onMatch: (Match match){
      String matchString = match.group(0)?.trim();
      String replaceMatchString = "";
      for (var item in list) {
        String channelNickname = "@${item.channelNickname}";
        if(channelNickname == matchString) {
          replaceMatchString = "<@${item.userId}>";
        }
      }
      return replaceMatchString;
    }, onNonMatch: (String nonMatchSting){
      return nonMatchSting;
    });
    Utils.debug("_replaceMessageToSend -------------> $sendMsg");
    return sendMsg;
  }

  /// 组装消息显示
  _replaceMessageToShow(String regExp, String message, List<UserProfile> list) {
    String showMessage = message.splitMapJoin(RegExp(regExp), onMatch: (Match match){
      String matchString = match.group(0)?.trim();
      String replaceMatchString = "";
      for (var item in list) {
        String userID = "<@${item.userID}>";
        if(userID == matchString) {
          replaceMatchString = "@${item.nickName}";
        }
      }
      return replaceMatchString;
    }, onNonMatch: (String nonMatchSting){
      return nonMatchSting;
    });
    Utils.debug("_replaceMessageToShow -------------> $showMessage");
    return showMessage;
  }

  _editChannelMsg() async {
    if (this.editIndex >= this.listMsgs.length) {
      return;
    }
    MsgContent msgContent = this.listMsgs[this.editIndex].clone();
    if (msgContent.content == textEditViewEditingController.text) {
      return;
    } else {
      msgContent.content = textEditViewEditingController.text;
    }
    var resp = await GeneralService.instance.editChannelMsg(
        Int64(int.parse(widget.channelId)),
        Int64(int.parse(widget.subChannelId)),
        msgContent);
    if (resp is Empty) {
    } else {
      //Toast.show("编辑失败");
    }
  }

  _delChannelMsg() async {
    MsgContent msgContent = this.listMsgs[this.editIndex].clone();

    var resp = await GeneralService.instance.delChannelMsg(
        Int64(int.parse(widget.channelId)),
        Int64(int.parse(widget.subChannelId)),
        msgContent.seqId);
    if (resp is Empty) {
    } else {
      //Toast.show("删除失败");
    }
  }

  _addMark() async {
    MsgContent msgContent = this.listMsgs[this.editIndex].clone();
    var result = await GeneralService.instance
        .addPin(channelId, subchannelId, msgContent.seqId);
    if (result is Empty) {
      Toast.show("标记成功");
    }
  }

  /// 移除标记消息
  _removeMark(MsgContent msgContent) async {
    MsgContent content = msgContent.clone();
    var result = await GeneralService.instance
        .removePin(channelId, subchannelId, content.seqId);
    if (result is Empty) {
      Toast.show("移除标记成功");
      _updateExtraInfo(content);
    }
  }

  void _updateExtraInfo(MsgContent content) {
    setState(() {
      if (listMsgs != null && listMsgs.isNotEmpty) {
        listMsgs.forEach((message) {
          if (message is MsgContent && message.seqId == content.seqId) {
            ExtraInfo extraInfo = content.extraInfo;
            extraInfo.isPin = false;
            message.extraInfo = extraInfo;
          }
        });
      }
    });
  }

  /// isNeedScroll 是否需要滚动到指定位置
  _showPingMsg(seqId, {bool isNeedScroll = false}) async {
    var resp = await MsgDB().getChannelHistoryMsg(_genRequestOp(seqId));
    if (resp is GetChannelMsgResp) {
      if (resp.msgs.length == 0) {
        var netResp = await GeneralService.instance
            .getChannelHistoryMsg(_genRequestOp(seqId));
        if (netResp is GetChannelMsgResp) {
          if (netResp.msgs.length > 0) {
            listMsgs.clear();
            _refreshHistoryMsg(seqId, netResp, isNeedScroll: isNeedScroll);
          }
        }
      } else {
        listMsgs.clear();
        _refreshHistoryMsg(seqId, resp);
      }
    }
  }

  _getChannelHistoryMsg({Int64 seqId}) async {
    if (seqId == null) {
      seqId = listMsgs.last.seqId;
    }
    var resp = await GeneralService.instance
        .getChannelHistoryMsg(_genRequestOp(seqId));
    if (resp is GetChannelMsgResp) {
      _refreshHistoryMsg(seqId, resp);

      _setLocalChannelMsg(resp);
    }
  }

  _getChannelNewMsg(Int64 seqId) async {
    if (seqId == null) {
      seqId = listMsgs.first.seqId;
    }
    var resp =
        await GeneralService.instance.getChannelNewMsg(_genRequestOp(seqId));

    if (resp is GetChannelMsgResp) {
      _refreshNewMsg(seqId, resp, isNeedScroll: true);

      _setLocalChannelMsg(resp);
    }
  }

  void _setLocalChannelMsg(GetChannelMsgResp resp) {
    MsgDB().setChannelMsg(Int64(int.parse(widget.channelId)),
        Int64(int.parse(widget.subChannelId)), resp);
  }

  _syncChannelMsgReq() async {
    var resp =
        await GeneralService.instance.syncChannelMsg(_genSyncChannelMsgReqOp());
    if (resp is GetChannelMsgResp) {
      _refreshWidgetWithResps(resp);

      _setLocalChannelMsg(resp);
    }
  }

  _getContentHttp(GetChannelMsgResp resp) {
    resp.msgs.forEach((one) {
      RegExp exp = new RegExp(
          r"(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]");
      Iterable<Match> matches = exp.allMatches(one.content);
      linkInfos[one.seqId] = List<GetLinkInfoResp>();
      for (Match m in matches) {
        String match = m.group(0);
        _getLinkInfo(match, one.seqId);
      }
    });
  }

  _getLinkInfo(String link, Int64 seqId) async {
//    GetLinkInfoReq request = GetLinkInfoReq();
//    request.linkUrl = link;
//    GetLinkInfoResp resp = await LinkDB().getLinkInfo(request);
//    if((resp.title.isEmpty && resp.desc.isEmpty && resp.icon.isEmpty)){
//      var netResp = await GeneralService.instance.getLinkInfo(link);
//      if (netResp != null) {
//        setState(() {
//          linkInfos[seqId].add(netResp);
//        });
//        LinkDB().setLinkInfo(netResp);
//      }
//    }else{
//      setState(() {
//        linkInfos[seqId].add(resp);
//      });
//    }

    var netResp = await GeneralService.instance.getLinkInfo(link);
    if (netResp != null) {
      setState(() {
        linkInfos[seqId].add(netResp);
      });
      //LinkDB().setLinkInfo(netResp);
    }
  }

  _refreshWidgetWithResps(resp, {bool isAdd = false}) {
    if (resp is GetChannelMsgResp) {
      ///更新seqid
      if (resp.msgs.length > 0) {
        _seqId = resp.msgs[resp.msgs.length - 1].seqId;
      }

      ///刷新页面
      setState(() {
        listMsgs.insertAll(0, resp.msgs.reversed);
        listUserProfiles.insertAll(0, resp.userProfiles);
      });

      ///获取http的连接信息
      _getContentHttp(resp);

      _isLoading = false;
    }
  }

  _refreshHistoryMsg(Int64 seqId, resp, {bool isNeedScroll = false}) async {
    if (resp is GetChannelMsgResp) {
      if (resp.msgs.length > 0) {
        resp.msgs.removeAt(resp.msgs.length - 1);
      }

      if (resp.msgs.length > 0) {
        ///更新seqid
        _seqId = resp.msgs.last.seqId;

        resp.msgs.removeAt(0);

        ///刷新页面
        setState(() {
          listMsgs.addAll(resp.msgs.reversed);
          listUserProfiles.insertAll(0, resp.userProfiles);
        });

        if (isNeedScroll) {
          await _scrollToIndex(seqId - 50);
        }

        ///获取http的连接信息
        _getContentHttp(resp);

        _isLoading = false;
      }
    }
  }

  _refreshNewMsg(Int64 seqId, resp, {bool isNeedScroll = false}) async {
    if (resp is GetChannelMsgResp) {
      if (resp.msgs.length > 0) {
        resp.msgs.removeAt(0);
      }

      if (resp.msgs.length > 0) {
        ///更新seqid
        _seqId = resp.msgs.last.seqId;
        _loadingSeqId = seqId;

        ///刷新页面
        setState(() {
          listMsgs.insertAll(0, resp.msgs.reversed);
          listUserProfiles.insertAll(0, resp.userProfiles);
        });


        ///获取http的连接信息
        _getContentHttp(resp);

//        if (isNeedScroll) {
//          await _scrollToIndex(seqId);
//        }

        _isLoading = false;
      }
    }
  }

  _initEvent() {
    _eventSocketPushSendChannelMsg =
        BeeEventBus().eventBus.on<SocketPushSendChannelMsg>().listen((event) {
      _getChannelNewMsg(event.pushSendChannelMsg.msg.msg.seqId - 1);
      //_genSocketMsgOp(event.pushSendChannelMsg.msg);
    });

    _eventSocketPushEditChannelMsg =
        BeeEventBus().eventBus.on<SocketPushEditChannelMsg>().listen((event) {
      //   _getChannelNewMsg(event.pushEditChannelMsg.msg.msg.seqId );
      _genSocketMsgOp(event.pushEditChannelMsg.msg);
    });

    _eventSocketPushDelChannelMsg =
        BeeEventBus().eventBus.on<SocketPushDelChannelMsg>().listen((event) {
      //   _getChannelNewMsg(event.pushDelChannelMsg.msg.msg.seqId );
      _genSocketMsgOp(event.pushDelChannelMsg.msg);
    });

    _removeMarkEventBus =
        BeeEventBus().eventBus.on<RemoveMark>().listen((event) {
      if (event.msgContent != null) {
        _updateExtraInfo(event.msgContent);
      }
    });
  }
}
