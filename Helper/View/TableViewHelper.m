#import "TableViewHelper.h"
#import "ViewHelper.h"


@implementation TableViewHelper


+(NSIndexPath*) getLastIndexPath: (UITableView*)tableView
{
    NSInteger lastSection = tableView.numberOfSections - 1;
    return [self getLastIndexPath: tableView inSection:lastSection];
}

+(NSIndexPath*) getLastIndexPath: (UITableView*)tableView inSection:(NSUInteger)section
{
    NSInteger lastRow = [tableView numberOfRowsInSection: section] - 1;
    return [NSIndexPath indexPathForRow: lastRow inSection:section];
}



+(NSIndexPath*) getIndexPathByCellSubView:(UIView*)subView
{
    UITableViewCell* cell = [TableViewHelper getTableViewCellBySubView: subView];
    UITableView* tableView = [TableViewHelper getTableViewBySubView: subView];
    NSIndexPath* indexPath = [tableView indexPathForCell: cell];
    return indexPath;
}



+(UITableViewCell*) getTableViewCellBySubView:(UIView*)subview
{
    return (UITableViewCell*)[ViewHelper getSuperView: subview clazz:[UITableViewCell class]];
}



+(UITableView*) getTableViewBySubView: (UIView*)subView
{
    return (UITableView*)[ViewHelper getSuperView:subView clazz:[UITableView class]];
}



@end
