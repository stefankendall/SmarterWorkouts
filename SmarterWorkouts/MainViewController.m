#import "MainViewController.h"
#import "UIImage+ColorFromImage.h"
#import "UIImageViewHelper.h"
#import "UIImageHelper.h"

@implementation MainViewController {
    __weak IBOutlet UIImageView *historyImage;
    __weak IBOutlet UIImageView *workoutImage;
    __weak IBOutlet UIImageView *friendsImage;
    __weak IBOutlet UILabel *friendsLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.workoutButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:(CGFloat) (6 / 255.0)
                                                                                   green:(CGFloat) (101 / 255.0)
                                                                                    blue:(CGFloat) (162 / 255.0)
                                                                                   alpha:1.0]]
                                  forState:UIControlStateHighlighted];

    [self.historyButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:(CGFloat) (92 / 255.0)
                                                                                   green:(CGFloat) (179 / 255.0)
                                                                                    blue:(CGFloat) (78 / 255.0)
                                                                                   alpha:1.0]]
                                  forState:UIControlStateHighlighted];

    [self.friendsButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:(CGFloat) (98 / 255.0)
                                                                                   green:(CGFloat) (20 / 255.0)
                                                                                    blue:(CGFloat) (131 / 255.0)
                                                                                   alpha:1.0]]
                                  forState:UIControlStateHighlighted];
    [UIImageViewHelper makeWhite:historyImage];
    [UIImageViewHelper makeWhite:workoutImage];
    [UIImageViewHelper makeWhite:friendsImage];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationItem.title = @"Home";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (delayInSeconds * NSEC_PER_SEC));
    __weak id weakself = self;
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        [weakself animateWorkoutImage];
    });
}

- (void)animateWorkoutImage {
    UIImage *downImage = [UIImageHelper image:[UIImage imageNamed:@"415-weightlifter-inverse.png"] withColor:[UIColor whiteColor]];
    workoutImage.animationImages = @[
            [UIImageHelper image:[UIImage imageNamed:@"415-weightlifter.png"] withColor:[UIColor whiteColor]],
            downImage,
            downImage,
            downImage
    ];
    workoutImage.animationDuration = 1;
    workoutImage.animationRepeatCount = 10;
    [workoutImage startAnimating];
}

- (IBAction)selectHistory:(id)sender {
    [self loadStoryboard:@"HistoryViewController"];
}

- (IBAction)selectWorkout:(id)sender {
    [self loadStoryboard:@"Workout"];
}

- (IBAction)selectFriends:(id)sender {
}

- (void)loadStoryboard:(NSString *)nibName {
    UIStoryboard *historyStoryboard = [UIStoryboard storyboardWithName:nibName bundle:[NSBundle mainBundle]];
    UIViewController *controller = [historyStoryboard instantiateInitialViewController];
    [self.navigationController pushViewController:controller animated:YES];
}

@end