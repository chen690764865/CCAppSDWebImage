//
//  CCDownloadManager.h
//  仿SDWebImage
//
//  Created by chenchen on 16/8/2.
//  Copyright © 2016年 chenchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCDownloadManager : NSObject

/**
 *  实现单例的方法
 *
 *  @return 返回本类对象 无论何时何地创建出来都是同一个对象
 */
+(instancetype)sharedManager;

//给外界提供一个下载图片的对象方法
//注意异步的操作是无法直接给当前函数提供返回值的,需要使用block进行回调
/**
 *  提供给外界下载图片的方法,下载到的图片通过block中的UIImage参数进行回调
 *
 *  @param urlString  图片的url字符串地址
 *  @param completion 下载成功以后图片的回调
 */
-(void)downloadImageWithURLString:(NSString *)urlString completion:(void(^)(UIImage * image))completion;

@end
