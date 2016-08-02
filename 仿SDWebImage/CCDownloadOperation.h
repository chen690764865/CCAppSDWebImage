//
//  CCDownloadOperation.h
//  仿SDWebImage
//
//  Created by chenchen on 16/8/2.
//  Copyright © 2016年 chenchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCDownloadOperation : NSOperation

@property(nonatomic,strong)UIImage *image;

/**
 *  通过urlString创建一个操作
 *
 *  @param urlString url字符串地址
 *
 *  @return 返回操作
 */
+(instancetype)operationWithURLString:(NSString *)urlString;

@end
