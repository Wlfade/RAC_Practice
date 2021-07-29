//
//  KVOViewController.m
//  RacPractice
//
//  Created by 王玲峰 on 2021/6/2.
//

#import "KVOViewController.h"
#import "TestModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "UIViewController+ORStoryBoard.h"

@interface KVOViewController ()
@property (strong, nonatomic) TestModel *testModel1;
@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testModel1 = [[TestModel alloc] init];
    self.testModel1.age = 1;
    self.testModel1.height = 11;
    
    
//    // 给person1对象添加KVO监听
//    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
//    [self.testModel1 addObserver:self forKeyPath:@"age" options:options context:@"123"];
    
//    [RACObserve(self.textField, text) subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
//    self.textField.text = @"凡几多";
    [RACObserve(self.testModel1, age)subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    
    
    
    TestModel *model1 = [[TestModel alloc] init];
    model1.age = 1;
    model1.height = 11;
    
    TestModel *model2 = [[TestModel alloc] init];
    model2.age = 2;
    model2.height = 22;
    
    
    TestModel *model3 = [[TestModel alloc] init];
    model3.age = 3;
    model3.height = 33;
    
    NSArray *array = @[model1,model2,model3];
//    [array.rac_sequence.signal subscribeNext:^(TestModel * _Nullable x) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"%@",[NSThread currentThread]);
//            NSLog(@"%d",x.age);
//        });
//    }];
    
    
    
    __block NSString * string = @"LJ";

    //创建一个全局队列

    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);

    //创建一个信号量（值为0）

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    dispatch_async(queue, ^{

        [array.rac_sequence.signal subscribeNext:^(TestModel * _Nullable x) {
            NSLog(@"%d",x.age);
        }];
        dispatch_semaphore_signal(semaphore);

        
        [array enumerateObjectsUsingBlock:^(TestModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%d",obj.age);
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"1111");

    });

    
    
//    [[RACSignal interval:2.0 onScheduler:[RACScheduler mainThreadScheduler]]subscribeNext:^(NSDate * _Nullable x) {
//        NSLog(@"%@",x);
//        NSLog(@"%@",[NSThread currentThread]);
//
//    }];
//
//    [[RACSignal interval:2.0 onScheduler:[RACScheduler schedulerWithPriority:RACSchedulerPriorityHigh name:@"abc"]] subscribeNext:^(NSDate * _Nullable x) {
//        NSLog(@"%@",[NSThread currentThread]);
//    }];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    self.testModel1.age = 20;
//
//    self.testModel1.height = 30;
//}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    TestModel *model1 = [[TestModel alloc] init];
    model1.age = 1;
    model1.height = 11;
    
    TestModel *model2 = [[TestModel alloc] init];
    model2.age = 2;
    model2.height = 22;
    
    
    TestModel *model3 = [[TestModel alloc] init];
    model3.age = 3;
    model3.height = 33;
    
    NSArray *array = @[model1,model2,model3];
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.concurrent", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"🔞 START: %@", [NSThread currentThread]);
    dispatch_async(concurrentQueue, ^{
        [array.rac_sequence.signal subscribeNext:^(TestModel * _Nullable x) {
            NSLog(@"%@",[NSThread currentThread]);
            NSLog(@"%d",x.age);
        }];
    }); // ⬅️ 任务一
    dispatch_barrier_async(concurrentQueue, ^{ sleep(3); NSLog(@"🚥🚥 %@", [NSThread currentThread]);}); // ⬅️ Barrie 任务
    dispatch_async(concurrentQueue, ^{ NSLog(@"111");}); // ⬅️ 任务四
    NSLog(@"🔞 END: %@", [NSThread currentThread]);
    
}

ORStoryboard(KVO)


@end
