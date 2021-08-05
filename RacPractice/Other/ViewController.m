//
//  ViewController.m
//  RacPractice
//
//  Created by 王玲峰 on 2021/6/1.
//

#import "ViewController.h"
#import "UIViewController+ORStoryBoard.h"

@interface ViewController ()
@property (nonatomic, copy) NSArray *meunArr;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.meunArr = @[@"TargetViewController", @"DelegateViewController",@"RACSubjectVC", @"KVOViewController",@"NoticeViewController",@"TestViewController",@"LoginViewController",@"SliderViewController",@"RACCommandVC",@"RACMulticastConnectionVC",@"RACMacroVC",@"RACExampleOneVC", @"RACBindMethodVC", @"RACMapMethodVC", @"RACCombineMethodVC", @"RACFilterMethodVC", @"RACOrderMethodVC", @"RACTimeMethodVC", @"RACRepeatMethodVC", @"RACSchedulerMethodVC", @"LoginExampleVC", @"RACNetWorkExampleVC"];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.meunArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text =  self.meunArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = NSClassFromString(self.meunArr[indexPath.row]).orilme_viewController;
    vc.title = self.meunArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

//ORStoryboard(ViewController)
@end
