The main view for the Choice Exchange application:
	*Select a "Home" currency in the left picker
	*Select a "Foreign" currency in the right picker
	*On any change to the picker, a query will be sent to yahoo finances. A query is also sent if the user presses the "Update" button.
	*Queries sent while waiting for a response from any previous will probably overwrite the others.
	*If the text field is changed, the user must press Update to send the next query.
	*A click anywhere outside of the text field will halt editing.
	*The exchange rate between the two selected currencies will be multiplied by the number provided by the user in the text field above the '=' sign, aka the "Home Number Field" -> this final value will be placed in the label below the '=' sign, representing how many of the Foreign currency the Home currency is worth.
	*Pressing the "View/Save favorites" button takes the user to the other view.

The view/save favorites view of the application:
	*Currencies can be selected as a foreign or home currency, but these choices are mutually exclusive.
	*As soon as any switch is toggled, the user's current favorites are all saved to a file, which is loaded upon subsequent reloads of the application.
