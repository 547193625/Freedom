//
//  URLStatic.h
//  Freedom
//
//  Created by Andrew on 2021/1/19.
//

#ifndef URLStatic_h
#define URLStatic_h

//MARK:-----------App接口环境-----------
#define kBaseURL      @"http://ble.fangpengtech.com"


//MARK:----------- 接口地址相关-----------
#define kRequestURL(subURL) [NSString stringWithFormat:@"%@%@",kBaseURL,subURL]

//***********-----url------*************
#define registration          @"/registration/"
#define LOGIN                 @"/login/"
#define passwordReset         @"/password/reset/"
#define PASSWORDCHANGE        @"/modify-password/" // 设置更改密码
#define PASSWORDRESET         @"/reset-password/" // 忘记密码重置密码

#define EMAILCODES               @"/email-codes/" // 邮箱验证码

#define USER_REGISTR             @"/users/" // 注册

#define USER_INFO                @"/user-info/" // 个人信息

#define PROJECTS_LIST            @"/projects/" // 项目列表

#define CREATE_AREA              @"/areas/" // 区域列表

#define CREATE_DEVICE            @"/device/" // 添加设备

#define CREATE_DEVICES           @"/devices/" // 设备




#define kCommandInterval    (0.32)

//TimeOut
#define TimeOut_KickoutDelayResponseTime    (1.5)
#define TimeOut_KickoutConnectedDelayResponseTime   (5.0)

//Tip
#define Tip_CommandBusy @"SDK work in the sky, busy now"
#define Tip_DeviceOutline   @"device is outline"
#define Tip_DisconnectOrConnectFail @"diconnect or connect fail"
#define Tip_KickoutDevice   @"kick out ..."
#define Tip_ReKeyBindDevice @"reKeyBind ..."
#define Tip_ReKeyBindDeviceSuccess  @"reKeyBind success ..."
#define Tip_ReKeyBindDeviceFail @"KeyBind fail, retry?"
#define Tip_OTAFileError    @"OTA data error, not exist or missing"

#define Tip_AddNewDevices   @"ready scan devices ..."
#define Tip_AddNextDevices  @"add another device ..."
#define Tip_AddDeviceProvisionSuccess   @"provision success keyBinding ..."
#define Tip_AddDeviceKeyBindSuccess @"keyBind success, scan other ..."
#define Tip_AddDeviceFail   @"add device fail, scan other ..."
#define Tip_FinishAddNewDevices @"finish add devices ..."

#define Tip_EditGroup   @"editing group ..."
#define Tip_EditGroupFail   @"editing group fail ..."

#define Tip_SaveScene   @"save scene ..."
#define Tip_SaveSceneSuccess   @"save scene success ..."
#define Tip_DeleteScene   @"delete scene ..."
#define Tip_DeleteSceneSuccess   @"delete scene success ..."
#define Tip_SelectScene   @"select at least one item!"

//分享使用方式(是否使用蓝牙点对点传输，YES为二维码加蓝牙点对点，NO为存二维码)
#define kShareWithBluetoothPointToPoint (YES)
//setting界面显示
#define kShowScenes (YES)
#define kShowHomes  (NO)
#define kShowDebug  (YES)
#define kshowLog        (YES)
#define kshowShare    (YES)
#define kshowMeshInfo    (YES)
#define kshowMeshOTA    (YES)
#define kshowChooseAdd    (YES)

//HSL发送数据包是使用RGB转HSL的模式
#define kControllerInHSL    (YES)
//HSL发送数据包是使用RGB转HSV的模式（iOS系统提供的接口就是RGB转HSV的接口）
//#define kControllerInHSL    (NO)

#define kKeyBindType  @"kKeyBindType"
#define kRemoteAddType  @"kRemoteAddType"
#define kFastAddType  @"kFastAddType"
#define kGetOnlineStatusType  @"kGetOnlineStatusType"

//app通用蓝色
#define kDefultColor [UIColor colorWithRed:0x4A/255.0 green:0x87/255.0 blue:0xEE/255.0 alpha:1]
#define kDefultUnableColor [UIColor colorWithRed:0x4A/255.0 green:0x87/255.0 blue:0xEE/255.0 alpha:0.5]
//获取导航栏+状态栏的高度
#define kGetRectNavAndStatusHight  (self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height)

#define SCANSPACEOFFSET 0.15f


#define sigNodeArrayNSNotification   @"sigNodeArrayNSNotification"



//MARK:-----------网络相关-----------
// 接口返回状态
#define REQUEST_STATUS_CODE                              @"status"
// 接口返回信息
#define REQUEST_STATUS_MSG                               @"message"
// 返回正常
#define REQUEST_STATU_SUCCESS_C0000                      @"201"
// 返回成功
#define REQUEST_STATU_SUCCESS_1000                       @"201"
// 无数据
#define REQUEST_STATU_SUCCESS_NODATA                     @"C0010"
// 用户未登录
#define REQUEST_STATU_UNLOGIN                            @"E0008"
// 账号在其它设备上登录
#define REQUEST_STATU_LOGIN_ON_OTHER_DEVICE              @"4000"
// 没有登录，请重新登录
#define REQUEST_STATU_ACCOUNT_NOT_LOGIN                  @"6000"
// 帐号已被停用
#define REQUEST_STATU_ACCOUNT_DISABLED                   @"5000"
// 该账号已绑定其他手机/该手机已绑定其他账号
#define REQUEST_STATU_ACCOUNT_BINDING_ERROR              @"8000"
// 该账号已绑定其他手机多次
#define REQUEST_STATU_ACCOUNT_BINDING_TIMES              @"8001"


#endif /* URLStatic_h */
