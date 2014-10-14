#import "Kiwi.h"
#import "DXRBayeuxClient.h"

SPEC_BEGIN(DXRBayeuxClientSpec)

describe(@"DXRBayeuxClient", ^{

    describe(@"instance", ^{
        it(@"returns a singleton", ^{
            DXRBayeuxClient *client1 = [DXRBayeuxClient instance];
            DXRBayeuxClient *client2 = [DXRBayeuxClient instance];
            [[client1 should] equal:client2];
        });
    });

    context(@"with an instance", ^{
        __block DXRBayeuxClient *client;

        beforeEach(^{
            client = [DXRBayeuxClient new];
        });

        it(@"has a Faye client", ^{
            [[[client faye] should] beKindOfClass:[MZFayeClient class]];
        });

        it(@"has a Base URL", ^{
            [[[client baseUrl] should]
                equal:[NSURL URLWithString:@"http://example.org/bayeux"]];
        });
    });

});

SPEC_END