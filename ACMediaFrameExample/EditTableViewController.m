//
//  EditTableViewController.m
//  ACMediaFrameExample
//
//  Created by caoyq on 2017/3/26.
//  Copyright © 2017年 ArthurCao. All rights reserved.
//

#import "EditTableViewController.h"
#import "ACMediaFrame.h"

@interface EditTableViewController ()

/** ACSelectMediaView object */
@property (nonatomic, weak) ACSelectMediaView *mediaView;

@end

@implementation EditTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    CGFloat height = [ACSelectMediaView defaultViewHeight];
    UIView *headerView = [[UIView alloc] init];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, 20)];
    lab.text = @"展示区域";
    [headerView addSubview:lab];
    
    ACSelectMediaView *mediaView = [[ACSelectMediaView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lab.frame) + 10, CGRectGetWidth(lab.frame), height)];
    mediaView.showDelete = NO;
    mediaView.showAddButton = NO;
    mediaView.preShowMedias = @[@"bg_1", @"bg_2", @"bg_3"];
    mediaView.allowMultipleSelection = NO;
    self.mediaView = mediaView;
    [mediaView observeViewHeight:^(CGFloat mediaHeight) {
        CGRect rect = headerView.frame;
        rect.size.height = CGRectGetMaxY(mediaView.frame);
        headerView.frame = rect;
    }];
    [mediaView observeSelectedMediaArray:^(NSArray<ACMediaModel *> *list) {
       // do something
        NSLog(@"list.count = %lu",(unsigned long)list.count);
    }];
    [headerView addSubview:mediaView];
    
    headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, CGRectGetMaxY(mediaView.frame));
    self.tableView.tableHeaderView = headerView;
}

- (IBAction)clickEditAction:(id)sender {
    UIBarButtonItem *bar = (UIBarButtonItem *)sender;
    if ([bar.title isEqualToString:@"编辑"]) {
        self.mediaView.showAddButton = YES;
        self.mediaView.showDelete = YES;
        [self.mediaView reload];
        [bar setTitle:@"预览"];
    }else {
        [bar setTitle:@"编辑"];
        self.mediaView.showAddButton = NO;
        self.mediaView.showDelete = NO;
        [self.mediaView reload];
    }
}

@end
