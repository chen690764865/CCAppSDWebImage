//
//  UIImageView+CCImageView.m
//  仿SDWebImage
//
//  Created by chenchen on 16/8/2.
//  Copyright © 2016年 chenchen. All rights reserved.
//

#import "UIImageView+CCImageView.h"
#import "CCDownloadManager.h"
#import "AFHTTPSessionManager.h"
#import <objc/runtime.h>

const char *kUrlString = "kUrlString";

@implementation UIImageView (CCImageView)

/**
 解决图片错乱的问题
 每次下载图片的时候记录图片url字符串,在开始下载的时候判断当前下载图片的url字符串和记录的是否相同,如果相同的取消之前下载操作
 
 */
- (void)cc_setImageWithURLString:(NSString*)urlString placeholderImage:(UIImage*)placeholderImage
{
    
    //1.判断记录的图片
    if (self.urlString != nil && [urlString isEqualToString:self.urlString]) {
        NSLog(@"之前的操作被取消掉了");
        // 取消掉之前的下载操作
        // 如何才能取到之前的下载地址 --> 在每一次下载的时候,将下载地址保存一下
        /**
         1. 下载`爸爸去哪儿`的时候,将该图片地址保存起来
         2. 当用户滑动到最上面的时候,又会去下载植物,在这个时候就可以取到上一次的下载地址
         3. 再通过地址去取消`爸爸去哪儿`的下载操作
         
         */
        [[CCDownloadManager sharedManager] cancelOperationWithUrlString:urlString];
    }
    
    self.urlString = urlString;
    
    //获取下载管理器的单例对象去下载图片
    [[CCDownloadManager sharedManager] downloadImageWithURLString:urlString completion:^(UIImage *image) {
        self.image = image;
        //如果当前图片已经下载成功,那么就不需要再保存图片地址了,因为下一次再进来的时候就应该去下载另外一个图片了
        self.urlString = nil;
    }];
    
}

/**
 1.想要在给分类添加属性的话就要使用对象关联
 2.重写set/get方法
 */
-(NSString *)urlString{
    return objc_getAssociatedObject(self, kUrlString);
}

-(void)setUrlString:(NSString *)urlString{
    // 使用对象关联 --> 属于运行时里面的东西 --> 应用场景就是在分类中,定义属性,给当前对象保存值
    /**
     参数
     1. 要给谁关联
     2. 关联的key
     3. 关联的值
     4. 关联策略
     
     
     OBJC_ASSOCIATION_ASSIGN = 0,
     OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1, < Specifies a strong reference to the associated object.
     *   The association is not made atomically.
     OBJC_ASSOCIATION_COPY_NONATOMIC = 3,   < Specifies that the associated object is copied.
     *   The association is not made atomically.
     OBJC_ASSOCIATION_RETAIN = 01401,       < Specifies a strong reference to the associated object.
     *   The association is made atomically.
     OBJC_ASSOCIATION_COPY = 01403          < Specifies that the associated object is copied.
     *   The association is made atomically.
     */
    
    objc_setAssociatedObject(self, kUrlString, urlString, OBJC_ASSOCIATION_COPY_NONATOMIC);

}

@end
