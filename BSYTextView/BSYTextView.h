//
//  BSYTextView.h
//  BSYTextView
//
//  Created by chenchen on 15/9/15.
//  Copyright (c) 2015年 BSY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSYTextView : UIView<UITextViewDelegate>
@property (nonatomic,strong)UITextView *bsy_textView;
@property (nonatomic,strong)UILabel *bsy_occupyLab;
@property (nonatomic,strong)UILabel *bsy_textCountCue;
@end
