# Navigation BigShelf
A conversion of the [ASP.NET MVC BigShelf](http://www.asp.net/single-page-application/spa-samples/sample-bigshelf-application) single page application to ASP.NET Web Forms using the [Navigation for ASP.NET Web Forms](http://navigation.codeplex.com/) framework.


## Advantages of Web Forms BigShelf over MVC BigShelf
* Progressive Enhancement - It works even if JavaScript is disabled and provides enhanced Ajax functionality where available; the MVC version is dependent upon JavaScript and so is less accessible.

* Search Engine Optimization (SEO) friendly - Because it's built using the [Hijax](http://en.wikipedia.org/wiki/Hijax) technique, all hyperlinks have genuine URLs in their href attributes and so are crawlable; the MVC version isn't crawlable because its content is only accessible via JavaScript and there aren't any populated href attributes.

* User Friendly URLs - The URLs are all determined server side so Routing can be used; the MVC version produces URLs client side so Routing can't be used.

* Server Side Rendering - Because rendering is all server side, there's no delay when loading a bookmarked page; the MVC version's rendering is all client side so the initial load must wait for the JavaScript to download and execute. 