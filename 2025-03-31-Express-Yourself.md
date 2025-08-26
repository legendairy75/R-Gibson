# Express(.js) Yourself
In the world of web development there are many things to learn, on of such things is expressjs
- express is a fast, unopinionated, minimalistic web framework for node
Its primary use is for routing, allowing you to connect pages and scripts. for instance:
	
Express has 5 main features:
- routing: how an app responds to a request
- middle ware: functions that can access request and response
- timplating language: for generating static sites
- extensible: using middle ware to customize the functions of the app
- error handling: stopping an error from crashing an app
---
## Routing
if your on facebook.com and click the 'profile' button you get directed to a new page, that page being something like facebook.com/profile. behind the seen express sees 'facebook.com' as '/',the 'home' page and facebook.com/profile as /profile. then in the home page the 'profile' button links to /profile and when you click it express looks through its list of routs till it finds one with the right name, then executes the function in it.
```js
app.get('/'. (req, res) => {
	res.render(/*file name*/);
});
```
In this example, `app.get` tells Express to render *file name* when directed to `'/'`.
## Middleware
Middleware are functions that have access to the request and response objects and next function witch exicutes the next middleware after it.
```js
const middleware = (req, res, next) => {
// code here
	next();
}
```
Then you can use it in your routs
```js
app.get('/', middleware, (req,res) => {
// code here
})
```
Or load it every time the app receives a request with `app.use(middleware);
## Template language
A template language uses javascript to create a *timplate* for dinamic content that renders as html.
There are many template languages like Pug and handlebars, but most use Embeded Javascript Timplate, or (EJS). 
## Extensible
With middleware expresses functionality can be extended, for example if I had middleware like this
```js
const helloWorld = ((req, res, next) => {
	console.log('Hello World');
	next();
}
```
I could then place it in my  main rout like this
```js
app.get('/', helloWorld, (req, res) =>{
console.log('get recieved');
})
```
Then when I go to `/` and look at the console I would see 'Hello World' printed out followed by 'get received'. 
## Error handling
This is how express catches & handles errors, It basically operates as a middleware on its own but using the `(err, req, res, next)` inputs rather than `(req, res, next)`.

---
## Conclusion
Express is a nodejs framework that is lightweight and extensible with the essential tools needed for a website and the ability to add and build your own through middleware