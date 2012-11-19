console.log('Loading localh');
var page = require('webpage').create();
var url = 'http://localhost:3000';
page.open(url, function (status) {
    //Page is loaded!
    console.log('localh loaded');
    //app has to be running
    title = page.evaluate(function() {
  		return document.title;
	});
	console.log("title: "+title);	
    phantom.exit();
});