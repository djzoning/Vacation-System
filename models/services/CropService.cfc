component {

	function cropImage(imagePath, coordinates) {
		var image = ImageNew(imagePath);
		ImageScaleToFit(image, 300, 300);
		ImageCrop(image, coordinates.x, coordinates.y, coordinates.width, coordinates.height);
		cfimage(action = "write", destination = imagePath, source = image, overwrite = true);
	}
}
