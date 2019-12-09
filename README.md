# VirtualTourist


VirtualTourist an application that would load photos from Flickr depend on specific coordinates  depend on the user's choice.

On other word, the user would be able to drop a pin at specific location on the map and view the public photos from Flickr of that location. 
The user will be able to delete and reload the photos of the location; of course the results of the loaded photos would not be the same every time. 

In addition, the user will have the ability to create Memes using the uploaded photos and share them with his friends and social community.


## How to use it when run:

### On the Map:
* Long press on any location you desire on the Map
* The view will change to the photo collection where a collection of photos would load from **Flick**

### Photo Collection 
The application will load photos as long as there was internet connection.

The photos could be deleted __*be long press on the photo*__, or viewed by __*clicking the photo*__.




### Photo viewer

On the viewer you could create Meme using the viewed photo. In order to create Meme, please click **Meme** on the navigation bar 


**The map view holds "Meme" bar tap** your created **_Memes_** will be available in there 


## Minimum Requirement to run the application:

* iOS 11.0
* Internet connection



## Building the application:

The application was created using Xcode. The storyboard is not used in the application; for that, the code in **AppDelegate.swift** will lunch the first view controller **TravelLocationMapViewController**


         let vc = TravelLocationMapViewController()
                vc.dataController = dataController

                let nav = UINavigationController(rootViewController: vc)
                window = UIWindow(frame: UIScreen.main.bounds)
                window?.makeKeyAndVisible()

                window?.rootViewController = nav
                
During building, the application would attempt to read data from UserDefault if the data exist; if so, the application will
update the map to reflect the user's last viewed location on the map.

The keys (String) for the UserDefault items could be found in the **enum UserDefaultKeys**

### Data
There are two type of Models in this application, Codeable structs and CoreData.

#### Codeable Structs
The structs are used to gather information from **Flickr**, images of a specific location, and Meme initiation. 

#### Coredata
Coredata contains three Entities, two are related, Location and Photos, and Memes
**Location** is the Pin the user would drop on the map to gain photo gallery from Flickr
For ever **Location** there are multiple **Photos**
**Photos** is the URL and the thumbnail of the original photo form Flickr

**Memes** holds the Memes photos the user will create via the application 


