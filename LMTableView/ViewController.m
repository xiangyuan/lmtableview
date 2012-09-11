//
//  ViewController.m
//  LMTableView
//
//  Created by li yajie on 12-9-5.
//  Copyright (c) 2012年 com.comee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    datasource = [[NSMutableArray alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
    mTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.f, 0.f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    mTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    mTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    mTableView.delegate = self;
    mTableView.dataSource = self;
    [self.view addSubview:mTableView];
    lmHeader = [[LMHeader alloc] initWithFrame:CGRectMake(0, -LMHEADER_HEIGHT, 320.f, LMHEADER_HEIGHT)];
    lmHeader.headerSate = LMHeaderStateNormal;
    [lmHeader.indicatorView setHidden:YES];
    [lmHeader.indicatorView stopAnimating];
    //mTableView.scrollEnabled = YES;
    lmHeader.backgroundColor = [UIColor clearColor];
    [mTableView addSubview:lmHeader];
    [lmHeader release];
    [mTableView release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
#pragma delegate of the tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [datasource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * simpleIndentifier = @"simpleIndentifier";
    UITableViewCell * cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:simpleIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleIndentifier];
        
    }
    cell.textLabel.text = [datasource objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma delegate of the scroll view
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (lmHeader.headerSate == LMHeaderStateLoading) {//正在加载中
        return;
    }
    else {
        lmHeader.headerSate = LMHeaderStatePull;
    }
}
#pragma scroll of did drag
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (lmHeader.headerSate == LMHeaderStateLoading) {
        if (scrollView.contentOffset.y > 0) {
            mTableView.contentInset = UIEdgeInsetsZero;
        } else if (scrollView.contentOffset.y >= -LMHEADER_HEIGHT) {
            mTableView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
    } else if (lmHeader.headerSate == LMHeaderStatePull && scrollView.contentOffset.y < 0) {
        [self arrowAnimation:scrollView];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (lmHeader.headerSate == LMHeaderStateLoading) 
        return;
    if (scrollView.contentOffset.y <= -LMHEADER_HEIGHT) {
        [self performSelector:@selector(startLoadingAnimation)];
    }
}

//-(void) scrollToLocation {
//    mTableView.contentInset = UIEdgeInsetsMake(LMHEADER_HEIGHT, 0, 0, 0);
//}

-(void) arrowAnimation:(UIScrollView *) scrollView {
    if (scrollView.contentOffset.y < -LMHEADER_HEIGHT) {
        [UIView animateWithDuration:.3 animations:^{
            lmHeader.messageToShow.text = @"松开刷新";
            [lmHeader.pullArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        }];
    } else {
        [UIView animateWithDuration:.3 animations:^{
            lmHeader.messageToShow.text = @"下拉刷新";
            [lmHeader.pullArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0.f, 0.f, 1.f);
        }];
    }
}



-(void) startLoadingAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        lmHeader.headerSate = LMHeaderStateLoading;
        mTableView.contentInset = UIEdgeInsetsMake(LMHEADER_HEIGHT, 0.f, 0.f, 0.f);
        lmHeader.messageToShow.text = @"刷新中...";
        lmHeader.pullArrow.hidden = YES;
        lmHeader.indicatorView.hidden = NO;
        [lmHeader.indicatorView startAnimating];
    }];
    [self performSelector:@selector(loadingOver) withObject:nil afterDelay:3];
}

-(void) loadingOver {
    lmHeader.headerSate = LMHeaderStateNormal;
    [UIView animateWithDuration:0.3 animations:^{
        mTableView.contentInset = UIEdgeInsetsZero;
        [lmHeader.pullArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    }
     completion:^(BOOL finished) {
         [lmHeader.indicatorView stopAnimating];
         lmHeader.messageToShow.text = @"下拉刷新";
         lmHeader.pullArrow.hidden = NO;
         lmHeader.indicatorView.hidden = YES;
//         [self performSelector:@selector(stopLoadingComplete)];
     }];
}
- (void)dealloc
{
    [datasource release];
    [mTableView release];
    [super dealloc];
}
@end
