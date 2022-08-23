## Königlich  Sächsische Triangulierung (KST) Säule  Netzwerk
KST is a simple Shiny App to interactively visualize a map of geodedic points and triangulation network of the former "Königlich  Sächsische Triangulierung (KST) Säule  Netzwerk".
Each point represent Triangulation point connected by a triangulation network.

## How to:
**Map Area**

In the upper right part of the map area you find the layer that can be selected:
Satellite & TopMap (Base Layers), Federal State of Saxony Boundary, Triangulation Point 1st and 2nd order and also the 1st and 2nd Triangulation Network.

Each point is clickable and has additional information regardin the Toponym, Sequential number of the point, Order (First or Second) and Elevation.
Elevation was automatical retrieved by querying the Digital Elevation Model (DEM) of Saxony (source: GeoSN https://www.geodaten.sachsen.de) with QGIS (https://qgis.org). Thus, Elevation might not be accurate due to DEM resolution.

The Triangulation Network similary to the Triangulation Points are clickable and show the distance between two Points in km.

**Slider**

The slider allows to filter the points in the Map Area (*Kart*e) within an elevation range.
The slider affect also the list of points in the Data table (*Datentabelle*).

**Data Table**

Data table (*Datentabelle*)  shows in a tabular manner the list of the triangulation points.
Each filed can be sorted and content can be searched.


### Requirements

- The package depends on: R (>= 3.6.0)

### Installing

To run the application clone the repository:

run the *Global.r*, *UI.r* and *server.r* files and then use the function *run_app()* in the R console or the *publish button* in RStudio


A stable online version is available here:

* [Triangulierung Browser](https://stefanodellachiesa.shinyapps.io/Koeniglich-Saechsische-Triangulierung-Browser/)


## Built With

* [R](https://www.r-project.org/) 
* [RStudio](https://rstudio.com/)
* [Shiny-Package](https://shiny.rstudio.com/)

## Author

**Stefano Della Chiesa** 

## Contributor

* [Giulio Genova](https://github.com/GiulioGenova) 



## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

