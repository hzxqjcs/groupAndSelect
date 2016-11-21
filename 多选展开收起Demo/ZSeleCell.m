//
//  ZSeleCell.m
//  多选展开收起Demo
//
//  Created by 青戟沉沙 on 2016/11/17.
//  Copyright © 2016年 黄祖祥. All rights reserved.
//

#import "ZSeleCell.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation ZSeleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.leftBtn setImage:[UIImage imageNamed:@"checkbox_r_false"] forState:UIControlStateNormal];
        [self.leftBtn setImage:[UIImage imageNamed:@"checkbox_r_true"] forState:UIControlStateSelected];
        self.leftBtn.frame = CGRectMake(15, 10, 18, 18);
        [self addSubview:self.leftBtn];
        
        self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, SCREEN_WIDTH - 50, 18)];
        [self addSubview:self.nameLable];
        self.nameLable.textAlignment = NSTextAlignmentLeft;
        
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
