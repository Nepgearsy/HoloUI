var imageCount = 1;
var total = 6;

function slider(x) {
	var image = document.getElementById('image');
	imageCount = imageCount + x;
	if(imageCount > total){imageCount = 1;}
	if(imageCount < 1){imageCount = total;}	
	image.src = "img/img1"+ imageCount +".png";
	}
	