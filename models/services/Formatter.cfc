component output="false" displayname="Formatter" {

	public function init() {
		return this;
	}

	function format(array collection, IFormatter formatter) {
		var data = formatter.format(collection);
		return data;
	}
}