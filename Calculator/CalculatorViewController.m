//
//  CalculatorViewController.m
//  Calculator
//
//  Created by loop on 28/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userInTheMiddleOfEnteringANumber;
@property (nonatomic,strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize brainContent = _brainContent;
@synthesize userInTheMiddleOfEnteringANumber = _userInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

-(CalculatorBrain *)brain
{
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = sender.currentTitle;
    if(self.userInTheMiddleOfEnteringANumber) {
    self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userInTheMiddleOfEnteringANumber = YES;
    }
}

- (void)showBrainContent:(NSString *) text {
    self.brainContent.text = [self.brainContent.text stringByReplacingOccurrencesOfString:@"= " withString:@""];
    self.brainContent.text = [self.brainContent.text stringByAppendingString:[NSString stringWithFormat:@"%@ ", text]];
}

- (IBAction)enterPressed
{
    if([self.display.text isEqualToString:@"π"]){
        [self.brain pushOperand:[[NSNumber numberWithDouble:M_PI] doubleValue]];
    }else{
        [self.brain pushOperand:[self.display.text doubleValue]];
    }
    self.userInTheMiddleOfEnteringANumber = NO;
    [self showBrainContent:self.display.text];

}

- (IBAction)clearPressed:(UIButton *)sender {
    self.display.text = @"0";
    self.brainContent.text = @"";
    [self.brain clearStack];
}


- (IBAction)backspacePressed:(UIButton *)sender {
    self.display.text = [self.display.text substringToIndex:[self.display.text length] - 1];
    if([self.display.text isEqualToString:@""]){
        self.display.text = @"0";
        self.userInTheMiddleOfEnteringANumber = NO;
    }
}


- (IBAction)operationPressed:(UIButton *)sender
{ 
    if (self.userInTheMiddleOfEnteringANumber) [self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *operation = [sender currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
    [self showBrainContent:[operation stringByAppendingString:@" ="]];
}

- (IBAction)decimalPressed:(UIButton *)sender {
    NSString *currentText = self.display.text;  
    NSRange checkForDecimal = [currentText rangeOfString:@"."];
    if(checkForDecimal.location == NSNotFound)
    {
        NSString *point = sender.currentTitle;
        if(self.userInTheMiddleOfEnteringANumber) {
            self.display.text = [self.display.text stringByAppendingString:point];
            [self showBrainContent:point];
        } else {
            self.display.text = point;
            self.userInTheMiddleOfEnteringANumber = YES;
        }

    }
}

- (IBAction)changeSignPressed:(UIButton *)sender {
    if (self.userInTheMiddleOfEnteringANumber) {
        if([[self.display.text substringToIndex:1] isEqualToString:@"-"]) {
            self.display.text = [self.display.text substringToIndex:-1];
        } else {
            self.display.text = [@"-" stringByAppendingString:self.display.text];
        }
    } else {
        [self operationPressed:sender];
    }
}


@end
