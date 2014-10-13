@interface DXREnvironment : NSObject

@property (strong, nonatomic) NSDictionary *config;
+ (instancetype)instance;
- (id)initWithConfig:(NSString *)configFilename;
- (NSString *)envName;
- (NSURL *)baseUrl;
@end
