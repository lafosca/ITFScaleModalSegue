//
//  ITFScaleModalSegue.m
//  ITFScaleModalSegue
//
//  Created by Arol Viñolas on 24/05/13.
//

#import "ITFScaleModalSegue.h"

#import <QuartzCore/QuartzCore.h>

#define kDefaultAnimationduration 0.5f

@interface ITFHostViewController : UIViewController

@property (nonatomic, strong) UIImageView* sourceViewRender;
@property (nonatomic, strong) UIImageView* destinationViewRender;
@property (nonatomic, strong) UIViewController* sourceViewController;
@property (nonatomic, strong) UIViewController* destinationViewController;

@property (nonatomic, assign) CGFloat animationDuration;

@end

@implementation ITFHostViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //Adding a black background to host view and source view render
    [[self view] setBackgroundColor:[UIColor blackColor]];
    [[self view] addSubview:[self sourceViewRender]];
    
    // Hide the destination view render and add it to the hostView
    [[self destinationViewRender] setAlpha:0.0f];
    [[self view] addSubview:[self destinationViewRender]];
    
    // Adding both animations
    [[[self sourceViewRender] layer] addAnimation:[self animationSourceOut]
                                           forKey:@"sourceOut"];
    [[[self destinationViewRender] layer] addAnimation:[self animationDestinationIn]
                                                forKey:@"destinationIn"];
    
    // Present the destination view controller after the animations.
    [self performSelector:@selector(presentDestinationViewController) withObject:nil afterDelay:self.animationDuration];
}

- (void)presentDestinationViewController{
    [self presentViewController:self.destinationViewController animated:NO completion:nil];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [super dismissViewControllerAnimated:NO completion:^{
        [[[self sourceViewRender] layer] addAnimation:[self animationSourceIn] forKey:nil];
        [[[self destinationViewRender] layer] addAnimation:[self animationDestinationOut]
                                                    forKey:nil];
        
        [self performSelector:@selector(dismissViewController) withObject:nil
                   afterDelay:self.animationDuration];
    }];
}

- (void)dismissViewController{
    
    [super dismissViewControllerAnimated:NO completion:nil];
    
}

#pragma mark - Source Animations

-(CAAnimationGroup*)animationSourceOut {
    CATransform3D t1 = CATransform3DIdentity;
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:t1];
    animation.duration = self.animationDuration/3*2;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    opacityAnimation.duration = self.animationDuration/3*2;
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = NO;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [group setDuration:self.animationDuration/3*2];
    [group setAnimations:[NSArray arrayWithObjects:animation, opacityAnimation, nil]];
    return group;
}

-(CAAnimationGroup*)animationSourceIn {
    CATransform3D t1 = CATransform3DIdentity;
    t1 = CATransform3DScale(t1, 1, 1, 1);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:t1];
    animation.beginTime = self.animationDuration/3;
    animation.duration = self.animationDuration/3*2;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    opacityAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    animation.beginTime = self.animationDuration/3;
    opacityAnimation.duration = self.animationDuration/3*2;
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = NO;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [group setDuration:self.animationDuration];
    [group setAnimations:[NSArray arrayWithObjects:animation, opacityAnimation, nil]];
    return group;
}

#pragma mark - Destination animations

-(CAAnimationGroup*)animationDestinationIn {
    CATransform3D t0 = CATransform3DIdentity;
    CATransform3D t1 = CATransform3DIdentity;
    t0 = CATransform3DScale(t0, 1.1, 1.1, 1);
    t1 = CATransform3DScale(t0, 1/1.1, 1/1.1, 1);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:t0];
    animation.toValue   = [NSValue valueWithCATransform3D:t1];
    animation.beginTime = self.animationDuration/3;
    animation.duration  = self.animationDuration/3*2;
    animation.fillMode  = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue  = [NSNumber numberWithFloat:0.0f];
    opacityAnimation.toValue    = [NSNumber numberWithFloat:1.0f];
    opacityAnimation.beginTime  = self.animationDuration/3;
    opacityAnimation.duration   = self.animationDuration/3*2;
    opacityAnimation.fillMode   = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = NO;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [group setDuration:self.animationDuration];
    [group setAnimations:[NSArray arrayWithObjects:animation, opacityAnimation, nil]];
    return group;
}

-(CAAnimationGroup*)animationDestinationOut {
    CATransform3D t0 = CATransform3DIdentity;
    CATransform3D t1 = CATransform3DIdentity;
    t0 = CATransform3DScale(t0, 1, 1, 1);
    t1 = CATransform3DScale(t0, 1.1, 1.1, 1);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:t0];
    animation.toValue   = [NSValue valueWithCATransform3D:t1];
    animation.duration  = self.animationDuration/3*2;
    animation.fillMode  = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue  = [NSNumber numberWithFloat:1.0f];
    opacityAnimation.toValue    = [NSNumber numberWithFloat:0.0f];
    opacityAnimation.duration   = self.animationDuration/3*2;
    opacityAnimation.fillMode   = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = NO;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [group setDuration:self.animationDuration/3*2];
    [group setAnimations:[NSArray arrayWithObjects:animation, opacityAnimation, nil]];
    return group;
}

@end

@implementation ITFScaleModalSegue

- (void)perform {
    ITFHostViewController* host = [[ITFHostViewController alloc] init];
    
    if (! [self animationDuration]) {
        [self setAnimationDuration:kDefaultAnimationduration];
    }
    
    // Set the view controllers
    [host setDestinationViewController:[self destinationViewController]];
    [host setSourceViewController:[self sourceViewController]];
    [host setAnimationDuration:[self animationDuration]];
    
    // Set the renders
    [host setSourceViewRender:[self renderedImageForView:[UIApplication sharedApplication].keyWindow]];
    
    // Present the modal, then render its layer, finally dimsmiss it
    // After it we can begin to present it again
    // Weirdly, it doesn't load the view twice, only loads it once.
    [[self sourceViewController] presentViewController:[self destinationViewController] animated:NO completion:^{
        [host setDestinationViewRender:[self renderedImageForView:[[host destinationViewController] view]]];
        [[self destinationViewController] dismissViewControllerAnimated:NO completion:^{
            [self.sourceViewController presentViewController:host animated:NO completion:nil];
        }];
    }];
    
}


- (UIImageView*)renderedImageForView:(UIView*)view{
	UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [[UIScreen mainScreen] scale]);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *render = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if ([UIApplication sharedApplication].statusBarHidden == NO) {
        CGFloat barHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        CGFloat scale = [[UIScreen mainScreen] scale];
        CGRect rect = CGRectMake(0, barHeight * scale, view.bounds.size.width * scale, (view.bounds.size.height - barHeight) * scale);
        CGImageRef imageRef = CGImageCreateWithImageInRect(render.CGImage, rect);
        render = [UIImage imageWithCGImage:imageRef scale:render.scale orientation:render.imageOrientation];
    }
    
	UIImageView* renderedImage = [[UIImageView alloc] initWithImage:render];
    renderedImage.frame = CGRectMake(0, 0, render.size.width, render.size.height);
    return renderedImage;
}

@end
