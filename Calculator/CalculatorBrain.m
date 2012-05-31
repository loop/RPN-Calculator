//
//  CalculatorBrain.m
//  Calculator
//
//  Created by loop on 28/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;



- (NSMutableArray *)operandStack
{
    if(_operandStack == nil) _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
}

- (double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject){
    [self.operandStack removeLastObject];
    }
    return [operandObject doubleValue];
}

- (void)clearStack
{
    [self.operandStack removeAllObjects];
    
}

- (void)pushOperand:(double)operand
{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)performOperation:(NSString *)operation
{
    double result = 0;
    
    if([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand];
    } else if ([@"-" isEqualToString:operation]) {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    } else if ([@"/" isEqualToString:operation]) {
        double divisor = [self popOperand];
        if(divisor)result = [self popOperand] / divisor;
    } else if ([@"cos(x)" isEqualToString:operation]) {
        result = cos([self popOperand]);
    } else if ([@"sin(x)" isEqualToString:operation]) {
        result = sin([self popOperand]);
    } else if ([@"sqrt(x)" isEqualToString:operation]) {
        result = sqrt([self popOperand]);
    } else if ([@"±" isEqualToString:operation]) {
        result = [self popOperand] * -1;
    }
    [self pushOperand:result];
    
    return result;
}
@end
