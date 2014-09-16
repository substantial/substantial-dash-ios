@interface DXREnvironment : NSObject

@property (strong, nonatomic) NSDictionary *config;
+ (instancetype)sharedInstance;
- (id)initWithConfig:(NSString *)configFilename;
- (NSString *)envName;
- (NSURL *)baseUrl;
@end
