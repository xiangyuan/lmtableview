//
//  LMFooter.h
//  LMTableView
//
//  Created by li yajie on 12-9-5.
//  Copyright (c) 2012年 com.comee. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LMFooter;

@protocol LMFooterDelegate <NSObject>

@required

-(void)lmStartLoadingData:(LMFooter*) lmFootView;

-(void)lmLoadFinished:(LMFooter*)scrollView;

@end

@interface LMFooter : UIView

{
    UILabel * freshMsgLbl;
    UIActivityIndicatorView *indicator;
}

@property(nonatomic,assign) id<LMFooterDelegate> delegate;


#pragma mark-- public methods

-(void) lmFreshViewDidScroll:(UIScrollView*)scroollView;


-(void) lmFreshEndDragging:(UIScrollView*) scrollView;

-(void) lmFreshFinished:(UIScrollView*) scrollView;

@end

