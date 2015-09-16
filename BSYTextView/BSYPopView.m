//
//  BSYPopView.m
//  DressUp
//
//  Created by chenchen on 15/9/9.
//  Copyright (c) 2015年 BSY. All rights reserved.
//
#define IPhone5 [ [ UIScreen mainScreen ] bounds ].size.height

#import "BSYPopView.h"
#import "MMPopupItem.h"
#import "MMPopupCategory.h"
#import "MMPopupDefine.h"
#import "MMPopupWindow.h"
#import "Masonry.h"
#import "UIView+BSYLayout.h"
@implementation BSYPopView
- (instancetype)init
{
    self = [super init];
    
    if ( self )
    {
        self.type = MMPopupTypeCustom;
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            if (IPhone5>568) {
                 make.size.mas_equalTo(CGSizeMake(300,430));
            }else{
             make.size.mas_equalTo(CGSizeMake(260,400));
            }
           
        }];

        //背景视图
        self.backView = [[UIView alloc]init];
        [self addSubview:self.backView];
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.backgroundColor  =[UIColor whiteColor];
        self.layer.cornerRadius=5;
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
       
        //关闭按钮
        self.btnClose = [UIButton mm_buttonWithTarget:self action:@selector(actionClose)];
        [self.backView addSubview:self.btnClose];
        [self.btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self.backView).insets(UIEdgeInsetsMake(0, 0, 0, 5));
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        [self.btnClose setBackgroundImage:[UIImage imageNamed:@"tc_icon_delete"] forState:UIControlStateNormal];
        
        //标题
        self.titleLab = [UILabel new];
        [self.backView addSubview:self.titleLab];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.backView).insets(UIEdgeInsetsMake(0, 19, 0, 19));
            make.height.equalTo(@50);
        }];
        self.titleLab.font = [UIFont boldSystemFontOfSize:11];
        self.titleLab.text = @"请你选择你喜欢的单品类型";
        self.titleLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        
        //线条
        UILabel *xian = [[UILabel alloc]init];
        [self.backView addSubview:xian];
        xian.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.5];
        [xian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backView).with.offset(50);
            make.left.equalTo(self.backView).with.offset(0);
            make.bottom.equalTo(self.backView).with.offset(-379);
            make.right.equalTo(self.backView).with.offset(0);
        }];
        
        //购买链接提示
        UILabel * buy= [[UILabel alloc]init];
        buy.text = @"拍摄者受到请求后就会公布出相应单品的购买链接哦";
        buy.font = [UIFont boldSystemFontOfSize:9];
        buy.textColor = [UIColor colorWithRed:73/255.0 green:183/255.0 blue:138/255.0 alpha:1.0];
        buy.textAlignment = NSTextAlignmentCenter;
        [self.backView addSubview:buy];
        [buy mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.backView).insets(UIEdgeInsetsMake(50, 0, 0, 0));
            make.height.equalTo(@50);
        }];
        
        //九宫格布局
        //三列
        int totalloc=3;
        CGFloat appvieww=60;
        CGFloat appviewh=60;
        CGFloat margin=0.0;
        if (IPhone5>568) {
            margin=(300-totalloc*appvieww)/(totalloc+1);
        }else{
            margin=(260-totalloc*appvieww)/(totalloc+1);
        }
        
        int count=9;
        for (int i=0; i<count; i++) {
            
            int row=i/totalloc;//行号
            int loc=i%totalloc;//列号
            
            CGFloat appviewx=margin+(margin+appvieww)*loc;
            CGFloat appviewy=margin+(margin+appviewh)*row+80;
           
            UIView *appview=[[UIView alloc]init];
            appview.layer.borderColor = [UIColor orangeColor].CGColor;
            appview.layer.borderWidth = 1;
            appview.frame = CGRectMake(appviewx, appviewy, appvieww, appviewh);
            [self.backView addSubview:appview];
            appview.tag = i;
            self.appview = appview;
            
            //创建uiview控件中的子视图
            UIButton *appimageview=[UIButton buttonWithType:UIButtonTypeCustom];
            appimageview.frame =CGRectMake(5, 0, 50, 50);
            [appimageview setBackgroundImage:[UIImage imageNamed:self.imageArrayOut[i]] forState:UIControlStateNormal];
            [appview addSubview:appimageview];
            [appimageview addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            appimageview.tag =i;
            self.muenButton = appimageview;
            
             UILabel *applable=[[UILabel alloc]initWithFrame:CGRectMake(0, 40, appview.width, 20)];
             [applable setText: self.titleArray[i]];
            applable.tag = i;
            self.muentitleLab = applable;
            [applable setTextAlignment:NSTextAlignmentCenter];
            [applable setTextColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]];
            [applable setFont:[UIFont systemFontOfSize:9.0]];
            [appview addSubview:applable];
        }

        
        //求详情
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (IPhone5>568) {
            button.frame = CGRectMake(125, 365, 50, 50);
        }else{
        button.frame = CGRectMake(110, 335, 50, 50);
        }
        
        [button setTitle:@"求详情" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.layer.backgroundColor = [UIColor colorWithRed:71/255.0 green:180/255.0 blue:136/255.0 alpha:1.0].CGColor;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor clearColor].CGColor;
        button.layer.cornerRadius = 25;
        [self.backView addSubview:button];
        [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
}

- (void)startCountDown
{
    [self stopCountDown];
    
    [self checkCountDown];
}

- (void)stopCountDown
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(checkCountDown) object:nil];
}

- (void)checkCountDown
{
    
}

- (void)actionClose
{
    [self hide];
}

- (void)actionResend
{
    [self startCountDown];
}


-(void)buttonClick:(UIButton *)button
{
    self.muenButton = button;
    self.muentitleLab.tag = button.tag;
    if (self.muenButton.selected) {
        self.muentitleLab.textColor = [UIColor orangeColor];
    }
    [self.muenButton setBackgroundImage:[UIImage imageNamed:self.imageArray[button.tag]] forState:UIControlStateNormal];

}


-(void)buttonClick

{
    
    NSLog(@"，妈的");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSMutableArray arrayWithObjects:@"tc_icon_01_moveon",@"tc_icon_02_moveon",@"tc_icon_03_moveon",@"tc_icon_04_moveon",@"tc_icon_05_moveon",@"tc_icon_06_moveon",@"tc_icon_07_moveon",@"tc_icon_08_moveon",@"tc_icon_09_moveon", nil];
    }
    return _imageArray;
}
-(NSMutableArray *)imageArrayOut
{
    
    if (!_imageArrayOut) {
        _imageArrayOut = [NSMutableArray arrayWithObjects:@"tc_icon_01_moveout",@"tc_icon_02_moveout",@"tc_icon_03_moveout",@"tc_icon_04_moveout",@"tc_icon_05_moveout",@"tc_icon_06_moveout",@"tc_icon_07_moveout",@"tc_icon_08_moveout",@"tc_icon_09_moveout", nil];
    }
    return _imageArrayOut;
}
-(NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"上衣",@"裤子",@"裙子",@"内衣",@"鞋子",@"包包",@"头饰",@"配饰",@"其他", nil];
    }
    return _titleArray;
}
@end
