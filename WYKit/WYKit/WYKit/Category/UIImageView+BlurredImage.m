//
//  UIImageView+BlurredImage.m
//  WYKit
//  简书地址：http://www.jianshu.com/u/8f8143fbe7e4
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import "UIImageView+BlurredImage.h"
#import "UIImage+ImageEffects.h"

CGFloat const kLBBlurredImageDefaultBlurRadius            = 20.0;
CGFloat const kLBBlurredImageDefaultSaturationDeltaFactor = 1.8;

@implementation UIImageView (BlurredImage)

- (void)setImageToBlur:(UIImage *)image
       completionBlock:(BlurredImageCompletionBlock)completion
{
    [self setImageToBlur:image
              blurRadius:kLBBlurredImageDefaultBlurRadius
         completionBlock:completion];
}


// 私有方法 设置图片毛玻璃效果
- (void)setImageToBlur:(UIImage *)image
            blurRadius:(CGFloat)blurRadius
       completionBlock:(BlurredImageCompletionBlock) completion
{
    NSParameterAssert(image);
    NSParameterAssert(blurRadius >= 0);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 模糊算法
        UIImage *blurredImage = [image applyBlurWithRadius:blurRadius
                                                 tintColor:nil
                                     saturationDeltaFactor:kLBBlurredImageDefaultSaturationDeltaFactor
                                                 maskImage:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = blurredImage;
            if (completion) {
                completion();
            }
        });
    });
}


@end
