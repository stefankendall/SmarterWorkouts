#import "SetCell.h"
#import "Set.h"

@implementation SetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *bgColorView = [UIView new];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:57/255.0f green:139/255.0f blue:255/255.0f alpha:1.0f]];
    [self setSelectedBackgroundView:bgColorView];
}

- (void)setSet:(Set *)set {
    _set = set;
    [self.activityLabel setText:set.activity];
    [self.repsLabel setText:[NSString stringWithFormat:@"%@x", set.reps]];
    [self.weightLabel setText:[NSString stringWithFormat:@"%@%@", set.weight, set.units]];
}

@end