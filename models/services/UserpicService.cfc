component {

	property name="CropService" inject="services.CropService";
	property name="Mailer" inject="services.Mailer";

	this.fileField = "userpic";
	this.directory = APPLICATION.files.server & "users/";
	this.allowedFileTypes = "jpg,jpeg,png";

	if (!DirectoryExists(this.directory)) DirectoryCreate(this.directory);

	function saveImage(user, coordinates) {
		if (FORM["#this.fileField#"] == "") {
			return "";
		}

		var filename = "image_" & user.getId();
		var file = FileUpload(
				destination = this.directory,
				nameConflict = "MakeUnique",
				fileField = this.fileField
			);
		FileDelete(file.serverDirectory & "/" & file.serverFile);
		if (ListFindNoCase(this.allowedFileTypes, file.serverFileExt)) {
			var name = "image_" & user.getId() & "." & file.serverFileExt;
			if (!IsNull(user.getImage()) && user.getImage() != "") {
				var currentUserImage = this.directory & user.getImage();
				FileDelete(currentUserImage);
			}

			var destination = this.directory & name;
			try {
				var file = FileUpload(
						destination = destination,
						nameConflict = "Error",
						fileField = this.fileField
					);
			} catch (any exception) {
				Mailer.sendErrorMail(exception);
			}
			
			CropService.cropImage(destination, coordinates);
			
			return file.serverFile;
		}

		return "";
	}
}
