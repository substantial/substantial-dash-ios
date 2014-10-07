#import "Kiwi.h"
#import "DXRLogin.h"

SPEC_BEGIN(DXRLoginSpec)

describe(@"DXRLogin", ^{

    describe(@"instance", ^{
        it(@"returns a singleton", ^{
            DXRLogin *login1 = [DXRLogin instance];
            DXRLogin *login2 = [DXRLogin instance];
            [[login1 should] equal:login2];
        });
    });

    describe(@"apiKeyChanged", ^{
        __block DXRLogin *login;
        __block NSString *signalledApiKey;
        __block BOOL apiKeyChangedSuccess;
        __block NSError *apiKeyChangedError;

        beforeEach(^{
            login = [DXRLogin instance];
        });

        it(@"begins with nil", ^{
            signalledApiKey = [login.apiKeyChanged asynchronousFirstOrDefault:nil
                                                                      success:&apiKeyChangedSuccess
                                                                        error:&apiKeyChangedError];
            [[signalledApiKey should] beNil];
            [[theValue(apiKeyChangedSuccess) should] beYes];
            [[apiKeyChangedError should] beNil];
        });

        it(@"signals when the apiKey changes", ^{
            login.apiKey = @"Firelit";
            signalledApiKey = [login.apiKeyChanged asynchronousFirstOrDefault:nil
                                                    success:&apiKeyChangedSuccess
                                                      error:&apiKeyChangedError];
            [[signalledApiKey should] equal:@"Firelit"];
            [[theValue(apiKeyChangedSuccess) should] beYes];
            [[apiKeyChangedError should] beNil];
        });

        it(@"signals when the apiKey becomes nil", ^{
            login.apiKey = @"Firelit";
            login.apiKey = nil;
            signalledApiKey = [login.apiKeyChanged asynchronousFirstOrDefault:nil
                                                                      success:&apiKeyChangedSuccess
                                                                        error:&apiKeyChangedError];
            [[signalledApiKey should] beNil];
            [[theValue(apiKeyChangedSuccess) should] beYes];
            [[apiKeyChangedError should] beNil];
        });
    });

});

SPEC_END