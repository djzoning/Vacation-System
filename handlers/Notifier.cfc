component extends="coldbox.system.EventHandler" {

	// property name="Vacation" inject="Vacation";
	property name="Notifier" inject="services.Notifier";
	property name="messageBox" inject="messagebox@cbmessagebox";

	function preHandler() {
		prc.title = "";
		prc.smallTitle = "";
	}

	function notifyWeekly(event,rc,prc){
		Notifier.notifyWeekly();
		event.setView("Main/index");
	}

	function notifySick(event, rc, prc) {
		Notifier.notifySick(rc.id);
		messageBox.info("You have sent sick notification successfully.");
		setNextEvent("Dashboard.index");
	}
}
