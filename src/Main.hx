package;


import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.media.Sound;
import flash.media.SoundChannel;
//import flash.media.SoundTransform;
import openfl.Assets;


class Main extends Sprite {
	
	
	private var background:Sprite;
	private var channel:SoundChannel;
	private var playing:Bool;
	private var position:Float;
	private var sound:Sound;
	
	
	public function new () {
		
		super ();
		
		background = new Sprite ();
		background.graphics.beginFill (0x3CB878);
		background.graphics.drawRect (0, 0, stage.stageWidth * 0.5, stage.stageHeight * 0.5);
		background.alpha = 0.5;
		background.buttonMode = true;
		background.addEventListener (MouseEvent.MOUSE_DOWN, this_onMouseDown);
		addChild (background);
		
		#if flash
		sound = Assets.getSound ("assets/testsound.wav");
		#else
		sound = Assets.getSound ("assets/testsound.ogg");
		#end
		
		position = 0;
		
		play ();
		
	}
	
	
	private function pause ():Void {

		trace("private function pause() was called ... ");

		if (playing) {
			
			playing = false;	
			position = channel.position;
			channel.removeEventListener (Event.SOUND_COMPLETE, channel_onSoundComplete);
			channel.stop ();
			channel = null;
		}
		
	}
	
	
	private function play ():Void {

		trace("private function play() was called ... ");
		
		playing = true;

		channel = sound.play (position);	
		channel.addEventListener (Event.SOUND_COMPLETE, channel_onSoundComplete);		
	}
	
	
	
	
	// Event Handlers
	
	private function channel_onSoundComplete (event:Event):Void {
		
		pause ();
		position = 0;
		
	}
	
	
	private function this_onMouseDown (event:MouseEvent):Void {
		
		if (channel == null) {
			
			play ();
			
		} else {
			
			pause ();
			
		}	
	}	
}