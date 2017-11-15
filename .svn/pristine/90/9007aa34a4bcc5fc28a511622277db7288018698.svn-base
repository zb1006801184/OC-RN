//
//  JQXURL.h
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/15.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#ifndef JQXURL_h
#define JQXURL_h
//登录
#define httpLogin   [NSString stringWithFormat:@"%@/api/merchant/merchantAppLogin",httpOline]
//获取订单列表
#define httpOrderListByMerchantPhone   [NSString stringWithFormat:@"%@/api/merchant/merchantAppGetUnlineOrderList",httpOline]
//获取用户余额列表
#define httpYUOrderListByMerchantPhone   [NSString stringWithFormat:@"%@/api/merchant/merchantAppGetMerchantBalanceList",httpOline]
//扫码
#define httpGetCard       [NSString stringWithFormat:@"%@/api/merchant/merchantAppScanCode",httpOline]
//余额接口
#define httpCreatYuMonery       [NSString stringWithFormat:@"%@/api/merchant/merchantAppGetMerchantBalance",httpOline]
//积分支付发送验证码
#define httpPayTyp1    [NSString stringWithFormat:@"%@/api/merchant/merchantAppToPay",httpOline]
//现金支付
#define httpPayTyp1NextMonery    [NSString stringWithFormat:@"%@/api/merchant/merchantAppPay",httpOline]
//验证绑定人是否为平台用户
#define JQXBindingPhone    [NSString stringWithFormat:@"%@/api/merchant/testMemberPro",httpOline]
//积分支付
#define httpPayTyp1NextJifen    [NSString stringWithFormat:@"%@/api/merchant/merchantAppPay",httpOline]

//获取唯一标识
#define getOnlySign    [NSString stringWithFormat:@"%@/api/merchant/getUUID",httpOline]

//根据唯一标识查询订单信息
#define getPayStyle    [NSString stringWithFormat:@"%@/api/merchant/getOrderSatusByBarcode",httpOline]
//通过会员手机号获取会员信息
//#define httpVIPMessage   [NSString stringWithFormat:@"%@/api/merchant/getMemberInfoByTel",httpOline]
//充值
#define httpPayRecharge   [NSString stringWithFormat:@"%@/api/merchant/chargeRecord",httpOline]
//校验是否实名认证
#define httpYESorNOName  [NSString stringWithFormat:@"%@/api/merchant/validateRealName",httpOline]
//校验是否绑定银行卡
#define httpYESorNOBank  [NSString stringWithFormat:@"%@/api/merchant/validateBindBank",httpOline]
//实名认证
#define httpRealName     [NSString stringWithFormat:@"%@/api/merchant/realNameAuthentication",httpOline]
//
//根据银行卡获得银行
#define httpBankName  [NSString stringWithFormat:@"%@/api/merchant/getBankName",httpOline]

//绑定银行卡
#define httpBankURL  [NSString stringWithFormat:@"%@/api/merchant/operatorBank",httpOline]
//银行卡列表
#define httpBankListURL  [NSString stringWithFormat:@"%@/api/merchant/getBankList",httpOline]
//提现
#define httpBankOFMonery  [NSString stringWithFormat:@"%@/api/merchant/adduserdrawcashrecord",httpOline]

//@"@"PH20170122""：注册手机验证码 "PH20170104"："修改登录密码" "PH20170101"："找回密码" "PH20170118"："设置支付密码" @"PH20170105":修改支付密码
#define http_CodeURL  [NSString stringWithFormat:@"%@/api/merchant/getVerificationCode",httpOline]
//找回密码
#define http_FindPwdURL  [NSString stringWithFormat:@"%@/api/merchant/forgetPassword",httpOline]

//根据推广师电话获取姓名
#define http_PhoneGETName  [NSString stringWithFormat:@"%@/api/member/getPromoterNameByTel",httpOline]

//获取三级联动信息
#define http_CityList  [NSString stringWithFormat:@"%@/position/getMerchantAppCounty",httpOline]
//获取区域信息
#define http_AreaList  [NSString stringWithFormat:@"%@/position/getTownsByCountyCode",httpOline]
//行业类别接口
#define http_ClassDataList  [NSString stringWithFormat:@"%@/api/merchantType/0",httpOline]
//图片上传
#define http_PhotoURL  [NSString stringWithFormat:@"%@/api/merchant/image/upload",httpOline]

//申请商户
#define http_ShopRegisterURL  [NSString stringWithFormat:@"%@/api/merchant/applyMerchant",httpOline]

//更新地址
#define http_ShopAddressNew  [NSString stringWithFormat:@"%@/api/merchant/updateMerchant",httpOline]
//修改支付密码接口
#define http_UpdatePayPwd  [NSString stringWithFormat:@"%@/api/merchant/updatePayPwd",httpOline]
//设置支付密码接口
#define http_SetPayPwd  [NSString stringWithFormat:@"%@/api/merchant/setPayPwd",httpOline]
//根据手机号获取绑定的会员信息
#define http_VipMessage  [NSString stringWithFormat:@"%@/api/merchant/getShareRecord",httpOline]

//判断是否设置过支付密码
#define http_YESORNOPayPwd  [NSString stringWithFormat:@"%@/api/merchant/verifyPayPwdIsExists",httpOline]
//_______________________________________快火新接口__________________________________
//注册校验手机号
#define JQXHttp_RegisterPhone  [NSString stringWithFormat:@"%@/api/merchant/registerbyphone",httpOline]
//激活码
#define JQXHttp_IsCdKey  [NSString stringWithFormat:@"%@/api/merchant/provCodeByMerchanrId",httpOline]

//回显账户信息
#define JQXHttp_MAINShopMessage  [NSString stringWithFormat:@"%@/api/merchant/updateMerchantInfo",httpOline]

//线下付手机校验
#define JQXHttp_MoneryPhone  [NSString stringWithFormat:@"%@/api/merchant/testAddTradOrder",httpOline]

//商户完善营业时间 人均消费
#define JQXHttp_MAINShopMessageMoeryTime  [NSString stringWithFormat:@"%@/api/merchant/updateMerchantInfoById",httpOline]
//添加分类
#define JQXHttp_AddClass  [NSString stringWithFormat:@"%@/api/dishs/addDishType",httpOline]
//编辑分类
#define JQXHttp_EditClass  [NSString stringWithFormat:@"%@/api/dishs/updateTypeName",httpOline]
//删除分类
#define JQXHttp_DeleteClass  [NSString stringWithFormat:@"%@/api/dishs/deleteTypeId",httpOline]
//商品分类列表
#define JQXHttp_ShopClassList  [NSString stringWithFormat:@"%@/api/dishs/getDishtypeList",httpOline]
//餐位分类列表
#define JQXHttp_TableClassList  [NSString stringWithFormat:@"%@/compartment/findType",httpOline]
//餐位分类列表下的餐位
#define JQXHttp_TableClassSmallList  [NSString stringWithFormat:@"%@/compartment/findTypeDishName",httpOline]
//商品列表(上架／下架列表)
#define JQXHttp_ShopList  [NSString stringWithFormat:@"%@/api/dishs/getDishsSaleOrCancelList",httpOline]
//商品分类至
#define JQXHttp_ClassAfter  [NSString stringWithFormat:@"%@/api/dishs/updateClassifyTo",httpOline]
//上架下架功能
#define JQXHttp_ShopUpOut  [NSString stringWithFormat:@"%@/api/dishs/dishBatchSaleOrCancel",httpOline]
//添加商品
#define JQXHttp_AddShop  [NSString stringWithFormat:@"%@/api/dishs/addDish",httpOline]
//编辑商品
#define JQXHttp_UpDateShop  [NSString stringWithFormat:@"%@/api/dishs/UpdateDish",httpOline]
//商品回显
#define JQXHttp_ShopMessage  [NSString stringWithFormat:@"%@/api/dishs/findDistOneId",httpOline]

//查询类别下的商品
#define JQXHttp_ClassShopList  [NSString stringWithFormat:@"%@/api/dishs/getDishList",httpOline]

//获取餐位列表
#define JQXHttp_TableListPhone  [NSString stringWithFormat:@"%@/compartment/findRestaurantList",httpOline]
//添加餐位
#define JQXHttp_TableAddPhone  [NSString stringWithFormat:@"%@/compartment/addRestaurant",httpOline]
//编辑餐位
#define JQXHttp_TableUpdate  [NSString stringWithFormat:@"%@/compartment/updateSeat",httpOline]
//餐位回显
#define JQXHttp_TableMessageShow  [NSString stringWithFormat:@"%@/compartment/findSeatInfo",httpOline]
//删除餐位
#define JQXHttp_TableDelete  [NSString stringWithFormat:@"%@/compartment/delsRestaurant",httpOline]
//添加餐位图片上传
#define JQXHttp_TableAddPhonePic  [NSString stringWithFormat:@"%@/api/merchant/image/upload",httpOline]

//预定管理列表
#define JQXHttp_AdvanceManagerList  [NSString stringWithFormat:@"%@/api/personal/queryOrder/queryOrders/merchant",httpOline]
//预定管理订单详情
#define JQXHttp_AdvanceManagerDetails  [NSString stringWithFormat:@"%@/api/personal/queryOrder/merchant/queryOrder",httpOline]
//预定管理接单
#define JQXHttp_AdvanceAgreeOrder  [NSString stringWithFormat:@"%@/merchantOrder/agreeOrder",httpOline]
//预定管理评论列表
#define JQXHttp_AdvanceMessage  [NSString stringWithFormat:@"%@/api/orderOnlineComment/merchant/findComments",httpOline]
//回复会员评论
#define JQXHttp_AdvanceMessageReply  [NSString stringWithFormat:@"%@/api/orderOnlineComment/addComment/merchant",httpOline]
//订单管理列表
#define JQXHttp_OrderList  [NSString stringWithFormat:@"%@/api/merchant/getMerchantTradOrder",httpOline]
//发起交易订单
#define JQXHttp_SendOrder  [NSString stringWithFormat:@"%@/api/merchant/addTradOrder",httpOline]

//支付之前发送验证码
#define JQXHttp_PayOnCode  [NSString stringWithFormat:@"%@/api/merchant/sendcodebeforepay",httpOline]
//支付之前校验验证码
#define JQXHttp_PayOnCodeYES  [NSString stringWithFormat:@"%@/api/merchant/checkpaycode",httpOline]

//用户注册协议
#define JQXHttp_RegisterService  @"http://113.209.232.118/html/shanghuzhucexieyi.html"

//用户登出
//#define httpToLogin    [NSString stringWithFormat:@"http://123.207.167.176:6888/app/toLogin"];

//____________________________________二期新接口__________________________________
//查询手机号的注册信息
#define JQXHttp_PhoneMessage  [NSString stringWithFormat:@"%@/api/merchant/getmsgbyphone",httpOline]
//找回账号
#define JQXHttp_PhoneCount  [NSString stringWithFormat:@"%@/api/merchant/findaccount",httpOline]
//添加店面经理发送验证码
#define JQXHttp_ShopManagerCode  [NSString stringWithFormat:@"%@/api/merchant/tocodestroemamager",httpOline]
//添加店面经理
#define JQXHttp_ShopManagerNew  [NSString stringWithFormat:@"%@/api/merchant/addstroemanager",httpOline]
//解聘店面经理
#define JQXHttp_ShopManagerDismissal  [NSString stringWithFormat:@"%@/api/merchant/dismissal",httpOline]
//查询用户消费时段
#define JQXHttp_TableFindDissipate  [NSString stringWithFormat:@"%@/compartment/findDissipate",httpOline]
//新增用户消费时段
#define JQXHttp_TableNewDissipate  [NSString stringWithFormat:@"%@/compartment/addDissipate",httpOline]
//预定管理取消订单
#define JQXHttp_AdvanceDisAgreeOrder  [NSString stringWithFormat:@"%@/merchantOrder/cancelOrder",httpOline]
//删除用户消费时段
#define JQXHttp_TableDeleteDissipate  [NSString stringWithFormat:@"%@/compartment/delDissipate",httpOline]
//版本判断
#define JQXHttp_Version  [NSString stringWithFormat:@"%@/api/merchant//appversion",httpOline]
//提现发送短信验证码
#define JQXMoneyCode_HaveMoney  [NSString stringWithFormat:@"%@/api/merchant/merchantsendcode",httpOline]

//服务经理
#define JQXServiceManager_Url  [NSString stringWithFormat:@"%@/api/merchant/serviceAdvisorShow",httpOline]

//修改标签回显
#define JQXPagShow  [NSString stringWithFormat:@"%@/api/dishs/getTitleAll",httpOline]
//修改标签
#define JQXPagShow_UPDate  [NSString stringWithFormat:@"%@/api/dishs/updateTitle",httpOline]

//_______________________________________支付__________________________________

//快捷支付
#define http_QuckPay   [NSString stringWithFormat:@"%@/pay/swift/paySwiftCodeUrl",httpOlinePay]
//获取支付宝签名
#define httpAplipayUrl  [NSString stringWithFormat:@"%@/alipay/alipay/app/order/sign",httpOlinePay]
//第四种支付
#define http_bj_com_payUrl  [NSString stringWithFormat:@"%@/pay/commonPay/commonPay",httpOlinePay]



//正式环境
//#define httpOline     @"http://113.209.232.118:10002"
//#define httpOlinePay  @"http://113.209.232.118:8080"

//测试环境
#define httpOline     @"http://123.207.173.18:10002"
#define httpOlinePay   @"http://123.207.173.18:80"

////正式域名
//#define httpOline     @"http://merchant.kuaihuo315.com"
//#define httpOlinePay   @"http://pay.kuaihuo315.com"
#endif /* JQXURL_h */
