#import "ActivityWeightFormViewController.h"
#import "Form.h"
#import "DecimalNumbers.h"
#import "WorkoutController.h"
#import "FlavorTextUITextField.h"
#import "WeightInputControls.h"
#import "UIImage+ColorFromImage.h"

@implementation ActivityWeightFormViewController

- (void)viewDidLoad {
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [WeightInputControls addLbsKgSelector:self.weightInput];
    self.form = [[Form alloc] initWithFields:@[self.repsInput, self.setsInput]];
    [self.form setDelegate:self];

    [self.weightInput addTarget:self action:@selector(weightChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.weightInput setDelegate:self];
    [self.weightInput setFlavor:@"lbs"];
    [self.weightInput setText:@""];


    [self.repsInput setDelegate:self];
    [self.repsInput setFlavor:@"reps"];

    [self.setsInput setDelegate:self];
    [self.setsInput setFlavor:@"sets"];

    self.addButton.layer.cornerRadius = 10;
    self.addButton.layer.borderWidth = 1;
    self.addButton.layer.borderColor = [self.addButton currentTitleColor].CGColor;

    [self.cancelButton                                        setBackgroundImage:[UIImage imageWithColor:
            [UIColor colorWithRed:0.851 green:0.325 blue:0.31 alpha:1]] forState:UIControlStateHighlighted];

    self.tapToSeePlatesLabel.alpha = 0;
    [self.weightInput becomeFirstResponder];
}

- (void)weightChanged:(id)weightChanged {
    NSDecimalNumber *weight = [DecimalNumbers parse:[self.weightInput text]];
    if ([weight compare:[NSDecimalNumber decimalNumberWithString:@"45"]] == NSOrderedDescending) {
        [UIView animateWithDuration:0.3 animations:^{
            self.tapToSeePlatesLabel.alpha = 1;
        }];
        [self.weightFormDelegate weightChanged:weight];
    }
    else {
        [UIView animateWithDuration:0.3 animations:^{
            self.tapToSeePlatesLabel.alpha = 0;
        }];
    }
}

- (IBAction)cancelButtonTapped:(id)sender {
    [self.weightFormDelegate formCanceled];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.weightInput) {
        NSDecimalNumber *weight = [DecimalNumbers parse:[self.weightInput text]];
        if ([weight compare:[NSDecimalNumber zero]] != NSOrderedSame) {
            [self.weightFormDelegate weightChanged:weight];
        }
    }
    else {
        [self.weightFormDelegate weightDoneEditing];
    }

    if ([textField isKindOfClass:FlavorTextUITextField.class]) {
        [((FlavorTextUITextField *) textField) removeFlavor];
    }

    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.weightInput) {
        [self.weightFormDelegate weightDoneEditing];
    }

    if ([textField isKindOfClass:FlavorTextUITextField.class]) {
        [((FlavorTextUITextField *) textField) addFlavor];
    }
}


- (void)attachBelow:(UIView *)parentView {
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView attribute:NSLayoutAttributeTop
                                                          multiplier:1 constant:0]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView attribute:NSLayoutAttributeLeft
                                                          multiplier:1 constant:0]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeRight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView attribute:NSLayoutAttributeRight
                                                          multiplier:1 constant:0]];
}

@end