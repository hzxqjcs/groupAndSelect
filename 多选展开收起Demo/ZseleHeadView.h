//
//  ZseleHeadView.h
//  多选展开收起Demo
//
//  Created by 青戟沉沙 on 2016/11/17.
//  Copyright © 2016年 黄祖祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZseleHeadView : UIView
@property(nonatomic,strong)UIButton *showBtn;
@property(nonatomic,strong)UIButton *seleClassBtn;
@property(nonatomic,strong)UIImageView * seleImageView;

-(instancetype)initWithFrame:(CGRect)frame WithSection:(NSInteger)section;
@end
