#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;

- (void)onClickBtn:(UIButton *)sender;
- (void)onClickBtnIcon:(UIButton *)sender;
- (void)showNotice:(NSString *)title content:(NSString *)content;
- (void)closePopup:(UIButton *)sender;
- (void)tapBlankClose:(UITapGestureRecognizer *)tap;

@end