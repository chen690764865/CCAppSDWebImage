//
//  CCDownloadOperation.m
//  仿SDWebImage
//
//  Created by chenchen on 16/8/2.
//  Copyright © 2016年 chenchen. All rights reserved.
//

#import "CCDownloadOperation.h"
#import "NSString+path.h"

@interface CCDownloadOperation ()

@property (nonatomic, strong) NSString* urlString;

@end

@implementation CCDownloadOperation

+ (instancetype)operationWithURLString:(NSString*)urlString
{

    //初始化操作
    CCDownloadOperation* op = [[CCDownloadOperation alloc] init];

    //记录url字符串地址
    op.urlString = urlString;

    return op;
}

/**
 *  初始化一个操作,然后把操作添加到队列中,实质上就是调用了main方法,这个方法系统会自动调用,不用我们手动调用
 */
- (void)main
{

    //在main方法里面下载图片并返回一张图片,.h里面应该有一个UIImage类型的图片属性
    //根据url字符串地址获取url地址
    NSURL* url = [NSURL URLWithString:self.urlString];
    //把url地址转换为系统能够识别的二进制数据
    NSData* data = [NSData dataWithContentsOfURL:url];

    //把二进制数据写入沙盒
    //沙盒路径
    NSString* cachePath = [self.urlString appendCachePath];
    [data writeToFile:cachePath atomically:true];
    //把二进制数据转换为图片image
    self.image = [UIImage imageWithData:data];
}

@end
