//
//  NoticeViewController.m
//  RacPractice
//
//  Created by 王玲峰 on 2021/7/28.
//

#import "NoticeViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "UIViewController+ORStoryBoard.h"

@interface NoticeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *testTextField;
/** id */
//@property (nonatomic, strong) NSString *id;

/** id */
@property (nonatomic, assign) int id;
@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}
/** 普通的通知 */
- (void)normalNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
}
/** RAC的通知 */
- (void)racNotification{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"%@",x);
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.testTextField becomeFirstResponder];
}

- (void) keyboardWillShow:(NSNotification *)note {
    NSLog(@"键盘弹出了");
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];

}

ORStoryboard(notice)

@end
