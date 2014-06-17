//
//  FLEXIvarEditorViewController.m
//  Flipboard
//
//  Created by Ryan Olson on 5/23/14.
//  Copyright (c) 2014 Flipboard. All rights reserved.
//

#import "FLEXIvarEditorViewController.h"
#import "FLEXFieldEditorView.h"
#import "FLEXRuntimeUtility.h"
#import "FLEXArgumentInputView.h"
#import "FLEXArgumentInputViewFactory.h"

@interface FLEXIvarEditorViewController ()

@property (nonatomic, assign) Ivar ivar;

@end

@implementation FLEXIvarEditorViewController

- (id)initWithTarget:(id)target ivar:(Ivar)ivar
{
    self = [super initWithTarget:target];
    if (self) {
        self.ivar = ivar;
        self.title = @"Instance Variable";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.fieldEditorView.fieldDescription = [FLEXRuntimeUtility prettyNameForIvar:self.ivar];
    
    FLEXArgumentInputView *inputView = [FLEXArgumentInputViewFactory argumentInputViewForTypeEncoding:ivar_getTypeEncoding(self.ivar)];
    inputView.backgroundColor = self.view.backgroundColor;
    inputView.targetSize = FLEXArgumentInputViewSizeLarge;
    inputView.inputValue = [FLEXRuntimeUtility valueForIvar:self.ivar onObject:self.target];
    self.fieldEditorView.argumentInputViews = @[inputView];
}

- (void)actionButtonPressed:(id)sender
{
    [super actionButtonPressed:sender];
    
    [FLEXRuntimeUtility setValue:self.firstInputView.inputValue forIvar:self.ivar onObject:self.target];
    self.firstInputView.inputValue = [FLEXRuntimeUtility valueForIvar:self.ivar onObject:self.target];
}

+ (BOOL)canEditIvar:(Ivar)ivar currentValue:(id)value
{
    return [FLEXArgumentInputViewFactory canEditFieldWithTypeEncoding:ivar_getTypeEncoding(ivar) currentValue:value];
}

@end
