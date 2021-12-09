//
//  JHPermanentThread.m
//  runtime
//
//  Created by cao hua on 2021/12/9.
//

#import "JHPermanentThread.h"

@interface JHThread : NSThread

@end

@implementation JHThread

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end

@interface JHPermanentThread()
@property(nonatomic, strong) JHThread *innerThread;
@property(nonatomic, assign) BOOL isStopped;
@end

@implementation JHPermanentThread

- (instancetype)init {
    if (self = [super init]) {
        
        __weak typeof(self) weakSelf = self;
        
        self.innerThread = [[JHThread alloc] initWithBlock:^{
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
            
            while (weakSelf && !weakSelf.isStopped) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            };
        }];
    }
    return self;
}

- (void)run {
    if (!self.innerThread) {
        return;
    }
    [self.innerThread start];
}

- (void)excuteTask:(PermanentThread)task {
    if (!self.innerThread || !task) {
        return;
    }
    [self performSelector:@selector(innerTask:) onThread:self.innerThread withObject:(PermanentThread)task waitUntilDone:NO];
}

- (void)stop {
    if (!self.innerThread) {
        return;
    }
    [self performSelector:@selector(innerStop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)innerStop {
    self.isStopped = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}

- (void)innerTask: (PermanentThread)task {
    task();
}

@end
