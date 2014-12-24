#import "HistoryCellExpanded.h"
#import "Workout.h"
#import "UIImage+ColorFromImage.h"
#import "EditWorkoutDelegate.h"
#import "NSManagedObjectContext+MagicalRecord.h"
#import "NSManagedObjectContext+MagicalSaves.h"
#import "AllSetsDataSource.h"

@implementation HistoryCellExpanded

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.editButton setBackgroundImage:
                    [UIImage imageWithColor:[UIColor colorWithRed:155 / 255.0f green:84 / 255.0f blue:0 / 255.0f alpha:1.0f]]
                               forState:UIControlStateHighlighted];
    UIDatePicker *datePicker = [UIDatePicker new];
    [self.dateField setInputView:datePicker];
    [datePicker addTarget:self action:@selector(updateWorkoutDate:) forControlEvents:UIControlEventValueChanged];

    [self.allSetsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.allSetsTableView setBackgroundColor:[UIColor clearColor]];
}

- (void)updateWorkoutDate:(id)datePicker {
    self.workout.date = [datePicker date];
    [self.dateField setText:[self formattedDateForWorkout:self.workout]];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (void)setWorkout:(Workout *)workout {
    [super setWorkout:workout];
    [self.dateField setText:[self formattedDateForWorkout:workout]];
    UIDatePicker *picker = (UIDatePicker *) [self.dateField inputView];
    [picker setDate:workout.date];

    [AllSetsDataSource registerNibs:self.allSetsTableView];
    self.allSetsDataSource = [[AllSetsDataSource alloc] initWithWorkout:workout];
    [self.allSetsTableView setDataSource:self.allSetsDataSource];
    [self.allSetsTableView reloadData];

    NSInteger setsCount = [self.allSetsTableView numberOfRowsInSection:0];
    int rowHeight = 44;
    int rowsToShow = 3;
    [self.allSetsTableViewHeight setConstant:setsCount <= rowsToShow ? setsCount * rowHeight : rowsToShow * rowHeight + rowHeight / 2];
    [self layoutIfNeeded];
}

- (IBAction)editButtonTapped:(id)sender {
    [self.delegate editWorkout:self.workout];
}

@end