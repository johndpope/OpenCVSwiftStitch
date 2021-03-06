//
//  CVWrapper.h
//  CVOpenTemplate
//
//  Created by Washe on 02/01/2013.
//  Copyright (c) 2013 foundry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "Detector.h"

NS_ASSUME_NONNULL_BEGIN
@interface CVWrapper : NSObject

+(UIImage *)recognizePoints:(UIImage *)image;

+ (UIImage*) processImageWithOpenCV: (UIImage*) inputImage;

+ (UIImage*) processWithOpenCVImage1:(UIImage*)inputImage1 image2:(UIImage*)inputImage2;

+ (UIImage*) processWithArray:(NSArray<UIImage*>*)imageArray;


@end
NS_ASSUME_NONNULL_END
