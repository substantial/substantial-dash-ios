#import "DXREnvironment.h"

#define STRINGIZE(x) #x
#define OBJ_C_STRINGIZE(x) @ STRINGIZE(x)

@implementation DXREnvironment

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static DXREnvironment *instance;
    dispatch_once(&once, ^ { instance = [[self alloc] initWithConfig:@"Config"]; });
    return instance;
}

- (id)initWithConfig:(NSString *)configFilename
{
    self = [super init];
    if (self) {
        NSString *configPath = [[NSBundle mainBundle] pathForResource:configFilename ofType:@"plist"];
        NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile:configPath];
        _config = config[self.envName];
    }
    return self;
}

- (NSString *)envName
{
    return OBJ_C_STRINGIZE(DXR_ENV);
}

- (NSURL *)baseUrl
{
    return [NSURL URLWithString:self.config[@"baseUrl"]];
}

@end