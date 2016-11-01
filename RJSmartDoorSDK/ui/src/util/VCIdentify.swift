//
//  VCIdentify.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/28.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation

struct VCIdentify {
    
    static  let GLOBAL_MAIN = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_MAIN, IDENTIFIER:AppContant.STORY_BOARD_MAIN, TITLE: "")
    static let GLOBAL_INFO_TIP = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_MAIN, IDENTIFIER:"InfoTipView", TITLE: "")
    static let GLOBAL_CHANGE_ROOM = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_MAIN, IDENTIFIER:"ChangeRoom", TITLE: "")
    static let GLOBAL_FEEDBACK = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_MAIN, IDENTIFIER:"Feedback", TITLE: "意见反馈")
    static let GLOBAL_ABOUT = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_MAIN, IDENTIFIER:"About", TITLE: "")
    static let GLOBAL_RECORD = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_MAIN, IDENTIFIER:"Record", TITLE: "")
    static let GLOBAL_SHOW_IMG = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_MAIN, IDENTIFIER:"ShowImg", TITLE: "")
    static let GLOBAL_RING = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_MAIN, IDENTIFIER:"Ring", TITLE: "")
    
    
    
    //开通门禁
    static let USER_LOAD_PROPERTY = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_MAIN, IDENTIFIER:"LoadPropertyList", TITLE: "开通门禁")
    static let USER_LOAD_COMMUNITY = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_MAIN, IDENTIFIER:"LoadCommunityList", TITLE: "开通门禁")
    static let USER_LOAD_NODE = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_MAIN, IDENTIFIER:"LoadNodeList", TITLE: "开通门禁")
    static let USER_LOAD_ROOM = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_MAIN, IDENTIFIER:"LoadRoomList", TITLE: "开通门禁")
    static let USER_BIND_ROOM = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_MAIN, IDENTIFIER:"BindRoom", TITLE: "开通门禁")
    
    
    static let MEMBER_LIST = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_AUTHORITY, IDENTIFIER:"MemberList", TITLE: "授权管理")
    static let MEMBER_ADD = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_AUTHORITY, IDENTIFIER:"addMember", TITLE: "授权新成员")
    
    static let SET_NOTIFY_PHONE = VCIdentify(STOTY_BOARD:"setPhone", IDENTIFIER:"SetNotifyPhone", TITLE: "电话通知")
    static let EDIT_NOTIFY_PHONE = VCIdentify(STOTY_BOARD:"setPhone", IDENTIFIER:"EditNotifyPhone", TITLE: "电话通知")
    
    static let FACE_SET = VCIdentify(STOTY_BOARD:"face", IDENTIFIER:"SetFace", TITLE: "人脸识别")
    static let FACE_TAKE = VCIdentify(STOTY_BOARD:"face", IDENTIFIER:"TakeFace", TITLE: "人脸识别")
    static let FACE_CONFIRM = VCIdentify(STOTY_BOARD:"face", IDENTIFIER:"ConfirmFace", TITLE: "人脸识别")
    static let FACE_UPLOAD_SUCCESS = VCIdentify(STOTY_BOARD:"face", IDENTIFIER:"UploadSuccess", TITLE: "人脸识别")
    static let FACE_CHECK = VCIdentify(STOTY_BOARD:"face", IDENTIFIER:"CheckFace", TITLE: "正在验证")
    static let FACE_CHECK_FAIL = VCIdentify(STOTY_BOARD:"face", IDENTIFIER:"CheckFail", TITLE: "正在验证")
    static let FACE_MANAGER = VCIdentify(STOTY_BOARD:"face", IDENTIFIER:"FaceManager", TITLE: "管理头像")
    static let FACE_LIST = VCIdentify(STOTY_BOARD:"face", IDENTIFIER:"FaceList", TITLE: "管理头像")
    
    static let CIRCULAR_LIST = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_CIRCULAR, IDENTIFIER:"CircularList", TITLE: "物业公告")
    static let CIRCULAR_DETAIL_TEXT = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_CIRCULAR, IDENTIFIER:"TextCircular", TITLE: "物业公告")
    static let CIRCULAR_DETAIL_IMG = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_CIRCULAR, IDENTIFIER:"ImgCircular", TITLE: "物业公告")
    static let CIRCULAR_AD_DETAIL = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_CIRCULAR, IDENTIFIER:"ADDetail", TITLE: "")
    
    static let USER_LOGIN = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_USER, IDENTIFIER:"Login", TITLE: "个人登录")
    static let USER_SETTING = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_USER, IDENTIFIER:"UserInfo", TITLE: "设置")
    static let USER_SET_AVATAR = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_USER, IDENTIFIER:"SetAvatar", TITLE: "修改头像")
    static let USER_SET_NAME = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_USER, IDENTIFIER:"SetName", TITLE: "修改名称")
    static let USER_SET_PASSWD = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_USER, IDENTIFIER:"SetPasswd", TITLE: "")
    static let USER_GET_QRCODE = VCIdentify(STOTY_BOARD:AppContant.STORY_BOARD_USER, IDENTIFIER:"GetQRCode", TITLE: "")
    
    
    
    let STOTY_BOARD:String
    let IDENTIFIER:String
    let TITLE:String
    
    
    
    init(STOTY_BOARD:String, IDENTIFIER:String,TITLE:String) {
        self.STOTY_BOARD = STOTY_BOARD
        self.IDENTIFIER = IDENTIFIER
        self.TITLE = TITLE
    }
}
