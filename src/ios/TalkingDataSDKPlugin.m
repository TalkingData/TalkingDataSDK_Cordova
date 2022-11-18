#import "TalkingDataSDKPlugin.h"
#import "TalkingDataSDK.h"


@interface TalkingDataSDKPlugin ()

@property (nonatomic, strong) NSString *currencyPageName;

@end


@implementation TalkingDataSDKPlugin

+ (void)initialize {
    if (self == [TalkingDataSDKPlugin class]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([TalkingDataSDK respondsToSelector:@selector(setFrameworkTag:)]) {
            [TalkingDataSDK performSelector:@selector(setFrameworkTag:) withObject:@4];
        }
#pragma clang diagnostic pop
    }
}

- (void)init:(CDVInvokedUrlCommand *)command {
    NSString *appId = [command.arguments objectAtIndex:0];
    if (![appId isKindOfClass:[NSString class]]) {
        appId = nil;
    }
    NSString *channelId = [command.arguments objectAtIndex:1];
    if (![channelId isKindOfClass:[NSString class]]) {
        channelId = nil;
    }
    NSString *custom = [command.arguments objectAtIndex:2];
    if (![custom isKindOfClass:[NSString class]]) {
        custom = nil;
    }
    [TalkingDataSDK init:appId channelId:channelId custom:custom];
}

- (void)backgroundSessionEnabled:(CDVInvokedUrlCommand *)command {
    [TalkingDataSDK backgroundSessionEnabled];
}

- (void)getDeviceId:(CDVInvokedUrlCommand *)command {
    NSString *deviceId = [TalkingDataSDK getDeviceId];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:deviceId];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getOAID:(CDVInvokedUrlCommand *)command {
}

- (void)setVerboseLogDisable:(CDVInvokedUrlCommand *)command {
    [TalkingDataSDK setVerboseLogDisable];
}

- (void)setLocation:(CDVInvokedUrlCommand *)command {
    double latitude = 0.0;
    NSNumber *latitudeNum = [command.arguments objectAtIndex:0];
    if ([latitudeNum isKindOfClass:[NSNumber class]]) {
        latitude = [latitudeNum doubleValue];
    }
    double longitude = 0.0;
    NSNumber *longitudeNum = [command.arguments objectAtIndex:1];
    if ([longitudeNum isKindOfClass:[NSNumber class]]) {
        longitude = [longitudeNum doubleValue];
    }
    [TalkingDataSDK setLatitude:latitude longitude:longitude];
}

- (void)onPage:(CDVInvokedUrlCommand *)command {
    NSString *pageName = [command.arguments objectAtIndex:0];
    if (![pageName isKindOfClass:[NSString class]]) {
        pageName = nil;
    }
    if (self.currencyPageName) {
        [TalkingDataSDK onPageEnd:self.currencyPageName];
    }
    self.currencyPageName = pageName;
    [TalkingDataSDK onPageBegin:pageName];
}

- (void)onPageBegin:(CDVInvokedUrlCommand *)command {
    NSString *pageName = [command.arguments objectAtIndex:0];
    if (![pageName isKindOfClass:[NSString class]]) {
        pageName = nil;
    }
    self.currencyPageName = pageName;
    [TalkingDataSDK onPageBegin:pageName];
}

- (void)onPageEnd:(CDVInvokedUrlCommand *)command {
    NSString *pageName = [command.arguments objectAtIndex:0];
    if (![pageName isKindOfClass:[NSString class]]) {
        pageName = nil;
    }
    self.currencyPageName = nil;
    [TalkingDataSDK onPageEnd:pageName];
}

- (void)onReceiveDeepLink:(CDVInvokedUrlCommand *)command {
    NSURL *url = nil;
    NSString *urlStr = [command.arguments objectAtIndex:0];
    if ([urlStr isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:urlStr];
    }
    [TalkingDataSDK onReceiveDeepLink:url];
}

- (void)onRegister:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    NSString *profileJson = [command.arguments objectAtIndex:1];
    TalkingDataProfile *profile = [self profileFromJsonString:profileJson];
    NSString *invitationCode = [command.arguments objectAtIndex:2];
    if (![invitationCode isKindOfClass:[NSString class]]) {
        invitationCode = nil;
    }
    [TalkingDataSDK onRegister:profileId profile:profile invitationCode:invitationCode];
}

- (void)onLogin:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    NSString *profileJson = [command.arguments objectAtIndex:1];
    TalkingDataProfile *profile = [self profileFromJsonString:profileJson];
    [TalkingDataSDK onLogin:profileId profile:profile];
}

- (void)onProfileUpdate:(CDVInvokedUrlCommand *)command {
    NSString *profileJson = [command.arguments objectAtIndex:0];
    TalkingDataProfile *profile = [self profileFromJsonString:profileJson];
    [TalkingDataSDK onProfileUpdate:profile];
}

- (void)onCreateCard:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    NSString *method = [command.arguments objectAtIndex:1];
    if (![method isKindOfClass:[NSString class]]) {
        method = nil;
    }
    NSString *content = [command.arguments objectAtIndex:2];
    if (![content isKindOfClass:[NSString class]]) {
        content = nil;
    }
    [TalkingDataSDK onCreateCard:profileId method:method content:content];
}

- (void)onFavorite:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    NSString *content = [command.arguments objectAtIndex:1];
    if (![content isKindOfClass:[NSString class]]) {
        content = nil;
    }
    [TalkingDataSDK onFavorite:profileId content:content];
}

- (void)onShare:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    NSString *content = [command.arguments objectAtIndex:1];
    if (![content isKindOfClass:[NSString class]]) {
        content = nil;
    }
    [TalkingDataSDK onShare:profileId content:content];
}

- (void)onPunch:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    NSString *punchId = [command.arguments objectAtIndex:1];
    if (![punchId isKindOfClass:[NSString class]]) {
        punchId = nil;
    }
    [TalkingDataSDK onPunch:profileId punchId:punchId];
}

- (void)onSearch:(CDVInvokedUrlCommand *)command {
    NSString *searchJson = [command.arguments objectAtIndex:0];
    TalkingDataSearch *search = [self searchFromJsonString:searchJson];
    [TalkingDataSDK onSearch:search];
}

#if (defined(TD_RETAIL) || defined(TD_FINANCE) || defined(TD_TOUR) || defined(TD_ONLINEEDU))
- (void)onContact:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    NSString *content = [command.arguments objectAtIndex:1];
    if (![content isKindOfClass:[NSString class]]) {
        content = nil;
    }
    [TalkingDataSDK onContact:profileId content:content];
}
#endif

#if (defined(TD_GAME) || defined(TD_TOUR) || defined(TD_ONLINEEDU) || defined(TD_READING) || defined(TD_OTHER))
- (void)onPay:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    NSString *orderId = [command.arguments objectAtIndex:1];
    if (![orderId isKindOfClass:[NSString class]]) {
        orderId = nil;
    }
    int amount = 0;
    NSNumber *amountNum = [command.arguments objectAtIndex:2];
    if ([amountNum isKindOfClass:[NSNumber class]]) {
        amount = [amountNum intValue];
    }
    NSString *currencyType = [command.arguments objectAtIndex:3];
    if (![currencyType isKindOfClass:[NSString class]]) {
        currencyType = nil;
    }
    NSString *paymentType = [command.arguments objectAtIndex:4];
    if (![paymentType isKindOfClass:[NSString class]]) {
        paymentType = nil;
    }
    NSString *itemId = [command.arguments objectAtIndex:5];
    if (![itemId isKindOfClass:[NSString class]]) {
        itemId = nil;
    }
    int itemCount = 0;
    NSNumber *itemCountNum = [command.arguments objectAtIndex:6];
    if ([itemCountNum isKindOfClass:[NSNumber class]]) {
        itemCount = [itemCountNum intValue];
    }
    [TalkingDataSDK onPay:profileId orderId:orderId amount:amount currencyType:currencyType paymentType:paymentType itemId:itemId itemCount:itemCount];
}
#endif

#if (defined(TD_RETAIL) || defined(TD_FINANCE) || defined(TD_TOUR) || defined(TD_ONLINEEDU))
- (void)onChargeBack:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    NSString *orderId = [command.arguments objectAtIndex:1];
    if (![orderId isKindOfClass:[NSString class]]) {
        orderId = nil;
    }
    NSString *reason = [command.arguments objectAtIndex:2];
    if (![reason isKindOfClass:[NSString class]]) {
        reason = nil;
    }
    NSString *type = [command.arguments objectAtIndex:3];
    if (![type isKindOfClass:[NSString class]]) {
        type = nil;
    }
    [TalkingDataSDK onChargeBack:profileId orderId:orderId reason:reason type:type];
}
#endif

#if (defined(TD_FINANCE) || defined(TD_ONLINEEDU))
- (void)onReservation:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    NSString *reservationId = [command.arguments objectAtIndex:1];
    if (![reservationId isKindOfClass:[NSString class]]) {
        reservationId = nil;
    }
    NSString *category = [command.arguments objectAtIndex:2];
    if (![category isKindOfClass:[NSString class]]) {
        category = nil;
    }
    int amount = 0;
    NSNumber *amountNum = [command.arguments objectAtIndex:3];
    if ([amountNum isKindOfClass:[NSNumber class]]) {
        amount = [amountNum intValue];
    }
    NSString *term = [command.arguments objectAtIndex:4];
    if (![term isKindOfClass:[NSString class]]) {
        term = nil;
    }
    [TalkingDataSDK onReservation:profileId reservationId:reservationId category:category amount:amount term:term];
}
#endif

#if (defined(TD_RETAIL) || defined(TD_TOUR))
- (void)onBooking:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    NSString *bookingId = [command.arguments objectAtIndex:1];
    if (![bookingId isKindOfClass:[NSString class]]) {
        bookingId = nil;
    }
    NSString *category = [command.arguments objectAtIndex:2];
    if (![category isKindOfClass:[NSString class]]) {
        category = nil;
    }
    int amount = 0;
    NSNumber *amountNum = [command.arguments objectAtIndex:3];
    if ([amountNum isKindOfClass:[NSNumber class]]) {
        amount = [amountNum intValue];
    }
    NSString *content = [command.arguments objectAtIndex:4];
    if (![content isKindOfClass:[NSString class]]) {
        content = nil;
    }
    [TalkingDataSDK onBooking:profileId bookingId:bookingId category:category amount:amount content:content];
}
#endif

#ifdef TD_RETAIL
- (void)onViewItem:(CDVInvokedUrlCommand *)command {
    NSString *itemId = [command.arguments objectAtIndex:0];
    if (![itemId isKindOfClass:[NSString class]]) {
        itemId = nil;
    }
    NSString *category = [command.arguments objectAtIndex:1];
    if (![category isKindOfClass:[NSString class]]) {
        category = nil;
    }
    NSString *name = [command.arguments objectAtIndex:2];
    if (![name isKindOfClass:[NSString class]]) {
        name = nil;
    }
    int unitPrice = 0;
    NSNumber *unitPriceNum = [command.arguments objectAtIndex:3];
    if ([unitPriceNum isKindOfClass:[NSNumber class]]) {
        unitPrice = [unitPriceNum intValue];
    }
    [TalkingDataSDK onViewItem:itemId category:category name:name unitPrice:unitPrice];
}

- (void)onAddItemToShoppingCart:(CDVInvokedUrlCommand *)command {
    NSString *itemId = [command.arguments objectAtIndex:0];
    if (![itemId isKindOfClass:[NSString class]]) {
        itemId = nil;
    }
    NSString *category = [command.arguments objectAtIndex:1];
    if (![category isKindOfClass:[NSString class]]) {
        category = nil;
    }
    NSString *name = [command.arguments objectAtIndex:2];
    if (![name isKindOfClass:[NSString class]]) {
        name = nil;
    }
    int unitPrice = 0;
    NSNumber *unitPriceNum = [command.arguments objectAtIndex:3];
    if ([unitPriceNum isKindOfClass:[NSNumber class]]) {
        unitPrice = [unitPriceNum intValue];
    }
    int amount = 0;
    NSNumber *amountNum = [command.arguments objectAtIndex:4];
    if ([amountNum isKindOfClass:[NSNumber class]]) {
        amount = [amountNum intValue];
    }
    [TalkingDataSDK onAddItemToShoppingCart:itemId category:category name:name unitPrice:unitPrice amount:amount];
}

- (void)onViewShoppingCart:(CDVInvokedUrlCommand *)command {
    NSString *shoppingCartJson = [command.arguments objectAtIndex:0];
    TalkingDataShoppingCart *shoppingCart = [self shoppingCartFromJsonString:shoppingCartJson];
    [TalkingDataSDK onViewShoppingCart:shoppingCart];
}

- (void)onPlaceOrder:(CDVInvokedUrlCommand *)command {
    NSString *orderJson = [command.arguments objectAtIndex:0];
    TalkingDataOrder *order = [self orderFormJsonString:orderJson];
    NSString *profileId = [command.arguments objectAtIndex:1];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    [TalkingDataSDK onPlaceOrder:order profileId:profileId];
}

- (void)onOrderPaySucc:(CDVInvokedUrlCommand *)command {
    NSString *orderJson = [command.arguments objectAtIndex:0];
    TalkingDataOrder *order = [self orderFormJsonString:orderJson];
    NSString *paymentType = [command.arguments objectAtIndex:1];
    if (![paymentType isKindOfClass:[NSString class]]) {
        paymentType = nil;
    }
    NSString *profileId = [command.arguments objectAtIndex:2];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    [TalkingDataSDK onOrderPaySucc:order paymentType:paymentType profileId:profileId];
}

- (void)onCancelOrder:(CDVInvokedUrlCommand *)command {
    NSString *orderJson = [command.arguments objectAtIndex:0];
    TalkingDataOrder *order = [self orderFormJsonString:orderJson];
    [TalkingDataSDK onCancelOrder:order];
}
#endif

#ifdef TD_FINANCE
- (void)onCredit:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    int amount = 0;
    NSNumber *amountNum = [command.arguments objectAtIndex:1];
    if ([amountNum isKindOfClass:[NSNumber class]]) {
        amount = [amountNum intValue];
    }
    NSString *content = [command.arguments objectAtIndex:2];
    if (![content isKindOfClass:[NSString class]]) {
        content = nil;
    }
    [TalkingDataSDK onCredit:profileId amount:amount content:content];
}

- (void)onTransaction:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    NSString *transactionJson = [command.arguments objectAtIndex:1];
    TalkingDataTransaction *transaction = [self transactionFormJsonString:transactionJson];
    [TalkingDataSDK onTransaction:profileId transaction:transaction];
}
#endif

#ifdef TD_GAME
- (void)onCreateRole:(CDVInvokedUrlCommand *)command {
    NSString *roleName = [command.arguments objectAtIndex:0];
    if (![roleName isKindOfClass:[NSString class]]) {
        roleName = nil;
    }
    [TalkingDataSDK onCreateRole:roleName];
}

- (void)onLevelPass:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    NSString *levelId = [command.arguments objectAtIndex:1];
    if (![levelId isKindOfClass:[NSString class]]) {
        levelId = nil;
    }
    [TalkingDataSDK onLevelPass:profileId levelId:levelId];
}

- (void)onGuideFinished:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    NSString *content = [command.arguments objectAtIndex:1];
    if (![content isKindOfClass:[NSString class]]) {
        content = nil;
    }
    [TalkingDataSDK onGuideFinished:profileId content:content];
}
#endif

#ifdef TD_ONLINEEDU
- (void)onLearn:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    NSString *course = [command.arguments objectAtIndex:1];
    if (![course isKindOfClass:[NSString class]]) {
        course = nil;
    }
    int64_t begin = 0;
    NSNumber *beginNum = [command.arguments objectAtIndex:2];
    if ([beginNum isKindOfClass:[NSNumber class]]) {
        begin = [beginNum longLongValue];
    }
    int duration = 0;
    NSNumber *durationNum = [command.arguments objectAtIndex:3];
    if ([durationNum isKindOfClass:[NSNumber class]]) {
        duration = [durationNum intValue];
    }
    [TalkingDataSDK onLearn:profileId course:course begin:begin duration:duration];
}

- (void)onPreviewFinished:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    NSString *content = [command.arguments objectAtIndex:1];
    if (![content isKindOfClass:[NSString class]]) {
        content = nil;
    }
    [TalkingDataSDK onPreviewFinished:profileId content:content];
}
#endif

#ifdef TD_READING
- (void)onRead:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    NSString *book = [command.arguments objectAtIndex:1];
    if (![book isKindOfClass:[NSString class]]) {
        book = nil;
    }
    int64_t begin = 0;
    NSNumber *beginNum = [command.arguments objectAtIndex:2];
    if ([beginNum isKindOfClass:[NSNumber class]]) {
        begin = [beginNum longLongValue];
    }
    int duration = 0;
    NSNumber *durationNum = [command.arguments objectAtIndex:3];
    if ([durationNum isKindOfClass:[NSNumber class]]) {
        duration = [durationNum intValue];
    }
    [TalkingDataSDK onRead:profileId book:book begin:begin duration:duration];
}

- (void)onFreeFinished:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    NSString *content = [command.arguments objectAtIndex:1];
    if (![content isKindOfClass:[NSString class]]) {
        content = nil;
    }
    [TalkingDataSDK onFreeFinished:profileId content:content];
}
#endif

#if (defined(TD_GAME) || defined(TD_ONLINEEDU))
- (void)onAchievementUnlock:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    NSString *achievementId = [command.arguments objectAtIndex:1];
    if (![achievementId isKindOfClass:[NSString class]]) {
        achievementId = nil;
    }
    [TalkingDataSDK onAchievementUnlock:profileId achievementId:achievementId];
}
#endif

#if (defined(TD_FINANCE) || defined(TD_TOUR) || defined(TD_OTHER))
- (void)onBrowse:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    NSString *content = [command.arguments objectAtIndex:1];
    if (![content isKindOfClass:[NSString class]]) {
        content = nil;
    }
    int64_t begin = 0;
    NSNumber *beginNum = [command.arguments objectAtIndex:2];
    if ([beginNum isKindOfClass:[NSNumber class]]) {
        begin = [beginNum longLongValue];
    }
    int duration = 0;
    NSNumber *durationNum = [command.arguments objectAtIndex:3];
    if ([durationNum isKindOfClass:[NSNumber class]]) {
        duration = [durationNum intValue];
    }
    [TalkingDataSDK onBrowse:profileId content:content begin:begin duration:duration];
}
#endif

#if (defined(TD_RETAIL) || defined(TD_FINANCE) || defined(TD_TOUR) || defined(TD_OTHER))
- (void)onTrialFinished:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    if (![profileId isKindOfClass:[NSString class]]) {
        profileId = nil;
    }
    NSString *content = [command.arguments objectAtIndex:1];
    if (![content isKindOfClass:[NSString class]]) {
        content = nil;
    }
    [TalkingDataSDK onTrialFinished:profileId content:content];
}
#endif

- (void)onEvent:(CDVInvokedUrlCommand *)command {
    NSString *eventId = [command.arguments objectAtIndex:0];
    if (![eventId isKindOfClass:[NSString class]]) {
        eventId = nil;
    }
    NSDictionary *eventData = [command.arguments objectAtIndex:1];
    if (![eventData isKindOfClass:[NSDictionary class]]) {
        eventData = nil;
    }
    [TalkingDataSDK onEvent:eventId parameters:eventData];
}

- (void)setGlobalKV:(CDVInvokedUrlCommand *)command {
    NSString *key = [command.arguments objectAtIndex:0];
    if (![key isKindOfClass:[NSString class]]) {
        key = nil;
    }
    id value = [command.arguments objectAtIndex:1];
    if (![value isKindOfClass:[NSString class]] && ![value isKindOfClass:[NSNumber class]]) {
        value = nil;
    }
    [TalkingDataSDK setGlobalKV:key value:value];
}

- (void)removeGlobalKV:(CDVInvokedUrlCommand *)command {
    NSString *key = [command.arguments objectAtIndex:0];
    if (![key isKindOfClass:[NSString class]]) {
        key = nil;
    }
    [TalkingDataSDK removeGlobalKV:key];
}

- (NSDictionary *)dictionaryFromJsonString:(NSString *)json {
    if (![json isKindOfClass:[NSString class]]) {
        return nil;
    }
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    if (error || ![object isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return object;
}

- (TalkingDataProfile *)profileFromJsonString:(NSString *)json {
    NSDictionary *profileDic = [self dictionaryFromJsonString:json];
    if (profileDic == nil) {
        return nil;
    }
    TalkingDataProfile *profile = [TalkingDataProfile createProfile];
    NSString *name = [profileDic objectForKey:@"name"];
    if ([name isKindOfClass:[NSString class]]) {
        profile.name = name;
    }
    NSNumber *type = [profileDic objectForKey:@"type"];
    if ([type isKindOfClass:[NSNumber class]]) {
        profile.type = [type unsignedIntegerValue];
    }
    NSNumber *gender = [profileDic objectForKey:@"gender"];
    if ([gender isKindOfClass:[NSNumber class]]) {
        profile.gender = [gender unsignedIntegerValue];
    }
    NSNumber *age = [profileDic objectForKey:@"age"];
    if ([age isKindOfClass:[NSNumber class]]) {
        profile.age = [age intValue];
    }
    id property1 = [profileDic objectForKey:@"property1"];
    if ([property1 isKindOfClass:[NSString class]] || [property1 isKindOfClass:[NSNumber class]]) {
        profile.property1 = property1;
    }
    id property2 = [profileDic objectForKey:@"property2"];
    if ([property2 isKindOfClass:[NSString class]] || [property2 isKindOfClass:[NSNumber class]]) {
        profile.property2 = property2;
    }
    id property3 = [profileDic objectForKey:@"property3"];
    if ([property3 isKindOfClass:[NSString class]] || [property3 isKindOfClass:[NSNumber class]]) {
        profile.property3 = property3;
    }
    id property4 = [profileDic objectForKey:@"property4"];
    if ([property4 isKindOfClass:[NSString class]] || [property4 isKindOfClass:[NSNumber class]]) {
        profile.property4 = property4;
    }
    id property5 = [profileDic objectForKey:@"property5"];
    if ([property5 isKindOfClass:[NSString class]] || [property5 isKindOfClass:[NSNumber class]]) {
        profile.property5 = property5;
    }
    id property6 = [profileDic objectForKey:@"property6"];
    if ([property6 isKindOfClass:[NSString class]] || [property6 isKindOfClass:[NSNumber class]]) {
        profile.property6 = property6;
    }
    id property7 = [profileDic objectForKey:@"property7"];
    if ([property7 isKindOfClass:[NSString class]] || [property7 isKindOfClass:[NSNumber class]]) {
        profile.property7 = property7;
    }
    id property8 = [profileDic objectForKey:@"property8"];
    if ([property8 isKindOfClass:[NSString class]] || [property8 isKindOfClass:[NSNumber class]]) {
        profile.property8 = property8;
    }
    id property9 = [profileDic objectForKey:@"property9"];
    if ([property9 isKindOfClass:[NSString class]] || [property9 isKindOfClass:[NSNumber class]]) {
        profile.property9 = property9;
    }
    id property10 = [profileDic objectForKey:@"property10"];
    if ([property10 isKindOfClass:[NSString class]] || [property10 isKindOfClass:[NSNumber class]]) {
        profile.property10 = property10;
    }
    return profile;
}

- (TalkingDataSearch *)searchFromJsonString:(NSString *)json {
    NSDictionary *searchDic = [self dictionaryFromJsonString:json];
    if (searchDic == nil) {
        return nil;
    }
    TalkingDataSearch *search = [TalkingDataSearch createSearch];
    NSString *category = [searchDic objectForKey:@"category"];
    if ([category isKindOfClass:[NSString class]]) {
        search.category = category;
    }
    NSString *content = [searchDic objectForKey:@"content"];
    if ([content isKindOfClass:[NSString class]]) {
        search.content = content;
    }
#ifdef TD_RETAIL
    NSString *itemId = [searchDic objectForKey:@"itemId"];
    if ([itemId isKindOfClass:[NSString class]]) {
        search.itemId = itemId;
    }
    NSString *itemLocationId = [searchDic objectForKey:@"itemLocationId"];
    if ([itemLocationId isKindOfClass:[NSString class]]) {
        search.itemLocationId = itemLocationId;
    }
#endif
#ifdef TD_TOUR
    NSString *destination = [searchDic objectForKey:@"destination"];
    if ([destination isKindOfClass:[NSString class]]) {
        search.destination = destination;
    }
    NSString *origin = [searchDic objectForKey:@"origin"];
    if ([origin isKindOfClass:[NSString class]]) {
        search.origin = origin;
    }
    NSNumber *startDate = [searchDic objectForKey:@"startDate"];
    if ([startDate isKindOfClass:[NSNumber class]]) {
        search.startDate = [startDate longLongValue];
    }
    NSNumber *endDate = [searchDic objectForKey:@"endDate"];
    if ([endDate isKindOfClass:[NSNumber class]]) {
        search.endDate = [endDate longLongValue];
    }
#endif
    return search;
}

#ifdef TD_RETAIL
- (TalkingDataShoppingCart *)shoppingCartFromJsonString:(NSString *)json {
    NSDictionary *shoppingCartDic = [self dictionaryFromJsonString:json];
    if (shoppingCartDic == nil) {
        return nil;
    }
    TalkingDataShoppingCart *shoppingCart = [TalkingDataShoppingCart createShoppingCart];
    NSArray *items = shoppingCartDic[@"items"];
    for (NSDictionary *item in items) {
        NSString *itemId = [item objectForKey:@"itemId"];
        if (![itemId isKindOfClass:[NSString class]]) {
            itemId = nil;
        }
        NSString *category = [item objectForKey:@"category"];
        if (![category isKindOfClass:[NSString class]]) {
            category = nil;
        }
        NSString *name = [item objectForKey:@"name"];
        if (![name isKindOfClass:[NSString class]]) {
            name = nil;
        }
        int unitPrice = 0;
        NSNumber *unitPriceNum = [item objectForKey:@"unitPrice"];
        if ([unitPriceNum isKindOfClass:[NSNumber class]]) {
            unitPrice = [unitPriceNum intValue];
        }
        int amount = 0;
        NSNumber *amountNum = [item objectForKey:@"amount"];
        if ([amountNum isKindOfClass:[NSNumber class]]) {
            amount = [amountNum intValue];
        }
        [shoppingCart addItem:itemId category:category name:name unitPrice:unitPrice amount:amount];
    }
    return shoppingCart;
}

- (TalkingDataOrder *)orderFormJsonString:(NSString *)json {
    NSDictionary *orderDic = [self dictionaryFromJsonString:json];
    if (orderDic == nil) {
        return nil;
    }
    NSString *orderId = [orderDic objectForKey:@"orderId"];
    if (![orderId isKindOfClass:[NSString class]]) {
        orderId = nil;
    }
    int total = 0;
    NSNumber *totalNum = [orderDic objectForKey:@"total"];
    if ([totalNum isKindOfClass:[NSNumber class]]) {
        total = [totalNum intValue];
    }
    NSString *currencyType = [orderDic objectForKey:@"currencyType"];
    if (![currencyType isKindOfClass:[NSString class]]) {
        currencyType = nil;
    }
    TalkingDataOrder *order = [TalkingDataOrder createOrder:orderId total:total currencyType:currencyType];
    NSArray *items = orderDic[@"items"];
    if ([items isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in items) {
            NSString *itemId = [item objectForKey:@"itemId"];
            if (![itemId isKindOfClass:[NSString class]]) {
                itemId = nil;
            }
            NSString *category = [item objectForKey:@"category"];
            if (![category isKindOfClass:[NSString class]]) {
                category = nil;
            }
            NSString *name = [item objectForKey:@"name"];
            if (![name isKindOfClass:[NSString class]]) {
                name = nil;
            }
            int unitPrice = 0;
            NSNumber *unitPriceNum = [item objectForKey:@"unitPrice"];
            if ([unitPriceNum isKindOfClass:[NSNumber class]]) {
                unitPrice = [unitPriceNum intValue];
            }
            int amount = 0;
            NSNumber *amountNum = [item objectForKey:@"amount"];
            if ([amountNum isKindOfClass:[NSNumber class]]) {
                amount = [amountNum intValue];
            }
            [order addItem:itemId category:category name:name unitPrice:unitPrice amount:amount];
        }
    }
    return order;
}
#endif

#ifdef TD_FINANCE
- (TalkingDataTransaction *)transactionFormJsonString:(NSString *)json {
    NSDictionary *transactionDic = [self dictionaryFromJsonString:json];
    if (transactionDic == nil) {
        return nil;
    }
    TalkingDataTransaction *transaction = [TalkingDataTransaction createTransaction];
    NSString *transactionId = [transactionDic objectForKey:@"transactionId"];
    if ([transactionId isKindOfClass:[NSString class]]) {
        transaction.transactionId = transactionId;
    }
    NSString *category = [transactionDic objectForKey:@"category"];
    if ([category isKindOfClass:[NSString class]]) {
        transaction.category = category;
    }
    NSNumber *amount = [transactionDic objectForKey:@"amount"];
    if ([amount isKindOfClass:[NSNumber class]]) {
        transaction.amount = [amount intValue];
    }
    NSString *personA = [transactionDic objectForKey:@"personA"];
    if ([personA isKindOfClass:[NSString class]]) {
        transaction.personA = personA;
    }
    NSString *personB = [transactionDic objectForKey:@"personB"];
    if ([personB isKindOfClass:[NSString class]]) {
        transaction.personB = personB;
    }
    NSNumber *startDate = [transactionDic objectForKey:@"startDate"];
    if ([startDate isKindOfClass:[NSNumber class]]) {
        transaction.startDate = [startDate longLongValue];
    }
    NSNumber *endDate = [transactionDic objectForKey:@"endDate"];
    if ([endDate isKindOfClass:[NSNumber class]]) {
        transaction.endDate = [endDate longLongValue];
    }
    NSString *content = [transactionDic objectForKey:@"content"];
    if ([content isKindOfClass:[NSString class]]) {
        transaction.content = content;
    }
    NSString *currencyType = [transactionDic objectForKey:@"currencyType"];
    if ([currencyType isKindOfClass:[NSString class]]) {
        transaction.currencyType = currencyType;
    }
    return transaction;
}
#endif

@end
