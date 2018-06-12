//
// larsWare - French Press timer
//

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Timer as Timer;
using Toybox.Attention as Attention;

var timer1;
var dataColor = "";
var vibrateData = [ new Attention.VibeProfile( 50, 2000) ];
             
enum
    {
        WAIT,
        POUR1,
        POUR2,
        STEEP,
        DRINK
    }

var mTimerState = null;
var sTimerState = "";
var limitWait = 60;
var limitPour = 10;
var count = 0;
var limitSteep = 240;

class larsFrenchPressTimerView extends Ui.View {

    function initialize() {
    	//System.println("view: initialize");
        Ui.View.initialize();
        //System.println("view: exit initialize");
    }

    function callback1() {
        count -= 1;
        
        //TODO
        /*
        fill 1/2 press
        wait 1 min
        break crust/stir
        fill rest of press
        wait 4 min
        */
        //Transitions
        if ( mTimerState == POUR1 && count == 0 ) {
        	mTimerState = WAIT;
        	count = limitWait;
        	Attention.vibrate(vibrateData);
        } else if ( mTimerState == WAIT && count == 0 ) {
        	mTimerState = POUR2;
        	count = limitPour; 
        	Attention.vibrate(vibrateData);
        } else if ( mTimerState == POUR2 && count == 0 ) {
        	mTimerState = STEEP;
        	count = limitSteep;
        	Attention.vibrate(vibrateData);
        } else if ( mTimerState == STEEP && count == 0 ) {
        	mTimerState = DRINK;
        	count = 0;
        	timer1.stop();
        	Attention.vibrate(vibrateData);
        }
        
        Ui.requestUpdate();
    }

	function onLayout(dc) {
	}

    function startTimer() {
        timer1 = new Timer.Timer();
        timer1.start(method(:callback1), 1000, true);
        
        mTimerState = POUR1;
        count = limitPour;
        
        Attention.vibrate(vibrateData);
    }

    function onUpdate(dc) {
    	//System.println("view: onUpdate");
        var string;

		//! Select text color based on timer state.
        if( mTimerState == WAIT )
        {
             dataColor = Gfx.COLOR_RED;
             sTimerState = "Wait";
        }
        else if( mTimerState == POUR1 )
        {
            dataColor = Gfx.COLOR_ORANGE;
            sTimerState = "Fill half ";
        }
        else if( mTimerState == POUR2 )
        {
        	dataColor = Gfx.COLOR_YELLOW;
        	sTimerState = "Stir & fill";
        }
        else if( mTimerState == STEEP )
        {
            dataColor = Gfx.COLOR_WHITE;
            sTimerState = "Steep";
        }
        else if (mTimerState == DRINK )
        {
           dataColor = Gfx.COLOR_GREEN;
           sTimerState = "Drink";
        }
        else if (mTimerState == null )
        {
        	dataColor = Gfx.COLOR_BLUE;
        	sTimerState = "Press start";
        }

        //dc.setColor(dataColor, Gfx.COLOR_WHITE);
        //dc.clear();
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        dc.setColor(dataColor, Gfx.COLOR_TRANSPARENT);
        string = "Phase: " + sTimerState;
        dc.drawText(5, (dc.getHeight() / 2) - 30, Gfx.FONT_MEDIUM, string, Gfx.TEXT_JUSTIFY_LEFT);
        string = "Time: " + formatTime(count);
       	dc.drawText(5, (dc.getHeight() / 2), Gfx.FONT_MEDIUM, string, Gfx.TEXT_JUSTIFY_LEFT);
       // string = "Count: " + count3;
       // dc.drawText(40, (dc.getHeight() / 2) + 30, Gfx.FONT_MEDIUM, string, Gfx.TEXT_JUSTIFY_LEFT);
    }

	function formatTime(iTime) {
	
		if ( iTime < 60 ) {
			return iTime;
		}
			
		var iMin = iTime / 60;
		var iSec = iTime % 60;
		
		if (iSec < 10 ) { 
			iSec = "0" + iSec;
		}
		return iMin + ":" + iSec;	
	}
}
