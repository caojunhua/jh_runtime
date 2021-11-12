//
//  ViewController.m
//  runtime
//
//  Created by cao hua on 2021/11/12.
//

#import "ViewController.h"
#import "JHPerson.h"
#import "NSObject+myJson.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *json = @{
        @"age" : @18,
        @"height" : @180,
        @"name" : @"Rose"
    };
    
    JHPerson *person = [JHPerson jh_objectWithJson:json];
    
    
    NSLog(@"end");
    
}


@end
