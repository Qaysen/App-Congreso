//
//  PartidosViewController.m
//  Diputados
//
//  Created by Arturo Jamaica Garcia on 19/03/13.
//
//

#import "PartidosViewController.h"
#import "PartidoCell.h"
#import "DiputadosViewController.h"

@interface PartidosViewController ()

@end

@implementation PartidosViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.className = @"PartidosP";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"text";
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
        // self.imageKey = @"image";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = NO;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 25;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // The className to query on
        self.className = @"PartidosP";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"nombre";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = NO;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 25;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - PFQueryTableViewController

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

/*
 // Override to customize what kind of query to perform on the class. The default is to query for
 // all objects ordered by createdAt descending.
 - (PFQuery *)queryForTable {
 PFQuery *query = [PFQuery queryWithClassName:self.className];
 
 // If Pull To Refresh is enabled, query against the network by default.
 if (self.pullToRefreshEnabled) {
 query.cachePolicy = kPFCachePolicyNetworkOnly;
 }
 
 // If no objects are loaded in memory, we look to the cache first to fill the table
 // and then subsequently do a query against the network.
 if (self.objects.count == 0) {
 query.cachePolicy = kPFCachePolicyCacheThenNetwork;
 }
 
 [query orderByDescending:@"createdAt"];
 
 return query;
 }
 */


 // Override to customize the look of a cell representing an object. The default is to display
 // a UITableViewCellStyleDefault style cell with the label being the textKey in the object,
 // and the imageView being the imageKey in the object.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
 static NSString *CellIdentifier = @"PartidoCell";
 
     PartidoCell *cell = (PartidoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (cell == nil) {
         cell = [[PartidoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
     }
     cell.nombre.text = [object objectForKey:@"nombre"];
     cell.numerodip.text = [NSString stringWithFormat:@"%@",[object objectForKey:@"num_dip"]];
     
     if([[object objectForKey:@"siglas"] isEqualToString:@"PRD"]){
         cell.imagen.image = [UIImage imageNamed:@"prd01.png"];
     }
     
     if([[object objectForKey:@"siglas"] isEqualToString:@"PRI"]){
         cell.imagen.image = [UIImage imageNamed:@"pri01.png"];
     }
     
     if([[object objectForKey:@"siglas"] isEqualToString:@"PAN"]){
         cell.imagen.image = [UIImage imageNamed:@"pan.png"];
     }
     
     if([[object objectForKey:@"siglas"] isEqualToString:@"PANAL"]){
         cell.imagen.image = [UIImage imageNamed:@"panal.gif"];
     }
     
     if([[object objectForKey:@"siglas"] isEqualToString:@"Verde"]){
         cell.imagen.image = [UIImage imageNamed:@"logvrd.jpg"];
     }
     
     if([[object objectForKey:@"siglas"] isEqualToString:@"Movimiento Ciudadano"]){
         cell.imagen.image = [UIImage imageNamed:@"logo_movimiento_ciudadano.png"];
     }
     
     if([[object objectForKey:@"siglas"] isEqualToString:@"PT"]){
         cell.imagen.image = [UIImage imageNamed:@"logpt.jpg"];
     }
     
     // Configure the cell
     //cell.textLabel.text = [object objectForKey:self.textKey];
     //cell.imageView.file = [object objectForKey:self.imageKey];
 
     return cell;
 }
 
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"partidos"]){
        NSIndexPath *index = [self.tableView indexPathForCell:sender];
        PFQuery *query = [PFQuery queryWithClassName:@"DiputadoP"];
        [query whereKey:@"fraccion" equalTo:[[self.objects objectAtIndex:index.row] objectForKey:@"siglas"]];
        [query setLimit:500];
        [query includeKey:@"entidad"];
        [query orderByDescending:@"nombre"];
        
        DiputadosViewController *vc = [segue destinationViewController];
        [vc setTitle:[[self.objects objectAtIndex:index.row] objectForKey:@"siglas"]];
        vc.showing = NO;
        [vc setQuery:query];
        
    }
}
/*
 // Override if you need to change the ordering of objects in the table.
 - (PFObject *)objectAtIndex:(NSIndexPath *)indexPath {
 return [self.objects objectAtIndex:indexPath.row];
 }
 */

/*
 // Override to customize the look of the cell that allows the user to load the next page of objects.
 // The default implementation is a UITableViewCellStyleDefault cell with simple labels.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *CellIdentifier = @"NextPage";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
 }
 
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
 cell.textLabel.text = @"Load more...";
 
 return cell;
 }
 */

#pragma mark - UITableViewDataSource

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the object from Parse and reload the table view
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, and save it to Parse
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
