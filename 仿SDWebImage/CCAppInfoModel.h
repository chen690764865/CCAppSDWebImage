//
//  CCAppInfoModel.h
//  仿SDWebImage
//
//  Created by chenchen on 16/8/1.
//  Copyright © 2016年 chenchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCAppInfoModel : NSObject
/**
 *  下载量
 */
@property(nonatomic,copy)NSString * download;
/**
 *  名字
 */
@property(nonatomic,copy)NSString * name;
/**
 *  图标
 */
@property(nonatomic,copy)NSString * icon;

+(instancetype)appInfoModelWithDictionary:(NSDictionary *)dict;

@end
