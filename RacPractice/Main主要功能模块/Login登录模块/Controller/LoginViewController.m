//
//  LoginViewController.m
//  RacPractice
//
//  Created by 王玲峰 on 2021/7/28.
//

#import "LoginViewController.h"
#import "ReactiveObjC.h"

@interface LoginViewController ()
///<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end




@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RACSignal *viewDidAppearSignal = [self rac_signalForSelector:@selector(viewDidAppear:)];
    [viewDidAppearSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"RAC---%s", __func__);
    }];
    
    [self RACLogin];
    [self example1];
}

# pragma mark - RAC
- (void)RACLogin {
    //RACSiganl:信号类,一般表示将来有数据传递，只要有数据改变，信号内部接收到数据，就会马上发出数据。
    
    //combineLatest :将多个信号合并起来，并且拿到各个信号的最新的值,必须每个合并的signal至少都有过一次sendNext，才会触发合并的信号
    //rac_textSignal:监听文本框文字改变
    //RACStream:？
    RACSignal *enableSignal = [[RACSignal combineLatest:@[self.userTextField.rac_textSignal, self.pwdTextField.rac_textSignal]] map:^id _Nullable(id value) {
        return @([value[0] length] > 0 && [value[1] length ] > 6);
    }];
    
    self.loginButton.rac_command = [[RACCommand alloc]initWithEnabled:enableSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal empty];
    }];
}
// 信号量的统一
- (void)example1 {
    
    RACSignal *enableSignal = [[RACSignal combineLatest:@[self.userTextField.rac_textSignal, self.pwdTextField.rac_textSignal]] map:^id _Nullable(id value) {
        return @([value[0] length] > 0 && [value[1] length ] > 6);
    }];
    self.loginButton.rac_command = [[RACCommand alloc]initWithEnabled:enableSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSLog(@"clicked");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:[[NSDate date] description]];
                [subscriber sendCompleted];
            });
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }];
                                    
    [[[self.loginButton rac_command] executionSignals] subscribeNext:^(RACSignal<id> * _Nullable x) {
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@", x);
        }];
    }];
}


# pragma mark - 传统写法
/**
 传统写法UITextField
 遵守代理，<UITextViewDelegate>，
 userTextField.delegate = self
 pwdTextField.delegate = self
 //写上代理方法做操作判断
 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 */
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    NSString *s1 = self.userTextField.text;
//    NSString *s2 = self.pwdTextField.text;
//    if (textField == self.userTextField) {
//        s1 = str;
//    }else {
//        s2 = str;
//    }
//    if (s1.length > 0 && s2.length > 6) {
//        self.loginButton.enabled = YES;
//    }else {
//        self.loginButton.enabled = NO;
//    }
//    NSLog(@"系统方法---%@, %@", s1, s2);
//    return YES;
//}

ORStoryboard(Main)
@end
