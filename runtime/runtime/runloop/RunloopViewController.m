//
//  RunloopViewController.m
//  runtime
//
//  Created by cao hua on 2021/12/9.
//

#import "RunloopViewController.h"
#import "JHPermanentThread.h"

@interface RunloopViewController ()
@property(nonatomic, strong) JHPermanentThread *permThread;
@end

@implementation RunloopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.permThread = [[JHPermanentThread alloc] init];
    [self.permThread run];
}

- (IBAction)clickStop:(id)sender {
    [self.permThread stop];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.permThread excuteTask:^{
        NSLog(@"--点击--%@",[NSRunLoop currentRunLoop]);
    }];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    [self.permThread stop];
}

@end
