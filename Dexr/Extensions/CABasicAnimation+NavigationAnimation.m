#import "CABasicAnimation+NavigationAnimation.h"

@implementation CABasicAnimation (NavigationAnimation)

+ (CABasicAnimation *)animatePositionXFromPositionX:(NSNumber *)value withDelegate:(id)delegate
{
    CABasicAnimation *animation = [self animationWithKeyPath:@"position.x"];
    animation.fromValue = value;
    animation.delegate = delegate;
    animation.duration = 0.34;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    return animation;
}

@end
