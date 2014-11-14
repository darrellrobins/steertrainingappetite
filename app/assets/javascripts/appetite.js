var ready;
ready = function () {
	// data for falafel shops in london
	// co-ordinates are easiest to get from bing maps
	var stores = [];

	$("ul li").each(function () {

		var store = {};
		store.location = [$(this).data("lat"), $(this).data("long")];
		store.title = $(this).find("h3").text();
		store.address = $(this).find("#pub_address").text();
		store.color = "red";
		stores.push(store);

	});

	// mapbox tiles
	var mapTiles = "https://a.tiles.mapbox.com/v3/steer.ijbel9hk/{z}/{x}/{y}.png";
	var map = L.map('map', {
		layers: new L.TileLayer(mapTiles)
	});

	var bounds = new L.LatLngBounds();

	for (var i = 0; i < stores.length; i++) {

		var store = stores[i];

		var markerIcon = L.icon({
			iconUrl: <%= asset_path( store.color + "marker.png")%>,
			iconSize: [60, 60],
			iconAnchor: [30, 60],
			popupAnchor: [0, -70]
		});

		var marker = L.marker(store.location, {	icon: markerIcon });
		marker.addTo(map);

		var popup = "<h3>" + store.title + "</h3><p>" + store.address + "</p>";
		marker.bindPopup(popup);

		bounds.extend(store.location);
	}



  if(bounds._northEast === undefined){
    map.fitBounds(bounds.extend([51.525319, -0.110153]));
  } else {
    map.fitBounds(bounds);
  }




}
var refresh_location;
refresh_location = function(){
	$("ul li").each(function () {
		full_address=$(this).find("#pub_address").val()
		ul=$(this).parent()
		alert(ul.find('li').data('lat','xxx'));
//		li.data('lat','ccc')
		$.ajax({
	        type: "GET",
	        url: "/geolocations/get?address="+full_address,
//	        data: "{'Address': '" + full_address + "'}",
	        contentType: "application/json; charset=utf-8",
	        dataType: "json",
	        success: function(data){ alert(data['lat']);ul.find('li').data('lat','1');alert('li good' + ul.find('li').data('lat'));ready();},
	        error: function(){ alert('li bad' + ul);}
	    });
	});
}
$(document).ready(ready);
$(document).on("page:load",ready);