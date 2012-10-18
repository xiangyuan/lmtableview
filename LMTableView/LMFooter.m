//
//  LMFooter.m
//  LMTableView
//
//  Created by li yajie on 12-9-5.
//  Copyright (c) 2012年 com.comee. All rights reserved.
//

#import "LMFooter.h"


#define FIXEDGE 1.f
#define LMFOOTER_HEIGHT 65.f


enum FootState {
    FOOTSHOWSTATE = 1,
    FOOTHIDSTATE = 2
};

typedef enum FootState LMFootState;


@implementation LMFooter

@synthesize delegate;

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


-(void) changeShowOfFooter:(LMFootState) state {
    if (state == FOOTSHOWSTATE) {
        [UIView animateWithDuration:0.3 animations:^{
            freshMsgLbl.text = @"正在刷新中...";
            indicator.hidden = NO;
            [indicator startAnimating];
        }];
    } else if (state == FOOTHIDSTATE) {
        [UIView animateWithDuration:.3 animations:^{
            freshMsgLbl.text = @"";
            [indicator stopAnimating];
            indicator.hidden = YES;
        }];
    }
}
/*
 scroll did
 */
-(void)lmFreshViewDidScroll:(UIScrollView *)scroollView {
    if (scroollView.contentOffset.y + scroollView.frame.size.height >= scroollView.contentSize.height + FIXEDGE) {
        if ([delegate respondsToSelector:@selector(lmStartLoadingData:)]) {
            self.frame = CGRectMake(0.f, scroollView.contentSize.height, 320.f, LMFOOTER_HEIGHT);
            [self changeShowOfFooter:FOOTSHOWSTATE];
            scroollView.contentInset = UIEdgeInsetsMake(0.f, 0.f, 85.f, 0.f);
            [delegate lmStartLoadingData:self];
        }
    }
}


/*
 scroll end dragging
 */
-(void)lmFreshEndDragging:(UIScrollView *)scrollView {
}


-(void)lmFreshFinished:(UIScrollView *)scrollView {
    if ([delegate respondsToSelector:@selector(lmLoadFinished:)]) {
        [self changeShowOfFooter:FOOTHIDSTATE];
        scrollView.contentInset = UIEdgeInsetsZero;
        [delegate lmLoadFinished:self];
    }
}

- (void)dealloc
{
    delegate = nil;
    freshMsgLbl = nil;
    indicator = nil;
    [super dealloc];
}

@end
