//
//  CodeTableViewCell.m
//  
//
//  Created by rimi on 15/6/11.
//
//

#import "CodeTableViewCell.h"

@implementation CodeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 两种布局方式
        // 1. 绝对布局
        // 2. 自动布局（AutoLayout)
        
        // 需要注意视图加载到self.contentView上
        
    }
    return self;
}
//在该方法中显示当前正确大小
- (void)layoutSubviews
{
    [super layoutSubviews];
}
@end
