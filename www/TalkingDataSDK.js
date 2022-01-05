var exec = require('cordova/exec');

var TalkingDataSDK = {
    
    /**
     * TalkingData SDK初始化方法。
     * @param {string} appId            : 应用的唯一标识，统计后台注册得到
     * @param {string} channelId        : 渠道名（可选）。如“AppStore”
     * @param {string} custom           : 自定义参数（可选）。
     */
    init: function(appId, channelId, custom) {
        exec(null, null, "TalkingDataSDK", "init", [appId, channelId, custom]);
    },
    
    /**
     * 开启后台时长统计
     */
    backgroundSessionEnabled: function() {
        exec(null, null, "TalkingDataSDK", "backgroundSessionEnabled", []);
    },
    
    /**
     * 获取 TDID，并将其作为参数传入 JS 的回调函数
     * @param {object}  callBack        : 处理 TDID 的回调函数
     */
    getDeviceId: function(callBack) {
        exec(callBack, null, "TalkingDataSDK", "getDeviceId", []);
    },
    
    /**
     * 获取 OAID，并将其作为参数传入 JS 的回调函数
     * @param {object}  callBack        : 处理 OAID 的回调函数
     */
    getOAID: function(callBack) {
        exec(callBack, null, "TalkingDataSDK", "getOAID", []);
    },
    
    /**
     * 关闭日志
     */
    setVerboseLogDisable: function() {
        exec(null, null, "TalkingDataSDK", "setVerboseLogDisable", []);
    },
    
    /**
     * 设置位置信息
     * @param {number}  latitude        : 纬度
     * @param {number}  longitude       : 经度
     */
    setLocation: function(latitude, longitude) {
        exec(null, null, "TalkingDataSDK", "setLocation", [latitude, longitude]);
    },
    
    /**
     * 开始跟踪某一页面，并自动结束上一页面的跟踪
     * @param {string}  pageName        : 页面名称
     */
    onPage: function(pageName) {
        exec(null, null, "TalkingDataSDK", "onPage", [pageName]);
    },
    
    /**
     * 开始跟踪某一页面，记录页面打开时间
     * @param {string}  pageName        : 页面名称
     */
    onPageBegin: function(pageName) {
        exec(null, null, "TalkingDataSDK", "onPageBegin", [pageName]);
    },
    
    /**
     * 结束某一页面的跟踪，记录页面的关闭时间
     * 此方法与onPageBegin方法结对使用
     * @param {string}  pageName        : 页面名称，请跟onPageBegin方法的页面名称保持一致
     */
    onPageEnd: function(pageName) {
        exec(null, null, "TalkingDataSDK", "onPageEnd", [pageName]);
    },
    
    /**
     * 唤醒
     * @param {string}  link            : 唤醒应用的链接
     */
    onReceiveDeepLink: function(link) {
        exec(null, null, "TalkingDataSDK", "onReceiveDeepLink", [link]);
    },
    
    /**
     * 注册
     * @param {string}  profileId       : 用户账号
     * @param {object}  profile         : 账户属性
     * @param {string}  invitationCode  : 邀请码
     */
    onRegister: function(profileId, profile, invitationCode) {
        var profileJson = JSON.stringify(profile);
        exec(null, null, "TalkingDataSDK", "onRegister", [profileId, profileJson, invitationCode]);
    },
    
    /**
     * 登录
     * @param {string}  profileId       : 用户账号
     * @param {object}  profile         : 账户属性
     */
    onLogin: function(profileId, profile) {
        var profileJson = JSON.stringify(profile);
        exec(null, null, "TalkingDataSDK", "onLogin", [profileId, profileJson]);
    },
    
    /**
     * 更新帐户属性
     * @param {object}  profile         : 帐户属性
     */
    onProfileUpdate: function(profile) {
        var profileJson = JSON.stringify(profile);
        exec(null, null, "TalkingDataSDK", "onProfileUpdate", [profileJson]);
    },
    
    /**
     * 添加支付信息
     * @param {string}  profileId       : 用户账号
     * @param {string}  method          : 支付方式
     * @param {string}  content         : 支付信息
     */
    onCreateCard: function(profileId, method, content) {
        exec(null, null, "TalkingDataSDK", "onCreateCard", [profileId, method, content]);
    },
    
    /**
     * 收藏
     * @param {string}  category        : 收藏类别
     * @param {string}  content         : 收藏内容
     */
    onFavorite: function(category, content) {
        exec(null, null, "TalkingDataSDK", "onFavorite", [category, content]);
    },
    
    /**
     * 分享
     * @param {string}  profileId       : 用户账号
     * @param {string}  content         : 分享内容
     */
    onShare: function(profileId, content) {
        exec(null, null, "TalkingDataSDK", "onShare", [profileId, content]);
    },
    
    /**
     * 签到打卡
     * @param {string}  profileId       : 用户账号
     * @param {string}  punchId         : 签到打卡ID
     */
    onPunch: function(profileId, punchId) {
        exec(null, null, "TalkingDataSDK", "onPunch", [profileId, punchId]);
    },
    
    /**
     * 搜索
     * @param {object}  search          : 搜索属性
     */
    onSearch: function(search) {
        var searchJson = JSON.stringify(search);
        exec(null, null, "TalkingDataSDK", "onSearch", [searchJson]);
    },
    
    /**
     * 联系
     * @param {string}  profileId       : 用户账号
     * @param {string}  content         : 联系内容
     */
    onContact: function(profileId, content) {
        exec(null, null, "TalkingDataSDK", "onContact", [profileId, content]);
    },
    
    /**
     * 付费
     * @param {string}  profileId       : 用户账号
     * @param {string}  orderId         : 订单ID
     * @param {number}  amount          : 订单金额
     * @param {string}  currencyType    : 货币类型
     * @param {string}  paymentType     : 支付类型
     * @param {string}  itemId          : 物品ID
     * @param {number}  itemCount       : 物品数量
     */
    onPay: function(profileId, orderId, amount, currencyType, paymentType, itemId, itemCount) {
        exec(null, null, "TalkingDataSDK", "onPay", [profileId, orderId, amount, currencyType, paymentType, itemId, itemCount]);
    },
    
    /**
     * 退单
     * @param {string}  profileId       : 用户账号
     * @param {string}  orderId         : 订单ID
     * @param {string}  reason          : 退单原因
     * @param {string}  type            : 退单类型
     */
    onChargeBack: function(profileId, orderId, reason, type) {
        exec(null, null, "TalkingDataSDK", "onChargeBack", [profileId, orderId, reason, type]);
    },
    
    /**
     * 预约
     * @param {string}  profileId       : 用户账号
     * @param {string}  reservationId   : 预约ID
     * @param {string}  category        : 预约分类
     * @param {number}  amount          : 预约金额
     * @param {string}  term            : 预约信息
     */
    onReservation: function(profileId, reservationId, category, amount, term) {
        exec(null, null, "TalkingDataSDK", "onReservation", [profileId, reservationId, category, amount, term]);
    },
    
    /**
     * 预订
     * @param {string}  profileId       : 用户账号
     * @param {string}  bookingId       : 预订ID
     * @param {string}  category        : 预订分类
     * @param {number}  amount          : 预订金额
     * @param {string}  content         : 预订信息
     */
    onBooking: function(profileId, bookingId, category, amount, content) {
        exec(null, null, "TalkingDataSDK", "onBooking", [profileId, bookingId, category, amount, content]);
    },
    
    /**
     * 查看商品
     * @param {string}  itemId          : 商品ID
     * @param {string}  category        : 商品类别
     * @param {string}  name            : 商品名称
     * @param {number}  unitPrice       : 商品单价
     */
    onViewItem: function(itemId, category, name, unitPrice) {
        exec(null, null, "TalkingDataSDK", "onViewItem", [itemId, category, name, unitPrice]);
    },
    
    /**
     * 添加商品到购物车
     * @param {string}  itemId          : 商品ID
     * @param {string}  category        : 商品类别
     * @param {string}  name            : 商品名称
     * @param {number}  unitPrice       : 商品单价
     * @param {number}  amount          : 商品数量
     */
    onAddItemToShoppingCart: function(itemId, category, name, unitPrice, amount) {
        exec(null, null, "TalkingDataSDK", "onAddItemToShoppingCart", [itemId, category, name, unitPrice, amount]);
    },
    
    /**
     * 查看购物车
     * @param {object}  shoppingCart    : 购物车详情
     */
    onViewShoppingCart: function(shoppingCart) {
        var shoppingCartJson = JSON.stringify(shoppingCart);
        exec(null, null, "TalkingDataSDK", "onViewShoppingCart", [shoppingCartJson]);
    },
    
    /**
     * 下订单
     * @param {object}  order           : 订单详情
     * @param {string}  profileId       : 用户账号
     */
    onPlaceOrder: function(order, profileId) {
        var orderJson = JSON.stringify(order);
        exec(null, null, "TalkingDataSDK", "onPlaceOrder", [orderJson, profileId]);
    },
    
    /**
     * 支付订单
     * @param {object}  order           : 订单详情
     * @param {string}  paymentType     : 支付类型
     * @param {string}  profileId       : 用户账号
     */
    onOrderPaySucc: function(order, paymentType, profileId) {
        var orderJson = JSON.stringify(order);
        exec(null, null, "TalkingDataSDK", "onOrderPaySucc", [orderJson, paymentType, profileId]);
    },
    
    /**
     * 取消订单
     * @param {object} order            : 订单详情
     */
    onCancelOrder: function(order) {
        var orderJson = JSON.stringify(order);
        exec(null, null, "TalkingDataSDK", "onCancelOrder", [orderJson]);
    },
    
    /**
     * 授信
     * @param {string}  profileId       : 用户账号
     * @param {number}  amount          : 授信额度
     * @param {string}  content         : 授信信息
     */
    onCredit: function(profileId, amount, content) {
        exec(null, null, "TalkingDataSDK", "onCredit", [profileId, amount, content]);
    },
    
    /**
     * 交易
     * @param {string}  profileId       : 用户账号
     * @param {object}  transaction     : 交易属性
     */
    onTransaction: function(profileId, transaction) {
        var transactionJson = JSON.stringify(transaction);
        exec(null, null, "TalkingDataSDK", "onTransaction", [profileId, transactionJson]);
    },
    
    /**
     * 创建角色
     * @param {string}  name            : 角色名称
     */
    onCreateRole: function(name) {
        exec(null, null, "TalkingDataSDK", "onCreateRole", [name]);
    },
    
    /**
     * 通过关卡
     * @param {string}  profileId       : 用户账号
     * @param {string}  levelId         : 关卡ID
     */
    onLevelPass: function(profileId, levelId) {
        exec(null, null, "TalkingDataSDK", "onLevelPass", [profileId, levelId]);
    },
    
    /**
     * 完成新手教程
     * @param {string}  profileId       : 用户账号
     * @param {string}  content         : 教程信息
     */
    onGuideFinished: function(profileId, content) {
        exec(null, null, "TalkingDataSDK", "onGuideFinished", [profileId, content]);
    },
    
    /**
     * 课程学习
     * @param {string}  profileId       : 用户账号
     * @param {string}  course          : 课程信息
     * @param {number}  begin           : 开始时间
     * @param {number}  duration        : 学习时长
     */
    onLearn: function(profileId, course, begin, duration) {
        exec(null, null, "TalkingDataSDK", "onLearn", [profileId, course, begin, duration]);
    },
    
    /**
     * 完成课程试听
     * @param {string}  profileId       : 用户账号
     * @param {string}  content         : 试听信息
     */
    onPreviewFinished: function(profileId, content) {
        exec(null, null, "TalkingDataSDK", "onPreviewFinished", [profileId, content]);
    },
    
    /**
     * 文章阅读
     * @param {string}  profileId       : 用户账号
     * @param {string}  book            : 文章信息
     * @param {number}  begin           : 开始时间
     * @param {number}  duration        : 阅读时长
     */
    onRead: function(profileId, book, begin, duration) {
        exec(null, null, "TalkingDataSDK", "onRead", [profileId, book, begin, duration]);
    },
    
    /**
     * 完成免费阅读
     * @param {string}  profileId       : 用户账号
     * @param {string}  content         : 阅读信息
     */
    onFreeFinished: function(profileId, content) {
        exec(null, null, "TalkingDataSDK", "onFreeFinished", [profileId, content]);
    },
    
    /**
     * 解锁成就
     * @param {string}  profileId       : 用户账号
     * @param {string}  achievementId   : 成就ID
     */
    onAchievementUnlock: function(profileId, achievementId) {
        exec(null, null, "TalkingDataSDK", "onAchievementUnlock", [profileId, achievementId]);
    },
    
    /**
     * 浏览详情
     * @param {string}  profileId       : 用户账号
     * @param {string}  content         : 详情信息
     * @param {number}  begin           : 开始时间
     * @param {number}  duration        : 浏览时长
     */
    onBrowse: function(profileId, content, begin, duration) {
        exec(null, null, "TalkingDataSDK", "onBrowse", [profileId, content, begin, duration]);
    },
    
    /**
     * 完成试用体验
     * @param {string}  profileId       : 用户账号
     * @param {string}  content         : 体验信息
     */
    onTrialFinished: function(profileId, content) {
        exec(null, null, "TalkingDataSDK", "onTrialFinished", [profileId, content]);
    },
    
    /**
     * 触发自定义事件
     * @param {string}  eventId         : 自定义事件的ID
     * @param {number}  eventValue      : 自定义事件的数值
     * @param {object}  eventData       : 自定义事件的数据，Json格式
     */
    onEvent: function(eventId, eventValue, eventData) {
        exec(null, null, "TalkingDataSDK", "onEvent", [eventId, eventValue, eventData]);
    },
    
    /**
     * 添加自定义事件全局参数
     * @param {string}  key             : 参数的key
     * @param {string}  value           : 参数的value，string或number类型
     */
    setGlobalKV: function(key, value) {
        exec(null, null, "TalkingDataSDK", "setGlobalKV", [key, value]);
    },
    
    /**
     * 删除自定义事件全局参数
     * @param {string}  key             : 参数的key
     */
    removeGlobalKV: function(key) {
        exec(null, null, "TalkingDataSDK", "removeGlobalKV", [key]);
    },
};

module.exports = TalkingDataSDK;
