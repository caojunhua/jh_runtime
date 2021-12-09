//
//  JHPermanentThread.h
//  runtime
//
//  Created by cao hua on 2021/12/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^PermanentThread)(void);

@interface JHPermanentThread : NSObject

- (void)run;

- (void)excuteTask: (PermanentThread)task;

- (void)stop;

@end

NS_ASSUME_NONNULL_END
