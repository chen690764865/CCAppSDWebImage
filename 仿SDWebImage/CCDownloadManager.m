//
//  CCDownloadManager.m
//  仿SDWebImage
//
//  Created by chenchen on 16/8/2.
//  Copyright © 2016年 chenchen. All rights reserved.
//

#import "CCDownloadManager.h"
#import "CCDownloadOperation.h"
#import "NSString+path.h"

@interface CCDownloadManager ()
/**
 *  图片缓存
 */
@property (nonatomic, strong) NSMutableDictionary* imageCache;
/**
 *  操作缓存
 */
@property (nonatomic, strong) NSMutableDictionary* operationCache;
/**
 *  全局队列
 */
@property (nonatomic, strong) NSOperationQueue* queue;
@end

@implementation CCDownloadManager

+ (instancetype)sharedManager
{

    //初始化一个全局的静态变量
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CCDownloadManager alloc] init];
    });
    return instance;
}

- (void)downloadImageWithURLString:(NSString*)urlString completion:(void (^)(UIImage* image))completion
{
    //断言:可以判断condition条件是否成立,如果不成立,程序会崩溃
    NSAssert(completion != nil, @"必须传入回调的block");

    //1.判断内存缓存中是否有图片
    UIImage* imageCache = self.imageCache[urlString];
    if (imageCache) {
        NSLog(@"从内存缓存中取图片!");
        completion(imageCache);
        return;
    }

    //2.内存没有的话,判断沙盒中是否有图片
    //2.1 取到沙盒路径 然后把图片取出来
    NSString* cachePath = [urlString appendCachePath];
    imageCache = [UIImage imageWithContentsOfFile:cachePath];
    if (imageCache) {
        NSLog(@"从沙盒中取图片!");
        //2.2 如果沙盒中有使用block进行回调
        completion(imageCache);
        //2.3 同时保存一份到内存缓存中
        [self.imageCache setObject:imageCache forKey:urlString];
        return;
    }

    //3.沙盒中也没有图片的话,初始化一个操作去下载图片,下载图片之前判断操作缓存中是否已经有操作在下载图片,如果有的话提示用户已经在下载图片了请稍等,没有的话再去初始化操作去下载图片,下载开始的时候把操作保存到操作缓存中一份,在下载完成以后,把当前操作移除
    if (self.operationCache[urlString]) {
        NSLog(@"图片正在加载请稍等");
        return;
    }
    NSLog(@"初始化了一个操作下载图片");
    //1.初始化一个自定义操作
    CCDownloadOperation* op = [CCDownloadOperation operationWithURLString:urlString];
    
    __weak CCDownloadOperation *weakOP = op;
    //2.监听图片下载完成
    [op setCompletionBlock:^{
        NSLog(@"图片下载完成");

        //3.取到图片
        UIImage* image = weakOP.image;
        //4.图片下载完成之后,回到主线程更新数据
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{

            //如果图片有值的话,保存到内存中一份
            if (image != nil) {
                [self.imageCache setObject:image forKey:urlString];
            }
            completion(image);

            //将当前操作从缓存中移除
            [self.operationCache removeObjectForKey:urlString];
        }];
    }];

    //5.下载图片的时候,把当前操作缓存到操作缓存中一份,以避免连续拖动的时候重复下载图片的问题
    [self.operationCache setObject:op forKey:urlString];
    //6.操作添加到队列中
    [self.queue addOperation:op];
}

#pragma mark - 懒加载
/**
 *  图片缓存的懒加载
 *
 *  @return <#return value description#>
 */
- (NSMutableDictionary*)imageCache
{
    if (_imageCache == nil) {
        _imageCache = [NSMutableDictionary dictionary];
    }
    return _imageCache;
}

/**
 *  操作缓存的懒加载
 *
 *  @return <#return value description#>
 */
- (NSMutableDictionary*)operationCache
{
    if (_operationCache == nil) {
        _operationCache = [NSMutableDictionary dictionary];
    }
    return _operationCache;
}

/**
 *  全局队列的懒加载
 */
- (NSOperationQueue*)queue
{
    if (_queue == nil) {
        _queue = [NSOperationQueue new];
    }
    return _queue;
}
@end
