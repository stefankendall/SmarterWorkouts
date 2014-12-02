#import <UIKit/UIKit.h>
#import "WeightActivityFormDelegate.h"
#import "ContextHolderViewController.h"
#import "ActivitySelectorDelegate.h"

@class PlateViewController;
@class ContextViewController;
@class ActivityWeightFormCell;
@class Workout;
@class Set;

@interface WorkoutController : UITableViewController <UITextFieldDelegate, ActivitySelectorDelegate, WeightActivityFormDelegate> {
}
@property(nonatomic, strong) Workout *workout;
@property(nonatomic, strong) Activity *selectedActivity;
@property(nonatomic, strong) Set *selectedSet;
@end
