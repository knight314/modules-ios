#import <UIKit/UIKit.h>

@interface TableViewHelper : NSObject

+(NSIndexPath*) getLastIndexPath: (UITableView*)tableView;

+(NSIndexPath*) getLastIndexPath: (UITableView*)tableView inSection:(NSUInteger)section;



+(NSIndexPath*) getIndexPathByCellSubView:(UIView*)subView;


// get cell by cell's subview
+(UITableViewCell*) getTableViewCellBySubView:(UIView*)subview;



+(UITableView*) getTableViewBySubView: (UIView*)subView;



@end
