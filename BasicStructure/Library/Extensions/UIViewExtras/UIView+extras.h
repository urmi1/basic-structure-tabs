//
//  NSString+extras.h
//  YouShop
//
//  Created by _MyCompanyName_ on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kAnimateFromTop          = 0,
    kAnimateFromBottom       = 1,
    kAnimateFromLeft         = 2,
    kAnimateFromRight        = 3,
} AnimationDirection;

@interface UIView (extras)

- (void)addSubview:(UIView *)view animationDirection:(AnimationDirection)animationDirection duration:(NSTimeInterval)duration completion:(void (^)(void))completion;
- (void)addSubview:(UIView *)view frame:(CGRect)frame animationDirection:(AnimationDirection)animationDirection duration:(NSTimeInterval)duration completion:(void (^)(void))completion;
- (void)addSubview:(UIView *)view  animations:(void (^)(void))animations animationDirection:(AnimationDirection)animationDirection duration:(NSTimeInterval)duration completion:(void (^)(void))completion;

- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index animationDirection:(AnimationDirection)animationDirection duration:(NSTimeInterval)duration completion:(void (^)(void))completion;

- (void)removeFromSuperview:(AnimationDirection)animationDirection duration:(NSTimeInterval)duration completion:(void (^)(void))completion;
- (void)removeFromSuperview:(void (^)(void))animations animationDirection:(AnimationDirection)animationDirection duration:(NSTimeInterval)duration completion:(void (^)(void))completion;


- (void)slideView:(AnimationDirection)animationDirection duration:(NSTimeInterval)duration completion:(void (^)(void))completion;

@end
