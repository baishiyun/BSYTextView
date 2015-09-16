//
//  BSYPopView.h
//  DressUp
//
//  Created by chenchen on 15/9/9.
//  Copyright (c) 2015年 BSY. All rights reserved.
//

#import "MMPopupView.h"

@interface BSYPopView : MMPopupView
@property (nonatomic, strong) UIView      *backView;
@property (nonatomic, strong) UILabel     *titleLab;
@property (nonatomic, strong) UILabel     *muentitleLab;
@property (nonatomic ,strong) UIView      *appview;
@property (nonatomic, strong) UIButton    *btnClose;
@property (nonatomic, strong) UIButton    *muenButton;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *imageArrayOut;
@property (nonatomic, strong) NSMutableArray *titleArray;
@end
