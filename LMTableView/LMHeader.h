//
//  LMHeader.h
//  LMTableView
//
//  Created by li yajie on 12-9-5.
//  Copyright (c) 2012年 com.comee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  {
    LMHeaderStateNormal = 0,//normal state
    LMHeaderStateLoading = 1,
    LMHeaderStatePull = 2//下拉拖动状态
} LMHeaderState;

#define LMHEADER_HEIGHT 52.0f


@interface LMHeader : UIView
{
    UILabel * messageToShow;
    UIActivityIndicatorView * indicatorView;
    UILabel * lastUpdateTime;
    UIImageView * pullArrow;
}

@property(nonatomic,retain) UILabel * messageToShow;

@property(nonatomic,retain) UIActivityIndicatorView * indicatorView;

@property(nonatomic,retain) UILabel * lastUpdateTime;

@property(nonatomic,retain) UIImageView *pullArrow;

@property(nonatomic,assign) LMHeaderState headerSate;


@end
