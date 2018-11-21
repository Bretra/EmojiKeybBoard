//
//  NSString+Regular.m
//  KeyboardForChat
//
//  Created by VillageMud on 2018/11/20.
//  Copyright © 2018 ruofei. All rights reserved.
//

#import "NSString+Regular.h"

@implementation NSString (Regular)

- (NSTextCheckingResult *)firstMacthWithPattern:(NSString *)pattern
{
    //正则表达式的创建很容易失败，注意捕获错误
    NSError *error = nil;
    //根据正则表达式创建实例
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if ( error)
    {
        NSLog(@"正则表达式创建失败");
        
        return nil;
    }
    //匹配出结果
    NSTextCheckingResult *result =   [regular firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    
    if ( result)
    {
        NSLog(@"匹配");
        return result;
    }else
    {
        NSLog(@"不匹配");
        return nil;
    }
}

- (NSArray <NSTextCheckingResult *> *)machesWithPattern:(NSString *)pattern
{
    NSError *error = nil;
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if (error)
    {
        NSLog(@"正则表达式创建失败");
        return nil;
    }
    return [expression matchesInString:self options:0 range:NSMakeRange(0, self.length)];
}

@end
