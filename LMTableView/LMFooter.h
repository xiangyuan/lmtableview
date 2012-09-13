//
//  LMFooter.h
//  LMTableView
//
//  Created by li yajie on 12-9-5.
//  Copyright (c) 2012年 com.comee. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
@protocol LMFooterDelegate <NSObject>

@optional
-(void)lmFooterBeginDragging:(UIScrollView *) scrollView;
-(void)lmFooterDidScroll:(UIScrollView*)scrollView;
-(void)lmfooterEndDragging:(UIScrollView*)scrollView;

@end
*/

@interface LMFooter : UIView

@property (nonatomic,retain) UIActivityIndicatorView *indicator;

@property (nonatomic,retain) UILabel *freshMsgLbl;

//@property(nonatomic,assign) id<LMFooterDelegate> footerDelegate;

@end
