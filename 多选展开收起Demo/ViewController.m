//
//  ViewController.m
//  多选展开收起Demo
//
//  Created by 青戟沉沙 on 2016/11/17.
//  Copyright © 2016年 黄祖祥. All rights reserved.
//

#import "ViewController.h"
#import "ZSeleCell.h"
#import "ZseleHeadView.h"
#define SCREEN_WIDTH self.view.frame.size.width
#define SCREEN_HEIGHT self.view.frame.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataList;
}
@property (nonatomic, strong) NSMutableArray *showSectionArray;//该组是否展示
@property (nonatomic, strong) NSMutableArray *seleStudentArray;//该生是否被选中
@property (nonatomic, strong) NSMutableArray *seleClassArray;//该组是否被选中
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger currSection;
@property (nonatomic, assign) NSInteger currRow;
@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showSectionArray = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3", nil];
    self.seleClassArray = [NSMutableArray array];
    self.seleStudentArray = [NSMutableArray array];

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-40) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    
    UIButton *subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [subBtn setTitle:@"提交" forState:UIControlStateNormal];
    subBtn.frame = CGRectMake(0, 20, SCREEN_WIDTH, 20);
    subBtn.backgroundColor = [UIColor redColor];
    [subBtn addTarget:self action:@selector(subMit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:subBtn];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self hasShowSection:section]) {
        return 0;
    }else{
        if (section==0) {
            return 3;
        }
        else if (section==1) {
            return 5;
        }
        else if (section==2) {
            return 6;
        }
        return 8;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZSeleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"idcell"];
    if (!cell) {
        cell = [[ZSeleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"idcell"];
    }
    cell.nameLable.text = [NSString stringWithFormat:@"第%ld个学生",(long)indexPath.row];
    if ([self hasShowSeleRow:indexPath] ) {
        cell.leftBtn.selected = YES;
    }else{
        cell.leftBtn.selected = NO;
    }
    [cell.leftBtn addTarget:self action:@selector(addSele:) forControlEvents:UIControlEventTouchUpInside];
    cell.leftBtn.tag = 100*indexPath.section+indexPath.row;
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(cellLongPress:)];
    [cell addGestureRecognizer:longPressGesture];
    
    return cell;
}

- (void)cellLongPress:(UIGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        CGPoint location = [recognizer locationInView:self.tableView];
//        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
        ZSeleCell *cell = (ZSeleCell *)recognizer.view;
        
        [cell becomeFirstResponder];
        UIMenuItem *itPhone = [[UIMenuItem alloc]initWithTitle:@"电话" action:@selector(handlePhoneCell:)];
        UIMenuItem *itChat = [[UIMenuItem alloc]initWithTitle:@"聊天" action:@selector(handelChatCell:)];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuItems:[NSArray arrayWithObjects:itPhone,itChat, nil]];
        [menu setTargetRect:cell.frame inView:self.tableView];
        [menu setMenuVisible:YES animated:YES];
        
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(handelChatCell:)) {
        return YES;
    }
    else if (action == @selector(handlePhoneCell:)) {
        return YES;
    }
    return [super canPerformAction:action withSender:sender];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)handlePhoneCell:(id)sender
{
    NSLog(@"phone");
}

- (void)handelChatCell:(id)sender
{
    NSLog(@"chat");
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.currSection = indexPath.section;
    self.currRow = indexPath.row;
    button.tag = 100*indexPath.section + indexPath.row;
    [self addSele:button];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 38;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ZseleHeadView * headView = [[ZseleHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30) WithSection:section];
    headView.showBtn.selected = [self hasShowSection:section];
    [headView.showBtn addTarget:self action:@selector(addShowSec:) forControlEvents:UIControlEventTouchUpInside];
    
    headView.seleClassBtn.selected = [self hasShowSeleClass:section];
    [headView.seleClassBtn addTarget:self action:@selector(addClassSele:) forControlEvents:UIControlEventTouchUpInside];
    if ([self hasShowSection:section]) {
        headView.seleImageView.transform = CGAffineTransformMakeRotation(M_PI * 0);
    }else{
        headView.seleImageView.transform = CGAffineTransformMakeRotation(M_PI * (0.5));
    }
    return headView;
}

#pragma mark 该组是否展示
-(BOOL)hasShowSection:(NSInteger)section{
    for (int i =0; i < self.showSectionArray.count; i++) {
        NSInteger show = [self.showSectionArray[i] integerValue];
        if (show == section) {
            return YES;
        }
    }
    return NO;
}

#pragma mark 该学生是否选中
-(BOOL)hasShowSeleRow:(NSIndexPath *)index{
    NSLog(@"studentArray:%@",self.seleStudentArray);
    for (int i =0; i < self.seleStudentArray.count; i++) {
        NSIndexPath * show = self.seleStudentArray[i] ;
        if (show == index) {
            return YES;
        }
    }
    return NO;
}

#pragma mark 该组是否全部选中
-(BOOL)hasShowSeleClass:(NSInteger)section{
    for (int i =0; i < self.seleClassArray.count; i++) {
        NSInteger show = [self.seleClassArray[i] integerValue];
        if (show == section) {
            return YES;
        }
    }
    return NO;
}

#pragma mark 该组选中人数
-(NSInteger)numberOfSeleForClass:(NSInteger)section{
    NSInteger stuNum = 0;
    for (NSIndexPath * path in self.seleStudentArray) {
        if (path.section == section) {
            stuNum ++;
        }
    }
    return stuNum;
}

#pragma mark 添加展示的组
-(void)addShowSec:(UIButton *)button{
    NSLog(@"bool:%d",button.selected);
    button.selected = !button.selected;
    NSNumber * number = [NSNumber numberWithInteger:button.tag - 1000];
    if (button.selected == YES) {
        NSString *num = [NSString stringWithFormat:@"%@",number];
        [self.showSectionArray addObject:num];
    }else{
        NSString *num = [NSString stringWithFormat:@"%@",number];
        [self.showSectionArray removeObject:num];
    }
//    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:[number integerValue]] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView reloadData];
}

#pragma mark 添加学生
-(void)addSele:(UIButton *)button{
    NSInteger section = button.tag/100;
    NSInteger row = button.tag%100;
    NSIndexPath * path = [NSIndexPath indexPathForItem:row inSection:section];
    ZSeleCell * cell = (ZSeleCell *)[self tableView:self.tableView cellForRowAtIndexPath:path];
    cell.leftBtn.selected = !cell.leftBtn.selected;
    if (cell.leftBtn.selected) {
        [self.seleStudentArray addObject:path];
        switch (section) {
            case 0:{
                if ([self numberOfSeleForClass:section] == 3) {
                    [self.seleClassArray addObject:[NSNumber numberWithInteger:section]];
                }
            }
                break;
            case 1:{
                if ([self numberOfSeleForClass:section] == 5) {
                    [self.seleClassArray addObject:[NSNumber numberWithInteger:section]];
                }
            }
                break;
            case 2:{
                if ([self numberOfSeleForClass:section] == 6) {
                    [self.seleClassArray addObject:[NSNumber numberWithInteger:section]];
                }
            }
                break;
            case 3:{
                if ([self numberOfSeleForClass:section] == 8) {
                    [self.seleClassArray addObject:[NSNumber numberWithInteger:section]];
                }
            }
                break;
            default:
                break;
        }
    }else{
        [self.seleStudentArray removeObject:path];
        [self.seleClassArray removeObject:[NSNumber numberWithInteger:section]];
    }
    NSIndexSet *index = [NSIndexSet indexSetWithIndex:section];
    [self.tableView reloadSections:index withRowAnimation:UITableViewRowAnimationAutomatic];
//        [self.tableView reloadData];
}

#pragma mark 添加选中班级
-(void)addClassSele:(UIButton *)button{
    button.selected = !button.selected;
    NSNumber *number = [NSNumber numberWithInteger:button.tag - 1000000];
    NSInteger section = [number integerValue];
    if (button.selected == YES) {
        [self.seleClassArray addObject:number];
        switch (section) {
            case 0:{
                for (int i = 0; i < 3; i ++) {
                    NSIndexPath * path = [NSIndexPath indexPathForItem:i inSection:[number integerValue]];
                    if ([self hasShowSeleRow:path]) {
                        [self.seleStudentArray removeObject:path];
                    }
                    [self.seleStudentArray addObject:path];
                }
            }
                break;
            case 1:{
                for (int i = 0; i < 5; i ++) {
                    NSIndexPath * path = [NSIndexPath indexPathForItem:i inSection:[number integerValue]];
                    if ([self hasShowSeleRow:path]) {
                        [self.seleStudentArray removeObject:path];
                    }
                    [self.seleStudentArray addObject:path];
                }
            }
                break;
            case 2:{
                for (int i = 0; i < 6; i ++) {
                    NSIndexPath * path = [NSIndexPath indexPathForItem:i inSection:[number integerValue]];
                    if ([self hasShowSeleRow:path]) {
                        [self.seleStudentArray removeObject:path];
                    }
                    [self.seleStudentArray addObject:path];
                }
            }
                break;
            case 3:{
                for (int i = 0; i < 8; i ++) {
                    NSIndexPath * path = [NSIndexPath indexPathForItem:i inSection:[number integerValue]];
                    if ([self hasShowSeleRow:path]) {
                        [self.seleStudentArray removeObject:path];
                    }
                    [self.seleStudentArray addObject:path];
                }
            }
                break;
            default:
                break;
        }
        
    }else{
        [self.seleClassArray removeObject:number];
        switch (section) {
            case 0:{
                for (int i = 0; i < 3; i ++) {
                    NSIndexPath * path = [NSIndexPath indexPathForItem:i inSection:[number integerValue]];
                    [self.seleStudentArray removeObject:path];
                }
            }
                break;
            case 1:{
                for (int i = 0; i < 5; i ++) {
                    NSIndexPath * path = [NSIndexPath indexPathForItem:i inSection:[number integerValue]];
                    [self.seleStudentArray removeObject:path];
                }
            }
                break;
            case 2:{
                for (int i = 0; i < 6; i ++) {
                    NSIndexPath * path = [NSIndexPath indexPathForItem:i inSection:[number integerValue]];
                    [self.seleStudentArray removeObject:path];
                }
            }
                break;
            case 3:{
                for (int i = 0; i < 8; i ++) {
                    NSIndexPath * path = [NSIndexPath indexPathForItem:i inSection:[number integerValue]];
                    [self.seleStudentArray removeObject:path];
                }
            }
                break;
            default:
                break;
        }
    }
    [self.tableView reloadData];
}

-(void)subMit
{
    for (NSIndexPath * path in self.seleStudentArray) {
        NSLog(@"第%ld班级   第%ld个学生被选中",(long)path.section,(long)path.row);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
