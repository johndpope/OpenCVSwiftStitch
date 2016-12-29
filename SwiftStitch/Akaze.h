
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <opencv2/opencv.hpp>



@interface Akaze: NSObject
-(id)init;
-(UInt64)getPoints;
-(UIImage *)recognizePoints:(UIImage *)image;
-(cv::Mat)getDescriptor;
-(std::vector<cv::KeyPoint>)getKeypoints;
@end

@interface AkazeMatch: Akaze
-(UIImage *)match:(UIImage *)image p:(UInt32)in;
@end

@interface Orb: NSObject
-(id)init;
-(UInt64)getPoints;
-(UIImage *)recognizePoints:(UIImage *)image;
-(cv::Mat)getDescriptor;
-(std::vector<cv::KeyPoint>)getKeypoints;
@end


