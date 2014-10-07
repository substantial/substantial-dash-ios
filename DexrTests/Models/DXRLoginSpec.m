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

});

SPEC_END