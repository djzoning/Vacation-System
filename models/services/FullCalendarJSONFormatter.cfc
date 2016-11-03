component output="false" displayname="JSONFormatter" implements="models.services.IFormatter" {

	status = {
		pending: "pending",
		approved: "approved"
	};

	colors = {
		1: "",
		2: "ForestGreen",
		3: "HotPink",
		4: "tomato"
	};

	public function init() {
		return this;
	}

	public function format(array collection) {
		// FORMAT THE DATE AND ADD A DAY TO MATCH THE END
		var vacations = [];
		for (var item in collection) {
			var vacation = {};
			var type = {};
			type["id"] = item.getType().getId();
			type["name"] = item.getType().getName();
			var status = {};
			status["id"] = item.getStatus().getId();
			status["name"] = item.getStatus().getCategory();
			var team = {};
			team["id"] = item.getUser().getTeam().getId();
			team["name"] = item.getUser().getTeam().getName();

			vacation["id"] = item.getId();
			vacation["start"] = DateFormat(item.getFromDate(), "yyyy-mm-dd");
			vacation["end"] = DateFormat(DateAdd('d', 1, item.getToDate()), "yyyy-mm-dd");
			vacation["title"] = getTitle(item);
			vacation["className"] = getClassNames(item);
			vacation["type"] = type;
			vacation["status"] = status;
			vacation["team"] = team;

			ArrayAppend(vacations, vacation);
		}

		var serializedCollection = serializeJSON(vacations);

		return serializedCollection;
	}

	private function getTitle(vacation) {
		return ARGUMENTS.vacation.getUser().getFirstName() & " - " & ARGUMENTS.vacation.getType().getName() & " Leave";
	}

	private function getColor(vacation) {
		return colors[ARGUMENTS.vacation.getType().getId()];
	}

	private function getClassNames(vacation) {
		var classNames = [
			"vacation-event",
			"vacation-event-#vacation.getType().getName()#",
			"vacation-event-#vacation.getStatus().getCategory()#"
		];
		return classNames;
	}
}
