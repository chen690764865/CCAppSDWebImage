//
//  UIImageView+CCImageView.h
//  仿SDWebImage
//
//  Created by chenchen on 16/8/2.
//  Copyright © 2016年 chenchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CCImageView)

/**
 *  定义一个属性,记录下载的地址.在分类中定义属性,系统不会帮我们生成带下hua线的成员变量与 get/set 方法
 */
@property(nonatomic,strong)NSString *urlString;

-(void)cc_setImageWithURLString:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage;

@end
