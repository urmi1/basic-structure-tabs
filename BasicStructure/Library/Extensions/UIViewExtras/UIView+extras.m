//
//  NSString+extras.m
//  YouShop
//
//  Created by _MyCompanyName_ on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIView+extras.h"

@implementation UIView (extras)

- (void)addSubview:(UIView *)view animationDirection:(AnimationDirection)animationDirection duration:(NSTimeInterval)duration completion:(void (^)(void))completion{
    [self addSubview:view];
    
    CGPoint newCenter = CGPointMake((view.frame.size.width/2)+view.frame.origin.x, (view.frame.size.height/2)+view.frame.origin.y);
    
    switch (animationDirection) {
        case kAnimateFromTop:
            view.center = CGPointMake(view.frame.size.width/2, -1*(view.frame.size.height/2));
            break;
            
            
        case kAnimateFromBottom:
            view.center = CGPointMake(view.frame.size.width/2, view.frame.size.height*2);
            break;
            
            
        case kAnimateFromRight:
            view.center = CGPointMake(view.frame.size.width*2, view.frame.size.height/2);
            break;
            
            
        case kAnimateFromLeft:
            view.center = CGPointMake(-1*(view.frame.size.width/2), view.frame.size.height/2);
            break;
            
            
        default:
            view.center = CGPointMake(view.frame.size.width/2, -1*(view.frame.size.height/2));
            break;
    }
    
    [UIView animateWithDuration:duration animations:^{
        view.center = newCenter;
    } completion:^(BOOL finished) {
        if(completion)
            completion();
    }];
}

- (void)addSubview:(UIView *)view  animations:(void (^)(void))animations animationDirection:(AnimationDirection)animationDirection duration:(NSTimeInterval)duration completion:(void (^)(void))completion{
    [self addSubview:view];
    
    CGPoint newCenter = CGPointMake((view.frame.size.width/2)+view.frame.origin.x, (view.frame.size.height/2)+view.frame.origin.y);
    
    switch (animationDirection) {
        case kAnimateFromTop:
            view.center = CGPointMake(view.frame.size.width/2, -1*(view.frame.size.height/2));
            break;
            
            
        case kAnimateFromBottom:
            view.center = CGPointMake(view.frame.size.width/2, view.frame.size.height*2);
            break;
            
            
        case kAnimateFromRight:
            view.center = CGPointMake(view.frame.size.width*2, view.frame.size.height/2);
            break;
            
            
        case kAnimateFromLeft:
            view.center = CGPointMake(-1*(view.frame.size.width/2), view.frame.size.height/2);
            break;
            
            
        default:
            view.center = CGPointMake(view.frame.size.width/2, -1*(view.frame.size.height/2));
            break;
    }
    
    [UIView animateWithDuration:duration animations:^{
        if(animations)
            animations();
        view.center = newCenter;
    } completion:^(BOOL finished) {
        if(completion)
            completion();
    }];
}


- (void)addSubview:(UIView *)view frame:(CGRect)frame animationDirection:(AnimationDirection)animationDirection duration:(NSTimeInterval)duration completion:(void (^)(void))completion{
    [view setFrame:frame];
    [self addSubview:view];
    
    CGPoint newCenter = CGPointMake(view.frame.size.width/2, view.frame.size.height/2);
    
    switch (animationDirection) {
        case kAnimateFromTop:
            view.center = CGPointMake(view.frame.size.width/2, -1*(view.frame.size.height/2));
            break;
            
            
        case kAnimateFromBottom:
            view.center = CGPointMake(view.frame.size.width/2, view.frame.size.height*2);
            break;
            
            
        case kAnimateFromRight:
            view.center = CGPointMake(view.frame.size.width*2, view.frame.size.height/2);
            break;
            
            
        case kAnimateFromLeft:
            view.center = CGPointMake(-1*(view.frame.size.width/2), view.frame.size.height/2);
            break;
            
            
        default:
            view.center = CGPointMake(view.frame.size.width/2, -1*(view.frame.size.height/2));
            break;
    }
    
    [UIView animateWithDuration:duration animations:^{
        view.center = newCenter;
    } completion:^(BOOL finished) {
        if(completion)
            completion();
    }];
}

- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index animationDirection:(AnimationDirection)animationDirection duration:(NSTimeInterval)duration completion:(void (^)(void))completion{
    [self insertSubview:view atIndex:index];
    
    CGPoint newCenter = CGPointMake((view.frame.size.width/2)+view.frame.origin.x, (view.frame.size.height/2)+view.frame.origin.y);
    
    switch (animationDirection) {
        case kAnimateFromTop:
            view.center = CGPointMake(view.frame.size.width/2, -1*(view.frame.size.height/2));
            break;
            
            
        case kAnimateFromBottom:
            view.center = CGPointMake(view.frame.size.width/2, view.frame.size.height*2);
            break;
            
            
        case kAnimateFromRight:
            view.center = CGPointMake(view.frame.size.width*2, view.frame.size.height/2);
            break;
            
            
        case kAnimateFromLeft:
            view.center = CGPointMake(-1*(view.frame.size.width/2), view.frame.size.height/2);
            break;
            
            
        default:
            view.center = CGPointMake(view.frame.size.width/2, -1*(view.frame.size.height/2));
            break;
    }
    
    [UIView animateWithDuration:duration animations:^{
        view.center = newCenter;
    } completion:^(BOOL finished) {
        if(completion)
            completion();
    }];
}

- (void)removeFromSuperview:(AnimationDirection)animationDirection duration:(NSTimeInterval)duration completion:(void (^)(void))completion{
    CGPoint newCenter;
    switch (animationDirection) {
        case kAnimateFromTop:
            newCenter = CGPointMake(self.superview.frame.size.width/2, -1*(self.superview.frame.size.height));
            break;
            
        case kAnimateFromBottom:
            newCenter = CGPointMake(self.superview.frame.size.width/2, self.superview.frame.size.height*2);
            break;
            
            
        case kAnimateFromRight:
            newCenter = CGPointMake(self.superview.frame.size.width*2, self.superview.frame.size.height/2);
            break;
            
            
        case kAnimateFromLeft:
            newCenter = CGPointMake(-1*(self.superview.frame.size.width/2), self.superview.frame.size.height/2);
            break;
            
            
        default:
            newCenter = CGPointMake(self.superview.frame.size.width/2, -1*(self.superview.frame.size.height/2));
            break;
    }
    
    [UIView animateWithDuration:duration animations:^{
        self.center = newCenter;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if(completion)
            completion();
    }];
}

- (void)removeFromSuperview:(void (^)(void))animations animationDirection:(AnimationDirection)animationDirection duration:(NSTimeInterval)duration completion:(void (^)(void))completion{
    CGPoint newCenter;
    switch (animationDirection) {
        case kAnimateFromTop:
            newCenter = CGPointMake(self.superview.frame.size.width/2, -1*(self.superview.frame.size.height));
            break;
            
        case kAnimateFromBottom:
            newCenter = CGPointMake(self.superview.frame.size.width/2, self.superview.frame.size.height*2);
            break;
            
            
        case kAnimateFromRight:
            newCenter = CGPointMake(self.superview.frame.size.width*2, self.superview.frame.size.height/2);
            break;
            
            
        case kAnimateFromLeft:
            newCenter = CGPointMake(-1*(self.superview.frame.size.width/2), self.superview.frame.size.height/2);
            break;
            
            
        default:
            newCenter = CGPointMake(self.superview.frame.size.width/2, -1*(self.superview.frame.size.height/2));
            break;
    }
    
    [UIView animateWithDuration:duration animations:^{
        if(animations)
            animations();
        self.center = newCenter;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if(completion)
            completion();
    }];
}

- (void)slideView:(AnimationDirection)animationDirection duration:(NSTimeInterval)duration completion:(void (^)(void))completion{
    //CGPoint newCenter = CGPointMake((self.frame.size.width/2)+self.frame.origin.x, (self.frame.size.height/2)+self.frame.origin.y);
    
    CGPoint newCenter;
    switch (animationDirection) {
        case kAnimateFromTop:
            newCenter = CGPointMake(self.superview.frame.size.width/2, -1*(self.superview.frame.size.height));
            break;
            
        case kAnimateFromBottom:
            newCenter = CGPointMake(self.superview.frame.size.width/2, self.superview.frame.size.height*2);
            break;
            
            
        case kAnimateFromRight:
            newCenter = CGPointMake(self.superview.frame.size.width*2, self.superview.frame.size.height/2);
            break;
            
            
        case kAnimateFromLeft:
            newCenter = CGPointMake(-1*(self.superview.frame.size.width/2), self.superview.frame.size.height/2);
            break;
            
            
        default:
            newCenter = CGPointMake(self.superview.frame.size.width/2, -1*(self.superview.frame.size.height/2));
            break;
    }

    
    
    [UIView animateWithDuration:duration animations:^{
        self.center = newCenter;
    } completion:^(BOOL finished) {
        if(completion)
            completion();
    }];
}

@end
