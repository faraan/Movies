
# Movies application made for Careem assignment test.

Project consist of -

Splace screen -
        Splash screen made from LaunchScreen.storyboard file
        
Home screen is SearchMovieViewController screen -
        User can search for any movie with name .
        App calls sample api to get movie list and displayed in table view 
        Paging is done as when user scrolls to bottom of tableview next page is loaded if available.
        10 successfull queries are saved FIFO manner to display list of suggestion to load from previously searched query.
        When there is no search result then an alert will appear.
        An empty view is also displayed initially.
        
SearchResultsViewController - 
        Loads and displays list of suggestion of 10 previously searched successful queries
        Selecting any suggestion will list its searched result in Home screen.
        
        
External libraries used - 
        NVActivityIndicatorView - for loading activity indicator 
        Kingfisher    - for image cache and download from url 

