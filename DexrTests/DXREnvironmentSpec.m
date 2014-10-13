#import "Kiwi.h"
#import "DXREnvironment.h"

SPEC_BEGIN(DXREnvironmentSpec)

describe(@"DXREnvironment", ^{
    __block DXREnvironment *environment;

    beforeEach(^{
        environment = [[DXREnvironment alloc] initWithConfig:@"Config"];
    });

    describe(@"instance", ^{
        it(@"returns a singleton", ^{
            DXREnvironment *env1 = [DXREnvironment instance];
            DXREnvironment *env2 = [DXREnvironment instance];
            [[env1 should] equal:env2];
        });
    });

    describe(@"envName", ^{
        it(@"should return the current name of the environment", ^{
            NSString *expectedName = @"test";
            [[environment envName] shouldNotBeNil];
            [[[environment envName] should] equal:expectedName];
        });
    });

    describe(@"baseUrl", ^{
        it(@"should return the base url", ^{
            NSURL *expectedUrl = [NSURL URLWithString:@"http://example.org"];
            [[[environment baseUrl] should] equal:expectedUrl];
        });
    });

});

SPEC_END