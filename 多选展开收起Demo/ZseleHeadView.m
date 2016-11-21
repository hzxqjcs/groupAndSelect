//
//  ZseleHeadView.m
//  多选展开收起Demo
//
//  Created by 青戟沉沙 on 2016/11/17.
//  Copyright © 2016年 黄祖祥. All rights reserved.
//

#import "ZseleHeadView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
@implementation ZseleHeadView
-(instancetype)initWithFrame:(CGRect)frame WithSection:(NSInteger)section{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.frame;
        button.tag = 1000 + section;
        [button setTitle:[NSString stringWithFormat:@"      第%ld个班级",(long)section] forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:button];
        self.showBtn = button;
        
        UIButton * seleClassButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [seleClassButton setImage:[UIImage imageNamed:@"checkbox_r_false"] forState:UIControlStateNormal];
        [seleClassButton setImage:[UIImage imageNamed:@"checkbox_r_true"] forState:UIControlStateSelected];
        seleClassButton.tag = 1000000 + section;
        seleClassButton.frame = CGRectMake(SCREEN_WIDTH - 30, 6, 18, 18);
        [self addSubview:seleClassButton];
        self.seleClassBtn = seleClassButton;
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 12, 8)];
        [imageView setImage:[UIImage imageNamed:@"icon_triangle_right"]];
        
        [self addSubview:imageView];
        self.seleImageView = imageView;
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
