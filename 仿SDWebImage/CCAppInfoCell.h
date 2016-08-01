//
//  CCAppInfoCell.h
//  仿SDWebImage
//
//  Created by chenchen on 16/8/1.
//  Copyright © 2016年 chenchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCAppInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *downloadLabel;

@end
