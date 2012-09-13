//
//  LMFooter.m
//  LMTableView
//
//  Created by li yajie on 12-9-5.
//  Copyright (c) 2012年 com.comee. All rights reserved.
//

#import "LMFooter.h"

@implementation LMFooter

@synthesize indicator;
@synthesize freshMsgLbl;
//@synthesize footerDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        freshMsgLbl = [[UILabel alloc]initWithFrame:CGRectZero];
        freshMsgLbl.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        freshMsgLbl.backgroundColor = [UIColor clearColor];
        freshMsgLbl.font = [UIFont boldSystemFontOfSize:13.f];
        freshMsgLbl.textAlignment = UITextAlignmentCenter;
        [self addSubview:freshMsgLbl];
        [freshMsgLbl release];
        indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:indicator];
        indicator.hidden = YES;
        [indicator release];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)layoutSubviews {
    [super layoutSubviews];
    freshMsgLbl.frame = CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height);
    indicator.frame = CGRectMake(40.f, self.frame.size.height / 3, 24.f, 24.f);
}
- (void)dealloc
{
    [self setIndicator:nil];
    [self setFreshMsgLbl:nil];
    [super dealloc];
}

@end
