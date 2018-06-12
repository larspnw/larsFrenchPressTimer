//
// larsWare
//

using Toybox.Application as App;

class larsFrenchPressTimerApp extends App.AppBase {

    function initialize() {
    	//System.println("app: initialize");
        App.AppBase.initialize();
        //System.println("app: exit initialize");
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
    	var mTimerView = new larsFrenchPressTimerView();
    	//System.println("app: getInitialView");
        //return [ new larsAeropressTimerView(), new InputDelegate() ];
        return [ mTimerView, new InputDelegate(mTimerView) ];
        
    }
}
