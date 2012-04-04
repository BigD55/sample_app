function preview(obj) {
	if (obj.innerHTML)
		closePreview(obj);
	if (obj.href)
		var src = obj.href;
	else
		return false;
	var iframe = document.createElement("iframe");
	iframe.src = src;
	iframe.id = "iframe_" + obj.innerHTML;
	iframe.style.height = "200px";
	iframe.style.width = "400px";
	iframe.style.whiteSpace = "nowrap";
	iframe.style.position = "absolute";
	// Next line takes the number value of link.style.bottom (decimals included) and converts it to a number
	var botPad = /^(\d*[^(px)])*/.exec(obj.style.bottom)[0] / 1;
	botPad += 20; // Amount of px above link
	iframe.style.bottom = botPad + "px";
	document.body.insertBefore(iframe, obj);
}
function closePreview(obj) {
	if (obj.innerHTML)
		var id = "iframe_" + obj.innerHTML;
	else
		return false;
	if (document.getElementById(id)) {
		var iframe = document.getElementById(id);
		iframe.parentNode.removeChild(iframe);
	}
}

