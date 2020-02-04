## Königlich  Sächsische Triangulierung (KST) Säule  Netzwerk
KST is a simple Shiny App to interactively visualize a map of geodedic points and triangulation network.
Each point represent Triangulation point connected by a triangulation network.

A stable online version is available here:
https://stefanodellachiesa.shinyapps.io/Koeniglich-Saechsische-Triangulierung-Browser/

## How to:

In the upper right part of the map area you find the layer that can be selected:
Satellite, TopMap, Sachsen boundary, Triangulation Point 1st and 2nd order and also the triangulation netowrk for the 1st and 2nd order.

There are two different triangulation points:
First Order points (1. Ordnung) and Second Order points (2. Ordnung).
Each point is clickable and has additional information regardin the Toponym, Sequential number of the point, Order(First or Second) and Elevation.
Elevation was automaticall retrieved by querying the Digital Elevation Model (DEM) of Saxony (source: GeoSN https://www.geodaten.sachsen.de) with QGIS (https://qgis.org). Thus, Elevation might not be accurate due to DEM resolution.

The Triangulatino Network similary to the Triangualtion Points (Säule) are clickable and show the distance between two Points in km.


## Getting Started


get coordiantes of the points via data("KSTS_1_2ord.csv")
query points by elevation 
interactive markes with infos, hyperlink to video and photos.
One Paragraph of project description goes here
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them

```
Give examples
```

### Installing

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
