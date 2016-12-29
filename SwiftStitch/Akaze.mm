#import "Akaze.h"
#import <Foundation/Foundation.h>
#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>




@interface Akaze()
{
    cv::Ptr<cv::AKAZE> detector;
    cv::Mat img;
    cv::Mat descriptor;
    std::vector<cv::KeyPoint> keypoints;
}
@end

@implementation Akaze: NSObject
-(id)init{
    self = [super init];
    
    return self;
}

-(UInt64)getPoints {
    return keypoints.size();
}

-(cv::Mat)getDescriptor {
    cv::Mat result;
    detector->compute(img, keypoints, result);
    return result;
}

-(std::vector<cv::KeyPoint>)getKeypoints {
    return std::vector<cv::KeyPoint>();
}

-(UIImage *)recognizePoints:(UIImage *)image {
    // UIImage -> cv::Mat変換
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat mat(rows, cols, CV_8UC4);
    img = mat;
    
    CGContextRef contextRef = CGBitmapContextCreate(mat.data,
                                                    cols,
                                                    rows,
                                                    8,
                                                    mat.step[0],
                                                    colorSpace,
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault);
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    cv::cvtColor(mat, mat, CV_RGBA2RGB);
    
    detector = cv::AKAZE::create();
    detector->detect(mat, keypoints);
    
    cv::drawKeypoints(mat, keypoints, mat);
    
    UIImage *resultImage = MatToUIImage(mat);
    return resultImage;
}
@end

@interface AkazeMatch()
{
}
@end

@implementation AkazeMatch: Akaze
-(UIImage *)match:(UIImage *)image {
    [self recognizePoints:image];
    return nil; // temp
}
@end




@interface Orb()
{
    UInt64 points;
    cv::Mat descriptor;
    std::vector<cv::KeyPoint> keypoints;
}
@end

@implementation Orb: NSObject
-(id)init{
    self = [super init];
    
    return self;
}

-(UInt64)getPoints {
    return points;
}

-(UIImage *)recognizePoints:(UIImage *)image {
    // UIImage -> cv::Mat変換
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat mat(rows, cols, CV_8UC4);
    
    CGContextRef contextRef = CGBitmapContextCreate(mat.data,
                                                    cols,
                                                    rows,
                                                    8,
                                                    mat.step[0],
                                                    colorSpace,
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault);
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    cv::cvtColor(mat, mat, CV_RGBA2RGB);
    
    auto detector = cv::ORB::create();
    std::vector<cv::KeyPoint> keyPoints;
    detector->detect(mat, keyPoints);
    points = keyPoints.size();
    
    //    cv::Mat output;
    cv::drawKeypoints(mat, keyPoints, mat);
    //, cv::Scalar::all(-1),cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);
    
    UIImage *resultImage = MatToUIImage(mat);
    return resultImage;
}
@end
