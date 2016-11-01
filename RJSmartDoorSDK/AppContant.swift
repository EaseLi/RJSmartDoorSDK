//
//  AppContant.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/21.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
class AppContant {
    
    
    static let COPYRIGHT = "版权  ©2015Ruijia_SmartHome"
    static let PUSH_TOKEN="smart_door_dev_key"
    //    static let PUSH_TOKEN="smart_door_pro_key"
    static let INTERFACE_SALT="guppy1"
    static let NET_EASE_KEY="0a8c0528b2860db4d7b4f1468ecc20bd"
    //联调环境
//    static let BASE_URL = "http://acs.alpha.corelines.cn"
            static let BASE_URL = "http://acs.devel.corelines.cn"
    //    static let BASE_URL = "http://acs.gamma.corelines.cn"
    
    
    //个人账号
    static let USER_VERIFYCODE="/phone/v1/account/send/verify/code" //获取验证码
    static let USER_CHECK_VERIFYCODE="/phone/v1/account/check/register/verify/code" //注册校验验证码
    static let USER_COMPLETE_INFO="/phone/v1/account/complete/info" //录入密码
    static let USER_LOGIN="/phone/v1/account/login"
    static let USER_RESET_PASSWD="/phone/v1/account/check/reset/password" //重置密码校验验证码
    
    static let USER_LOAD_PROPERTY_LIST="/phone/v1/account/load/property/list" //获取物业列表
    static let USER_LOAD_COMMUNITY_LIST="/phone/v1/account/load/community/list" //获取小区列表
    static let USER_LOAD_NODE_LIST="/phone/v1/account/load/node/list" //获取节点列表
    static let USER_LOAD_ROOM_LIST="/phone/v1/account/load/room/list" //登录-个人账号加载控制器-获取房间列表
    
    static let USER_CHECK_INFOMATION="/phone/v1/account/input/owner/information"//开通门禁控制器-填写业主资料
    
    static let USER_UPLOAD_AVATAR = "/phone/v1/account/avatar/modify" //个人账号控制器-修改头像
    static let USER_MODIFY_NAME="/phone/v1/account/modify" //个人账号控制器-修改住户信息
    
    
    
    
    static let HOME_LOAD_DEFAULT_HOME="/phone/v1/home/load/default/home" //主页加载控制器-加载默认首页
    static let HOME_OPEN_DOOR = "/phone/v1/home/door/initiative/access" //开门控制器-主动开门
    static let HOME_OPEN_DOOR_RESULT = "/phone/v1/home/door/event/log" //开门-开门控制器-轮询门口机开门事件日志-HTTPS
    static let HOME_RESPONSE_VISIT = "/phone/v1/home/door/respond/visit/access" //开门控制器-响应访客开门
    static let HOME_SETUP_SHIELDING = "/phone/v1/home/call/setup/shielding/visitors" //睿家-呼叫设置控制器-设置免扰模式
    static let HOME_AUTHOR_ROOM_MODEL = "/phone/v1/home/authorization/room/model/modify" //睿家-授权控制器-修改房间模式
    
    static let RECORD_LOAD_CALL_LIST="/phone/v1/record/load/call/list" //门禁记录-记录控制器-加载来访记录列表
    static let RECORD_LOAD_OPEN_LIST="/phone/v1/record/load/open/lock/list" //门禁记录-记录控制器-加载开门记录列表
    
    //成员管理
    static let MEMBER_LIST="/phone/v1/home/authorization/load/member/list" //鉴权加载控制器-加载家庭成员列表
    static let MEMBER_ADD="/phone/v1/home/authorization/member/add" //授权控制器-新增家庭成员
    static let MEMBER_REMOVE="/phone/v1/home/authorization/member/remove" //授权控制器-删除家庭成员
    
    static let SET_NOTIFY_PHONE="/phone/v1/home/call/setup/call/number"//呼叫设置控制器-设置电话通知
    
    
    static let FACE_UPLOAD_TOKEN = "/phone/v1/other/get/qiniu/face/upload/token" //第三方-第三方控制器-获取七牛刷脸令牌
    static let FACE_RECOGNITION_TOKEN = "/phone/v1/other/get/qiniu/recognition/upload/token" //第三方-第三方控制器-获取七牛人脸识别令牌
    static let FACE_LIST = "/phone/v1/account/load/face/list" //个人账号-个人账号加载控制器-加载脸列表
    static let FACE_REMOVE = "/phone/v1/other/face/remove" //第三方-脸部识别控制器-删除人脸
    static let FACE_MODIFY = "/phone/v1/other/get/qiniu/face/modify/token" //第三方-获取七牛更新脸令牌
    
    
    
    static let CIRCULAR_LIST = "/phone/v1/circular/load/list" //公告控制器-加载公告列表-HTTPS
    static let CIRCULAR_READ = "/phone/v1/circular/read/status/modify" //公告控制器-修改公告已读状态-HTTPS
    static let CIRCULAR_DETAIL = "/phone/v1/circular/load/detail" //公告控制器-加载公告详细信息-HTTPS
    
    static let AD_LIST =  "/phone/v1/advert/load/list" //广告控制器-加载广告列表-HTTPS
    
    static let PUSH_LIST =  "/push/v1/storage/load/all/message" //存储管理-存储控制器-加载所有消息-HTTPS
    static let PUSH_DETAIL =  "/push/v1/storage/load/one/message" //存储管理-存储控制器-加载一条消息-HTTPS
    
    //本地通知时间
    static let NOTIFY_PAGE_REDIRECT = "NOTIFY_PAGE_REDIRECT"//页面跳转
    static let NOTIFY_BIND_ROOM_PAGE_REDIRECT = "NOTIFY_BIND_ROOM_PAGE_REDIRECT"//页面跳转
    static let NOTIFY_LOGIN_OUT="NOTIFY_LOGIN_OUT"//退出
    static let NOTIFY_LOGIN_IN="NOTIFY_LOGIN_IN"//登录
    static let NOTIFY_RING = "NOTIFY_RING"//访客来访
    static let NOTIFY_OPEN_DOOR = "NOTIFY_OPEN_DOOR"
    static let NOTIFY_CHANGE_AVATAR = "NOTIFY_CHANGE_AVATAR"
    static let NOTIFY_CHANGE_NAME = "NOTIFY_CHANGE_NAME"
    static let NOTIFY_AUTHORITY_AGREE="NOTIFY_AUTHORITY_AGREE"
    static let NOTIFY_AUTHORITY_REFUSE="NOTIFY_AUTHORITY_REFUSE"
    static let NOTIFY_AD_UPDATE="NOTIFY_AD_UPDATE" //刷新ui
    static let NOTIFY_AD_DATA_UPDATE = "NOTIFY_AD_DATA_UPDATE" //刷新广告数据
    static let NOTIFY_LOGIN_OUTTIME = "NOTIFY_LOGIN_OUTTIME" //令牌发生改变
    static let NOTIFY_OTHER_OPEN_DOOR_RESPONSE = "NOTIFY_OTHER_OPEN_DOOR_RESPONSE" //访客开门-通知响应访客开门(MQTT)
    
    static let TOAST_SUCCESS = "SUCCESS"
    static let TOAST_WARN = "WARN"
    
    static let APNS_NOTIFY_ACT_OPEN_DOOR_RESULT = "201103"//201103 主动开门-反馈开门(MQTT)
    static let APNS_NOTIFY_OPEN_DOOR = "201002" //201002 访客开门-通知房间成员(MQTT)
    static let APNS_NOTIFY_OPEN_DOOR_INTERUPT = "201009"//201009 访客开门-中断开门(MQTT)
    static let APNS_NOTIFY_OPEN_DOOR_RESULT = "201008"//201008 访客开门-反馈开门(MQTT)
    static let APNS_NOTIFY_OTHER_OPEN_DOOR_RESULT = "201004"//201004 访客开门-通知响应访客开门(MQTT)
    static let APNS_NOTIFY_LOGIC = "201202"//201202 通知-通知手机端(MQTT)
    
    
    static let STORY_BOARD_FACE="face"
    static let STORY_BOARD_MAIN="Main"
    static let STORY_BOARD_SETPHONE="setPhone"
    static let STORY_BOARD_CIRCULAR="circular"
    static let STORY_BOARD_USER="user"
    static let STORY_BOARD_AUTHORITY="authority"
    
    
    static let INFO_TIP_SETPHONE_CONFIRM="ConfirmSetPhone"
    static let INFO_TIP_SETPHONE_SUCCESS="SetPhoneSuccess"
    static let INFO_TIP_SETPASSWD_SUCCESS="SetPasswdSuccess"
    static let INFO_TIP_BINDROOM_FAIL="BindRoomFail"
    static let INFO_TIP_FACE_CONFIRM="SetFaceConfirm"
    static let INFO_TIP_FACE_SUCCESS="SetFaceSuccess"
    static let INFO_TIP_FACE_RESET="SetFaceReset"
}
