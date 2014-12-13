#import <UIKit/UIKit.h>
#import "ActivitySelectorDelegate.h"
#import "NewActivitySelectorInputViewController.h"

@class WorkoutController;
@protocol ActivitySelectorDelegate;
@class Activity;

@interface ActivitySelectorInputViewController : NewActivitySelectorInputViewController <UITextFieldDelegate, ActivitySelectorDelegate>
@property(nonatomic, strong) Activity *repeatActivity;
@end