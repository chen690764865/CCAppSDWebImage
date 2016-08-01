//
//  ViewController.m
//  仿SDWebImage
//
//  Created by chenchen on 16/8/1.
//  Copyright © 2016年 chenchen. All rights reserved.
// https://raw.githubusercontent.com/yinqiaoyin/SimpleDemo/master/apps.json

#import "ViewController.h"
#import "AFHTTPSessionManager.h"
#import "CCAppInfoModel.h"
#import "CCAppInfoCell.h"

@interface ViewController ()
/**
 *  接收网络数据的全局数组
 */
@property(nonatomic,strong)NSMutableArray *infoData;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //获取网络数据
    [self loadData];
}

- (void)loadData
{

    //网络数据的url地址字符串
    NSString* urlString = @"https://raw.githubusercontent.com/yinqiaoyin/SimpleDemo/master/apps.json";

    //初始化一个网络请求的管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //获取数据
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求数据成功的回调
        NSLog(@"请求数据成功");
        //使用数组接收获取到的数据
        NSArray *tempArray = responseObject;
        //遍历获取到的临时数组数据
        for (NSDictionary *dict in tempArray) {
            //字典转模型
            CCAppInfoModel *info = [CCAppInfoModel appInfoModelWithDictionary:dict];
            //添加到全局数组属性中
            [self.infoData addObject:info];
        }
        NSLog(@"%@",self.infoData);
        //获取到数据以后刷新数据源
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求数据失败的回调
        NSLog(@"请求数据失败,请做相应处理");
    }];
}

#pragma mark - 数据源方法
//有多少cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infoData.count;
}

//cell内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //1.从缓存池中找cell
    CCAppInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    //2.缓存池中没有cell的话就会去创建cell 在sb中注册cell
    
    //3.cell内容
    
    //4.返回cell
    return cell;
}


#pragma mark - 懒加载
-(NSMutableArray *)infoData{
    if (_infoData == nil) {
        _infoData = [NSMutableArray array];
    }
    return _infoData;
}
@end
