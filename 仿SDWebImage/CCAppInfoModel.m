//
//  CCAppInfoModel.m
//  仿SDWebImage
//
//  Created by chenchen on 16/8/1.
//  Copyright © 2016年 chenchen. All rights reserved.
//

#import "CCAppInfoModel.h"

@implementation CCAppInfoModel
+(instancetype)appInfoModelWithDictionary:(NSDictionary *)dict{
    
    //获取模型对象
    CCAppInfoModel *infoModel = [[CCAppInfoModel alloc] init];
    
    //KVC
    [infoModel setValuesForKeysWithDictionary:dict];
    
    return infoModel;
}

//数据缺少会调动下面的方法
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
