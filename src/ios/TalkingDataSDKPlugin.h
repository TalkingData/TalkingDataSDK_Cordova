#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

#define TD_RETAIL       // 电商零售
#define TD_GAME         // 游戏娱乐
#define TD_FINANCE      // 金融借贷
#define TD_TOUR         // 旅游出行
#define TD_ONLINEEDU    // 在线教育
#define TD_READING      // 小说阅读
#define TD_OTHER        // 其他行业


@interface TalkingDataSDKPlugin : CDVPlugin

- (void)initSDK:(CDVInvokedUrlCommand *)command;
- (void)startA:(CDVInvokedUrlCommand *)command;
- (void)backgroundSessionEnabled:(CDVInvokedUrlCommand *)command;
- (void)getDeviceId:(CDVInvokedUrlCommand *)command;
- (void)getOAID:(CDVInvokedUrlCommand *)command;
- (void)setVerboseLogDisable:(CDVInvokedUrlCommand *)command;
- (void)setConfig:(CDVInvokedUrlCommand *)command;
- (void)setLocation:(CDVInvokedUrlCommand *)command;
- (void)onPage:(CDVInvokedUrlCommand *)command;
- (void)onPageBegin:(CDVInvokedUrlCommand *)command;
- (void)onPageEnd:(CDVInvokedUrlCommand *)command;
- (void)onReceiveDeepLink:(CDVInvokedUrlCommand *)command;
- (void)onRegister:(CDVInvokedUrlCommand *)command;
- (void)onLogin:(CDVInvokedUrlCommand *)command;
- (void)onProfileUpdate:(CDVInvokedUrlCommand *)command;
- (void)onCreateCard:(CDVInvokedUrlCommand *)command;
- (void)onFavorite:(CDVInvokedUrlCommand *)command;
- (void)onShare:(CDVInvokedUrlCommand *)command;
- (void)onPunch:(CDVInvokedUrlCommand *)command;
- (void)onSearch:(CDVInvokedUrlCommand *)command;
#if (defined(TD_RETAIL) || defined(TD_FINANCE) || defined(TD_TOUR) || defined(TD_ONLINEEDU))
- (void)onContact:(CDVInvokedUrlCommand *)command;
#endif
#if (defined(TD_GAME) || defined(TD_TOUR) || defined(TD_ONLINEEDU) || defined(TD_READING) || defined(TD_OTHER))
- (void)onPay:(CDVInvokedUrlCommand *)command;
#endif
#if (defined(TD_RETAIL) || defined(TD_FINANCE) || defined(TD_TOUR) || defined(TD_ONLINEEDU))
- (void)onChargeBack:(CDVInvokedUrlCommand *)command;
#endif
#if (defined(TD_FINANCE) || defined(TD_ONLINEEDU))
- (void)onReservation:(CDVInvokedUrlCommand *)command;
#endif
#if (defined(TD_RETAIL) || defined(TD_TOUR))
- (void)onBooking:(CDVInvokedUrlCommand *)command;
#endif
#ifdef TD_RETAIL
- (void)onViewItem:(CDVInvokedUrlCommand *)command;
- (void)onAddItemToShoppingCart:(CDVInvokedUrlCommand *)command;
- (void)onViewShoppingCart:(CDVInvokedUrlCommand *)command;
- (void)onPlaceOrder:(CDVInvokedUrlCommand *)command;
- (void)onOrderPaySucc:(CDVInvokedUrlCommand *)command;
- (void)onCancelOrder:(CDVInvokedUrlCommand *)command;
#endif
#ifdef TD_FINANCE
- (void)onCredit:(CDVInvokedUrlCommand *)command;
- (void)onTransaction:(CDVInvokedUrlCommand *)command;
#endif
#ifdef TD_GAME
- (void)onCreateRole:(CDVInvokedUrlCommand *)command;
- (void)onLevelPass:(CDVInvokedUrlCommand *)command;
- (void)onGuideFinished:(CDVInvokedUrlCommand *)command;
#endif
#ifdef TD_ONLINEEDU
- (void)onLearn:(CDVInvokedUrlCommand *)command;
- (void)onPreviewFinished:(CDVInvokedUrlCommand *)command;
#endif
#ifdef TD_READING
- (void)onRead:(CDVInvokedUrlCommand *)command;
- (void)onFreeFinished:(CDVInvokedUrlCommand *)command;
#endif
#if (defined(TD_GAME) || defined(TD_ONLINEEDU))
- (void)onAchievementUnlock:(CDVInvokedUrlCommand *)command;
#endif
#if (defined(TD_FINANCE) || defined(TD_TOUR) || defined(TD_OTHER))
- (void)onBrowse:(CDVInvokedUrlCommand *)command;
#endif
#if (defined(TD_RETAIL) || defined(TD_FINANCE) || defined(TD_TOUR) || defined(TD_OTHER))
- (void)onTrialFinished:(CDVInvokedUrlCommand *)command;
#endif
- (void)onEvent:(CDVInvokedUrlCommand *)command;
- (void)setGlobalKV:(CDVInvokedUrlCommand *)command;
- (void)removeGlobalKV:(CDVInvokedUrlCommand *)command;

@end
