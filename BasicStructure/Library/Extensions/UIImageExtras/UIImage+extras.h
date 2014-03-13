//
//  UIImageAdditions.h
//  Sample
//
//  Created by Kirby Turner on 2/7/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage (extras)

- (UIImage *)imageScaleAspectToMaxSize:(CGFloat)newSize;
- (UIImage *)imageScaleAndCropToMaxSize:(CGSize)newSize;

typedef enum {
    MGImageResizeCrop, // analogous to UIViewContentModeScaleAspectFill, i.e. "best fit" with no space around.
    MGImageResizeCropStart,
    MGImageResizeCropEnd,
    MGImageResizeScale // analogous to UIViewContentModeScaleAspectFit, i.e. scale down to fit, leaving space around if necessary.
} MGImageResizingMethod;

- (UIImage *)imageToFitSize:(CGSize)size method:(MGImageResizingMethod)resizeMethod;
- (UIImage *)imageCroppedToFitSize:(CGSize)size; // uses MGImageResizeCrop
- (UIImage *)imageScaledToFitSize:(CGSize)size; // uses MGImageResizeScale


-(UIImage *)fixOrientation;
+(void)saveJPGInFolder:(NSString*)pStrFolderName withFileName:(NSString*)withFileName withCompressionQuality:(CGFloat)pFltCompressionQuality;
+(void)savePNGInFolder:(NSString*)pStrFolderName withFileName:(NSString*)withFileName;

@end
