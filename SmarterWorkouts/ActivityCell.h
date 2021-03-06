#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ActivityFormDelegate;
@class Set;
@class Activity;
@class NSManagedObjectContext;

@interface ActivityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property(nonatomic, weak) NSObject <ActivityFormDelegate> *activityFormDelegate;
@property(nonatomic, strong) Activity *activity;
@property(nonatomic, strong) Set *selectedSet;
@property(nonatomic, strong) NSDictionary *formChangeOptions;

@property(nonatomic, strong) NSManagedObjectContext *context;

- (void)setSetToCopy:(Set *)set;

- (void)viewWillAppear;
@end