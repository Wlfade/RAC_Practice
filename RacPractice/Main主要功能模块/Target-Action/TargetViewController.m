//
//  TargetViewController.m
//  RacPractice
//
//  Created by 王玲峰 on 2021/6/2.
//

#import "TargetViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "UIViewController+ORStoryBoard.h"

@interface TargetViewController ()
@property (weak, nonatomic) IBOutlet UIButton *testBtn;

@end

@implementation TargetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.testBtn addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];
    
    
    [[self.testBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"%@",x);
    }];

    
  
}
- (void)Click{
    
}
ORStoryboard(Target)

//+ (NSString *)orilme_storyboardName{
//    return @"Main";
//}
@end
