//
//  LMHeader.m
//  LMTableView
//
//  Created by li yajie on 12-9-5.
//  Copyright (c) 2012年 com.comee. All rights reserved.
//

#import "LMHeader.h"

@implementation LMHeader

@synthesize messageToShow;
@synthesize pullArrow;
@synthesize indicatorView;
@synthesize lastUpdateTime;
@synthesize headerSate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        messageToShow = [[UILabel alloc]initWithFrame:CGRectZero];
        messageToShow.backgroundColor = [UIColor clearColor];
        messageToShow.textAlignment = UITextAlignmentCenter;
        messageToShow.font = [UIFont systemFontOfSize:12.0f];
        messageToShow.text = @"下拉刷新";
        [self addSubview:messageToShow];
        [messageToShow release];
        pullArrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow.png"]];
        [self addSubview:pullArrow];
        [pullArrow release];
        indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
        indicatorView.hidden = YES;
        [self addSubview:indicatorView];
        [indicatorView release];
        lastUpdateTime = [[UILabel alloc]initWithFrame:CGRectZero];
        lastUpdateTime.backgroundColor = [UIColor clearColor];
        lastUpdateTime.textAlignment = UITextAlignmentCenter;
        lastUpdateTime.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:lastUpdateTime];
        [lastUpdateTime release];
        
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGRect frameRect = self.frame;
    messageToShow.frame = CGRectMake(0.0f, 0.0f, frameRect.size.width, LMHEADER_HEIGHT);
    lastUpdateTime.frame = CGRectMake(0.0f, 22.0f, frameRect.size.width, LMHEADER_HEIGHT - 22.0f);
    pullArrow.frame = CGRectMake(30.f, 4.f, 25.f, 44.f);
    indicatorView.frame =CGRectMake(40.f, 6.f, 20, 20.f);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)dealloc
{
    [lastUpdateTime release];
    [pullArrow release];
    [messageToShow release];
    [indicatorView release];
    [super dealloc];
}
@end
