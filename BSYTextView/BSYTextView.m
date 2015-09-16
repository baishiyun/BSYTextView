//
//  BSYTextView.m
//  BSYTextView
//
//  Created by chenchen on 15/9/15.
//  Copyright (c) 2015年 BSY. All rights reserved.
//

#import "BSYTextView.h"
#import "MMPopupItem.h"
#import "MMAlertView.h"
#import "MMPopupWindow.h"
@implementation BSYTextView

#define With [UIScreen mainScreen].bounds.size.width
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUIs];
    }
    return self;
}

-(void)creatUIs
{
 
    self.bsy_textView = [[UITextView alloc]initWithFrame:CGRectMake(20, 20, With-40, 200)];
    self.bsy_textView.delegate = self;
    self.bsy_textView.layer.borderWidth = 1;
    self.bsy_textView.layer.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0].CGColor;
    self.bsy_textView.layer.cornerRadius = 3;
    [self addSubview:self.bsy_textView];
    
    self.bsy_occupyLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 30)];
    self.bsy_occupyLab.text = @"说点什么……";
    self.bsy_occupyLab.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    self.bsy_occupyLab.font = [UIFont systemFontOfSize:11];
    [self.bsy_textView addSubview:self.bsy_occupyLab];
    
    self.bsy_textCountCue = [[UILabel alloc]initWithFrame:CGRectMake((With-100),  self.bsy_textView.frame.size.height+20, 100, 20)];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"你还可以输入120个字"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] range:NSMakeRange(0,6)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:74/255.0 green:183/255.0 blue:138/255.0 alpha:1] range:NSMakeRange(6,3)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] range:NSMakeRange(9,2)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(0, 6)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(6, 3)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(9, 2)];
    self.bsy_textCountCue.attributedText =str;
    [self addSubview:self.bsy_textCountCue];
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.bsy_occupyLab.hidden = YES;
    
}
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length<=120) {


        NSInteger count = 120-textView.text.length;
        
        
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",count],@"count", nil];
        //创建通知
        NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dict];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"你还可以输入%ld个字",(long)count]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] range:NSMakeRange(0,6)];
        
        
        if (textView.text.length<=20) {
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:74/255.0 green:183/255.0 blue:138/255.0 alpha:1] range:NSMakeRange(6,3)];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] range:NSMakeRange(9,2)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(0, 6)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(6, 3)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(9, 2)];
        }else if (textView.text.length>20){
            //    你还可以输入99个字
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:74/255.0 green:183/255.0 blue:138/255.0 alpha:1] range:NSMakeRange(6,4)];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] range:NSMakeRange(8,2)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(0, 6)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(6, 3)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(8, 2)];
        }else{
            //        你还可以输入9个字
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:74/255.0 green:183/255.0 blue:138/255.0 alpha:1] range:NSMakeRange(6,5)];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] range:NSMakeRange(7,2)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(0, 6)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(6, 5)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(7, 2)];
            
        }
        self.bsy_textCountCue.attributedText =str;
    
    }
    return;

    
}

//-(void)addAttribute:()
-(void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"textViewDidEndEditing");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty im-plementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
