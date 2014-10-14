#import "Kiwi.h"
#import "DXRBayeuxClient.h"
#import "DXREnvironment.h"
#import "DXRLogin.h"

@interface DXRBayeuxClient ()
@property (strong, nonatomic) MZFayeClient *faye;
@property (strong, nonatomic) DXREnvironment *env;
@property (strong, nonatomic) DXRLogin *login;
@end

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
            client = [[DXRBayeuxClient alloc] init];

            client.faye = [KWMock mockForClass:[MZFayeClient class]];
            [client.faye stub:@selector(delegate) andReturn:client];

            client.env = [KWMock mockForClass:[DXREnvironment class]];
            [client.env stub:@selector(baseUrl) andReturn:@"http://test.example.org"];

            client.login = [KWMock mockForClass:[DXRLogin class]];
        });

        it(@"has a Faye client", ^{
            [[[client faye] should] beKindOfClass:[MZFayeClient class]];
        });

        it(@"has a Base URL", ^{
            [[[client baseUrl] should]
                equal:[NSURL URLWithString:@"http://test.example.org/bayeux"]];
        });

        context(@"for an authenticated channel", ^{
            __block NSString *channel;
            __block NSDictionary *extensions;

            beforeEach(^{
                channel = @"firelit";
                extensions= @{@"apiKey":@"777"};
                [client.login stub:@selector(apiKey) andReturn:@"777"];
            });

            describe(@"joining a channel", ^{
                beforeEach(^{
                    [client.faye stub:@selector(setExtension:forChannel:)
                            andReturn:nil
                        withArguments:extensions,channel];
                    [client.faye stub:@selector(subscribeToChannel:)
                            andReturn:nil
                        withArguments:channel];
                });

                it(@"subscribes using Faye", ^{
                    [[[client.faye should] receive] subscribeToChannel:channel];
                    [client subscribeToChannel:channel];
                });
                it(@"sets the API key", ^{
                    [[[client.faye should] receive] setExtension:extensions forChannel:channel];
                    [client subscribeToChannel:channel];
                });
            });

            describe(@"leaving a channel", ^{
                beforeEach(^{
                    [client.faye stub:@selector(removeExtensionForChannel:)
                            andReturn:nil
                        withArguments:channel];
                    [client.faye stub:@selector(unsubscribeFromChannel:)
                            andReturn:nil
                        withArguments:channel];
                });

                it(@"unsubscribes using Faye", ^{
                    [[[client.faye should] receive] unsubscribeFromChannel:channel];
                    [client unsubscribeFromChannel:channel];
                });
                it(@"removes the API key", ^{
                    [[[client.faye should] receive] removeExtensionForChannel:channel];
                    [client unsubscribeFromChannel:channel];
                });
            });
        });
    });
});

SPEC_END