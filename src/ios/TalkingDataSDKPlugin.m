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

- (void)initSDK:(CDVInvokedUrlCommand *)command {
    NSString *appId = [command.arguments objectAtIndex:0];
    NSString *channelId = [command.arguments objectAtIndex:1];
    NSString *custom = [command.arguments objectAtIndex:2];
    [TalkingDataSDK initSDK:appId channelId:channelId custom:custom];
}

- (void)startA:(CDVInvokedUrlCommand *) {
    [TalkingDataSDK startA];
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

- (void)setConfig:(CDVInvokedUrlCommand *)command {
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
    if (self.currencyPageName) {
        [TalkingDataSDK onPageEnd:self.currencyPageName];
    }
    self.currencyPageName = pageName;
    [TalkingDataSDK onPageBegin:pageName];
}

- (void)onPageBegin:(CDVInvokedUrlCommand *)command {
    NSString *pageName = [command.arguments objectAtIndex:0];
    self.currencyPageName = pageName;
    [TalkingDataSDK onPageBegin:pageName];
}

- (void)onPageEnd:(CDVInvokedUrlCommand *)command {
    NSString *pageName = [command.arguments objectAtIndex:0];
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
    NSString *profileJson = [command.arguments objectAtIndex:1];
    TalkingDataProfile *profile = [self profileFromJsonString:profileJson];
    NSString *invitationCode = [command.arguments objectAtIndex:2];
    NSDictionary *eventValue = [command.arguments objectAtIndex:3];
    [TalkingDataSDK onRegister:profileId profile:profile invitationCode:invitationCode eventValue:eventValue];
}

- (void)onLogin:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    NSString *profileJson = [command.arguments objectAtIndex:1];
    TalkingDataProfile *profile = [self profileFromJsonString:profileJson];
    NSDictionary *eventValue = [command.arguments objectAtIndex:2];
    [TalkingDataSDK onLogin:profileId profile:profile eventValue:eventValue];
}

- (void)onProfileUpdate:(CDVInvokedUrlCommand *)command {
    NSString *profileJson = [command.arguments objectAtIndex:0];
    TalkingDataProfile *profile = [self profileFromJsonString:profileJson];
    [TalkingDataSDK onProfileUpdate:profile];
}

- (void)onCreateCard:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    NSString *method = [command.arguments objectAtIndex:1];
    NSString *content = [command.arguments objectAtIndex:2];
    [TalkingDataSDK onCreateCard:profileId method:method content:content];
}

- (void)onFavorite:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    NSString *content = [command.arguments objectAtIndex:1];
    NSDictionary *eventValue = [command.arguments objectAtIndex:2];
    [TalkingDataSDK onFavorite:profileId content:content, eventValue:eventValue];
}

- (void)onShare:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    NSString *content = [command.arguments objectAtIndex:1];
    NSDictionary *eventValue = [command.arguments objectAtIndex:2];
    [TalkingDataSDK onShare:profileId content:content eventValue:eventValue];
}

- (void)onPunch:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    NSString *punchId = [command.arguments objectAtIndex:1];
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
    NSString *content = [command.arguments objectAtIndex:1];
    [TalkingDataSDK onContact:profileId content:content];
}
#endif

#if (defined(TD_GAME) || defined(TD_TOUR) || defined(TD_ONLINEEDU) || defined(TD_READING) || defined(TD_OTHER))
- (void)onPay:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    NSString *orderId = [command.arguments objectAtIndex:1];
    int amount = 0;
    NSNumber *amountNum = [command.arguments objectAtIndex:2];
    if ([amountNum isKindOfClass:[NSNumber class]]) {
        amount = [amountNum intValue];
    }
    NSString *currencyType = [command.arguments objectAtIndex:3];
    NSString *paymentType = [command.arguments objectAtIndex:4];
    NSString *itemId = [command.arguments objectAtIndex:5];
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
    NSString *orderId = [command.arguments objectAtIndex:1];
    NSString *reason = [command.arguments objectAtIndex:2];
    NSString *type = [command.arguments objectAtIndex:3];
    [TalkingDataSDK onChargeBack:profileId orderId:orderId reason:reason type:type];
}
#endif

#if (defined(TD_FINANCE) || defined(TD_ONLINEEDU))
- (void)onReservation:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    NSString *reservationId = [command.arguments objectAtIndex:1];
    NSString *category = [command.arguments objectAtIndex:2];
    int amount = 0;
    NSNumber *amountNum = [command.arguments objectAtIndex:3];
    if ([amountNum isKindOfClass:[NSNumber class]]) {
        amount = [amountNum intValue];
    }
    NSString *term = [command.arguments objectAtIndex:4];
    [TalkingDataSDK onReservation:profileId reservationId:reservationId category:category amount:amount term:term];
}
#endif

#if (defined(TD_RETAIL) || defined(TD_TOUR))
- (void)onBooking:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    NSString *bookingId = [command.arguments objectAtIndex:1];
    NSString *category = [command.arguments objectAtIndex:2];
    int amount = 0;
    NSNumber *amountNum = [command.arguments objectAtIndex:3];
    if ([amountNum isKindOfClass:[NSNumber class]]) {
        amount = [amountNum intValue];
    }
    NSString *content = [command.arguments objectAtIndex:4];
    [TalkingDataSDK onBooking:profileId bookingId:bookingId category:category amount:amount content:content];
}
#endif

#ifdef TD_RETAIL
- (void)onViewItem:(CDVInvokedUrlCommand *)command {
    NSString *itemId = [command.arguments objectAtIndex:0];
    NSString *category = [command.arguments objectAtIndex:1];
    NSString *name = [command.arguments objectAtIndex:2];
    int unitPrice = 0;
    NSNumber *unitPriceNum = [command.arguments objectAtIndex:3];
    if ([unitPriceNum isKindOfClass:[NSNumber class]]) {
        unitPrice = [unitPriceNum intValue];
    }
    NSDictionary *eventValue = [command.arguments objectAtIndex:4];
    [TalkingDataSDK onViewItem:itemId category:category name:name unitPrice:unitPrice eventValue:eventValue];
}

- (void)onAddItemToShoppingCart:(CDVInvokedUrlCommand *)command {
    NSString *itemId = [command.arguments objectAtIndex:0];
    NSString *category = [command.arguments objectAtIndex:1];
    NSString *name = [command.arguments objectAtIndex:2];
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
    NSDictionary *eventValue = [command.arguments objectAtIndex:5];
    [TalkingDataSDK onAddItemToShoppingCart:itemId category:category name:name unitPrice:unitPrice amount:amount eventValue:eventValue];
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
    NSDictionary *eventValue = [command.arguments objectAtIndex:2];
    [TalkingDataSDK onPlaceOrder:order profileId:profileId eventValue:eventValue];
}

- (void)onOrderPaySucc:(CDVInvokedUrlCommand *)command {
    NSString *orderJson = [command.arguments objectAtIndex:0];
    TalkingDataOrder *order = [self orderFormJsonString:orderJson];
    NSString *paymentType = [command.arguments objectAtIndex:1];
    NSString *profileId = [command.arguments objectAtIndex:2];
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
    int amount = 0;
    NSNumber *amountNum = [command.arguments objectAtIndex:1];
    if ([amountNum isKindOfClass:[NSNumber class]]) {
        amount = [amountNum intValue];
    }
    NSString *content = [command.arguments objectAtIndex:2];
    [TalkingDataSDK onCredit:profileId amount:amount content:content];
}

- (void)onTransaction:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    NSString *transactionJson = [command.arguments objectAtIndex:1];
    TalkingDataTransaction *transaction = [self transactionFormJsonString:transactionJson];
    [TalkingDataSDK onTransaction:profileId transaction:transaction];
}
#endif

#ifdef TD_GAME
- (void)onCreateRole:(CDVInvokedUrlCommand *)command {
    NSString *roleName = [command.arguments objectAtIndex:0];
    [TalkingDataSDK onCreateRole:roleName];
}

- (void)onLevelPass:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    NSString *levelId = [command.arguments objectAtIndex:1];
    [TalkingDataSDK onLevelPass:profileId levelId:levelId];
}

- (void)onGuideFinished:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    NSString *content = [command.arguments objectAtIndex:1];
    [TalkingDataSDK onGuideFinished:profileId content:content];
}
#endif

#ifdef TD_ONLINEEDU
- (void)onLearn:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    NSString *course = [command.arguments objectAtIndex:1];
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
    NSString *content = [command.arguments objectAtIndex:1];
    [TalkingDataSDK onPreviewFinished:profileId content:content];
}
#endif

#ifdef TD_READING
- (void)onRead:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    NSString *book = [command.arguments objectAtIndex:1];
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
    NSString *content = [command.arguments objectAtIndex:1];
    [TalkingDataSDK onFreeFinished:profileId content:content];
}
#endif

#if (defined(TD_GAME) || defined(TD_ONLINEEDU))
- (void)onAchievementUnlock:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    NSString *achievementId = [command.arguments objectAtIndex:1];
    [TalkingDataSDK onAchievementUnlock:profileId achievementId:achievementId];
}
#endif

#if (defined(TD_FINANCE) || defined(TD_TOUR) || defined(TD_OTHER))
- (void)onBrowse:(CDVInvokedUrlCommand *)command {
    NSString *profileId = [command.arguments objectAtIndex:0];
    NSString *content = [command.arguments objectAtIndex:1];
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
    NSString *content = [command.arguments objectAtIndex:1];
    [TalkingDataSDK onTrialFinished:profileId content:content];
}
#endif

- (void)onEvent:(CDVInvokedUrlCommand *)command {
    NSString *eventId = [command.arguments objectAtIndex:0];
    NSDictionary *eventData = [command.arguments objectAtIndex:1];
    NSDictionary *eventValue = [command.arguments objectAtIndex:2];
    [TalkingDataSDK onEvent:eventId parameters:eventData eventValue:eventValue];
}

- (void)setGlobalKV:(CDVInvokedUrlCommand *)command {
    NSString *key = [command.arguments objectAtIndex:0];
    id value = [command.arguments objectAtIndex:1];
    [TalkingDataSDK setGlobalKV:key value:value];
}

- (void)removeGlobalKV:(CDVInvokedUrlCommand *)command {
    NSString *key = [command.arguments objectAtIndex:0];
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
    profile.name = [profileDic objectForKey:@"name"];
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
    profile.property1 = [profileDic objectForKey:@"property1"];
    profile.property2 = [profileDic objectForKey:@"property2"];
    profile.property3 = [profileDic objectForKey:@"property3"];
    profile.property4 = [profileDic objectForKey:@"property4"];
    profile.property5 = [profileDic objectForKey:@"property5"];
    profile.property6 = [profileDic objectForKey:@"property6"];
    profile.property7 = [profileDic objectForKey:@"property7"];
    profile.property8 = [profileDic objectForKey:@"property8"];
    profile.property9 = [profileDic objectForKey:@"property9"];
    profile.property10 = [profileDic objectForKey:@"property10"];
    return profile;
}

- (TalkingDataSearch *)searchFromJsonString:(NSString *)json {
    NSDictionary *searchDic = [self dictionaryFromJsonString:json];
    if (searchDic == nil) {
        return nil;
    }
    TalkingDataSearch *search = [TalkingDataSearch createSearch];
    search.category = [searchDic objectForKey:@"category"];
    search.content = [searchDic objectForKey:@"content"];
#ifdef TD_RETAIL
    search.itemId = [searchDic objectForKey:@"itemId"];
    search.itemLocationId = [searchDic objectForKey:@"itemLocationId"];
#endif
#ifdef TD_TOUR
    search.destination = [searchDic objectForKey:@"destination"];
    search.origin = [searchDic objectForKey:@"origin"];
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
    if ([items isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in items) {
            NSString *itemId = [item objectForKey:@"itemId"];
            NSString *category = [item objectForKey:@"category"];
            NSString *name = [item objectForKey:@"name"];
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
    }
    return shoppingCart;
}

- (TalkingDataOrder *)orderFormJsonString:(NSString *)json {
    NSDictionary *orderDic = [self dictionaryFromJsonString:json];
    if (orderDic == nil) {
        return nil;
    }
    NSString *orderId = [orderDic objectForKey:@"orderId"];
    int total = 0;
    NSNumber *totalNum = [orderDic objectForKey:@"total"];
    if ([totalNum isKindOfClass:[NSNumber class]]) {
        total = [totalNum intValue];
    }
    NSString *currencyType = [orderDic objectForKey:@"currencyType"];
    TalkingDataOrder *order = [TalkingDataOrder createOrder:orderId total:total currencyType:currencyType];
    NSArray *items = orderDic[@"items"];
    if ([items isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in items) {
            NSString *itemId = [item objectForKey:@"itemId"];
            NSString *category = [item objectForKey:@"category"];
            NSString *name = [item objectForKey:@"name"];
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
    transaction.transactionId = [transactionDic objectForKey:@"transactionId"];
    transaction.category = [transactionDic objectForKey:@"category"];
    NSNumber *amount = [transactionDic objectForKey:@"amount"];
    if ([amount isKindOfClass:[NSNumber class]]) {
        transaction.amount = [amount intValue];
    }
    transaction.personA = [transactionDic objectForKey:@"personA"];
    transaction.personB = [transactionDic objectForKey:@"personB"];
    NSNumber *startDate = [transactionDic objectForKey:@"startDate"];
    if ([startDate isKindOfClass:[NSNumber class]]) {
        transaction.startDate = [startDate longLongValue];
    }
    NSNumber *endDate = [transactionDic objectForKey:@"endDate"];
    if ([endDate isKindOfClass:[NSNumber class]]) {
        transaction.endDate = [endDate longLongValue];
    }
    transaction.content = [transactionDic objectForKey:@"content"];
    transaction.currencyType = [transactionDic objectForKey:@"currencyType"];
    return transaction;
}
#endif

@end
