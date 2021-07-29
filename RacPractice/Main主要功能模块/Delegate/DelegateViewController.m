//
//  DelegateViewController.m
//  RacPractice
//
//  Created by 王玲峰 on 2021/6/2.
//

#import "DelegateViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "UIViewController+ORStoryBoard.h"

@interface DelegateViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation DelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
 
    self.textField.delegate = self;
    
    [[self rac_signalForSelector:@selector(textFieldDidBeginEditing:) fromProtocol:@protocol(UITextFieldDelegate)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"%@",x);
    }];
}
ORStoryboard(delegate)

@end
