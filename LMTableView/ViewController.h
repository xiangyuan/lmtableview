//
//  ViewController.h
//  LMTableView
//
//  Created by li yajie on 12-9-5.
//  Copyright (c) 2012年 com.comee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMHeader.h"


@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * mTableView;
    NSMutableArray * datasource;
    LMHeader * lmHeader;
}
@end
