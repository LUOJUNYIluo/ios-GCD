//
//  ViewController.m
//  ios GCD
//
//  Created by 天使 on 12/03/2019.
//  Copyright © 2019 天使. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self gcdDemo2];
}
//串行队列执行同步任务
/*
 *开启c线程吗   顺序执行吗‘
  不会         顺序执行
 */
- (void)gcdDemo1{
    //1.队列  --串行
    
    /*
     * 1.label 队列名称
       2.队列的属性  DISPATCH_QUEUE_SERIAL串行
     */
    dispatch_queue_t queue = dispatch_queue_create("queueA",NULL);
    
    //同步执行任务
    for (int i = 0; i<10; i++) {
        dispatch_sync(queue, ^{
            NSLog(@"%@",[NSThread currentThread]);
        });
    }
    
}
/*
 *串行队列异步任务
 */
- (void)gcdDemo2{
    //1.队列  --串行
    
    
    /**
     
     会开启几条线程？
     只能开启一条子线程
     因为在串行队列等待前面一个异步任务执行完了之后才会执行下一个任务智慧从GCD中拿一条线程
     
     */
    dispatch_queue_t queue = dispatch_queue_create("queueA",NULL);
    
    //同步执行任务
    for (int i = 0; i<10; i++) {
        NSLog(@"%d",i);
        dispatch_async(queue, ^{
            //等这步执行完之后才会执行come hear
            NSLog(@"%@ %d",[NSThread currentThread],i);
        });
    }
    //先执行  一般子线程和主线程的执行循序不太确定
    NSLog(@"come hear");
}
@end
