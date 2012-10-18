//
//  ScrollFooterController.m
//  LMTableView
//
//  Created by li yajie on 12-9-13.
//  Copyright (c) 2012年 com.comee. All rights reserved.
//

#import "ScrollFooterController.h"
#define LMFOOTER_HEIGHT 65.f
#define FOOT_CONTENTINSETS 85.f

@interface ScrollFooterController ()
{
    LMFooter * footer;
    UITableView * mTable;
    NSMutableArray * datasource;
    BOOL isLoading;
}
@end

@implementation ScrollFooterController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        datasource = [[NSMutableArray alloc]init];
        isLoading = FALSE;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    mTable = [[UITableView alloc]initWithFrame:CGRectMake(0.f, 0.f, 320.f, 480.f)];
    mTable.backgroundColor = [UIColor clearColor];
    mTable.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    mTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    mTable.dataSource = self;
    mTable.delegate = self;
    footer = [[LMFooter alloc]initWithFrame:CGRectMake(0.f, mTable.bounds.size.height, 320.f, LMFOOTER_HEIGHT)];
    footer.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    footer.delegate = self;
    [mTable addSubview:footer];
    [footer release];
    [self.view addSubview:mTable];
    [mTable release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
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
#pragma scroll
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (isLoading) {
        return;
    }
    [footer lmFreshViewDidScroll:scrollView];
}

#pragma mark 
-(void)lmStartLoadingData:(LMFooter *)lmFootView {
    //网络请求
    isLoading = TRUE;
    [self performSelector:@selector(updateUI) withObject:nil afterDelay:3];//3 seconds over
}

-(void) lmLoadFinished:(LMFooter *)scrollView {
    NSLog(@"reload data");
    // update table
}

-(void) updateUI {
    isLoading = FALSE;
    [footer lmFreshFinished:mTable];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [datasource release];
    [mTable release];
    [footer release];
    [super dealloc];
}

@end
