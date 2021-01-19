//
//  ExtraViewControllers.m
//  CustomTabbarController
//
//  Created by Liu Jiang on 2017/9/29.
//  Copyright © 2017年 Liu Jiang. All rights reserved.
//

#import "ExtraViewController.h"

@interface ExtraViewController ()
@property (nonatomic, strong)CATransition *transition;
@end

static NSString * const CELLREUSEID = @"CELLREUSEID";
@implementation ExtraViewController
- (CATransition *)transition {
    if (!_transition) {
        _transition = [CATransition animation];
        _transition.duration = 1.0f;
        _transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        _transition.type = kCATransitionPush;
        _transition.subtype = kCATransitionFromRight;
    }
    return _transition;
}
- (NSMutableArray *)extraViewControllers {
    if (!_extraViewControllers) {
        _extraViewControllers = [NSMutableArray arrayWithCapacity:0];
    }
    return _extraViewControllers;
}
- (NSMutableArray *)extraTitles {
    if (!_extraTitles) {
        _extraTitles = [NSMutableArray arrayWithCapacity:0];
    }
    return _extraTitles;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    self.navigationItem.title = @"更多";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELLREUSEID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _extraViewControllers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLREUSEID forIndexPath:indexPath];
    cell.textLabel.text = self.extraTitles[indexPath.row];
    cell.textLabel.textColor = [UIColor grayColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.navigationController) {
        id childVC;
        if ([self.extraViewControllers[indexPath.row] isKindOfClass:[UINavigationController class]]) {
            Class ChildClass = [[self.extraViewControllers[indexPath.row] topViewController] class];
             childVC = [ChildClass new];
        }else {
            childVC = self.extraViewControllers[indexPath.row];
        }
        ((UIViewController *)childVC).view.backgroundColor = [UIColor whiteColor];
        ((UIViewController *)childVC).title = self.extraTitles[indexPath.row];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:childVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else {
        [self presentViewController:self.extraViewControllers[indexPath.row] animated:YES completion:nil];
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
