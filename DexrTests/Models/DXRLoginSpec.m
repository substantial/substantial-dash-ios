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

    describe(@"userNameChanged", ^{
        __block DXRLogin *login;
        __block NSString *signalledUserName;
        __block BOOL userNameChangedSuccess;
        __block NSError *userNameChangedError;

        beforeEach(^{
            login = [DXRLogin instance];
        });

        it(@"begins with nil", ^{
            signalledUserName = [login.userNameChanged asynchronousFirstOrDefault:nil
                                                                      success:&userNameChangedSuccess
                                                                        error:&userNameChangedError];
            [[signalledUserName should] beNil];
            [[theValue(userNameChangedSuccess) should] beYes];
            [[userNameChangedError should] beNil];
        });

        it(@"signals when the userName changes", ^{
            login.userName = @"Mr. Flux";
            signalledUserName = [login.userNameChanged asynchronousFirstOrDefault:nil
                                                                      success:&userNameChangedSuccess
                                                                        error:&userNameChangedError];
            [[signalledUserName should] equal:@"Mr. Flux"];
            [[theValue(userNameChangedSuccess) should] beYes];
            [[userNameChangedError should] beNil];
        });

        it(@"signals when the userName becomes nil", ^{
            login.userName = @"Mr. Flux";
            login.userName = nil;
            signalledUserName = [login.userNameChanged asynchronousFirstOrDefault:nil
                                                                      success:&userNameChangedSuccess
                                                                        error:&userNameChangedError];
            [[signalledUserName should] beNil];
            [[theValue(userNameChangedSuccess) should] beYes];
            [[userNameChangedError should] beNil];
        });
    });

    describe(@"logout", ^{
        __block DXRLogin *login;

        beforeEach(^{
            login = [DXRLogin instance];
            login.userName = @"Mr. Flux";
            login.apiKey = @"firelit";
        });

        it(@"signals when the userName becomes nil", ^{
            [login logout];

            [[login.userName should] beNil];
            [[login.apiKey should] beNil];
        });
    });
});

SPEC_END